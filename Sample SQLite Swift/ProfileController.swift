//
//  ProfileController.swift
//  Sample SQLite Swift
//
//  Created by Rahmat Hidayat on 7/26/18.
//  Copyright © 2018 Rahmat Hidayat. All rights reserved.
//

import UIKit
import SQLite

class ProfileController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogout.layer.cornerRadius = 4
        
        let filter = Model.tbUsers.filter(Model.fieldId == Model.idLogin)
        for user in try! Model.db.prepare(filter) {
            self.lblName.text = user[Model.fieldName]!
            self.lblEmail.text = user[Model.fieldEmail]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func btnLogoutTapped(_ sender: UIButton) {
        
    }
}
