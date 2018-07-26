//
//  SettingDataUserController.swift
//  Sample SQLite Swift
//
//  Created by Rahmat Hidayat on 7/26/18.
//  Copyright © 2018 Rahmat Hidayat. All rights reserved.
//

import UIKit
import SQLite

class SettingDataUserController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnProcess: UIButton!
    
    var isEdit: Bool! //False: Form Add, True: Form Edit
    var idUser: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnProcess.layer.cornerRadius = 4
        
        if self.isEdit {
            let filter = Model.tbUsers.filter(Model.fieldId == self.idUser)
            for user in try! Model.db.prepare(filter) {
                self.txtName.text = user[Model.fieldName]!
                self.txtEmail.text = user[Model.fieldEmail]
            }
            self.btnProcess.setTitle("Edit", for: .normal)
        }else{
            self.btnProcess.setTitle("Save", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnProcessTapped(_ sender: UIButton) {
        if self.isEdit {
            let filter = Model.tbUsers.filter(Model.fieldId == self.idUser)
            do {
                if try Model.db.run(filter.update(Model.fieldName <- self.txtName.text!, Model.fieldEmail <- self.txtEmail.text!)) > 0 {
                    print("User Updated")
                }
            } catch let err {
                print("update failed: \(err)")
            }
            
        }else{
            
            do {
                try Model.db.run(Model.tbUsers.insert(Model.fieldName <- self.txtName.text!, Model.fieldEmail <- self.txtEmail.text!, Model.fieldPass <- ""))
            } catch let err {
                print("Insert Failed: \(err)")
            }
            
        }
    }
}
