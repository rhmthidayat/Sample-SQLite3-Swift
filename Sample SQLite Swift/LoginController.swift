//
//  LoginController.swift
//  Sample SQLite Swift
//
//  Created by mac on 7/26/18.
//  Copyright © 2018 Rahmat. All rights reserved.
//

import UIKit
import SQLite

class LoginController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnLogin.layer.cornerRadius = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        self.login()
    }
    
    func login(){
        let filter = Model.tbUsers.filter(Model.fieldEmail == self.txtEmail.text! && Model.fieldPass == self.txtPassword.text!)
        let count = try! Model.db.scalar(filter.count)
        if count > 0 {
            for user in try! Model.db.prepare(filter) {
                Model.idLogin = user[Model.fieldId]
            }
            self.performSegue(withIdentifier: "showHome", sender: self)
        }else{
            print("gagal")
        }
    }
}
