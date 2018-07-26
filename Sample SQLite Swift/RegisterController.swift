//
//  RegisterController.swift
//  Sample SQLite Swift
//
//  Created by Rahmat Hidayat on 7/26/18.
//  Copyright © 2018 Rahmat Hidayat. All rights reserved.
//

import UIKit
import SQLite

class RegisterController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnRegister.layer.cornerRadius = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        self.checkEmailExist()
    }
    
    func checkEmailExist(){
        let filter = Model.tbUsers.filter(Model.fieldEmail == self.txtEmail.text!)
        let count = try! Model.db.scalar(filter.count)
        if count > 0 {
            print("gagal")
        }else{
            self.register()
        }
    }
    
    func register(){
        do {
            let insert = Model.tbUsers.insert(Model.fieldName <- self.txtName.text!, Model.fieldEmail <- self.txtEmail.text!, Model.fieldPass <- self.txtPassword.text!)
            let rowId = try Model.db.run(insert)
            Model.idLogin = rowId
        } catch let Result.error(message, code, _) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message)")
        } catch let error {
            print("insertion failed: \(error)")
        }
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        let _ = self.dismiss(animated: true, completion: nil)
    }
}
