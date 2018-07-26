//
//  DetailDataController.swift
//  Sample SQLite Swift
//
//  Created by mac on 7/26/18.
//  Copyright © 2018 Rahmat. All rights reserved.
//

import UIKit
import SQLite

class DetailDataController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var idUser: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let filter = Model.tbUsers.filter(Model.fieldId == self.idUser)
        for user in try! Model.db.prepare(filter) {
            self.lblName.text = user[Model.fieldName]!
            self.lblEmail.text = user[Model.fieldEmail]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnEditTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showEditData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditData" {
            let conn = segue.destination as! SettingDataUserController
            conn.idUser = self.idUser
            conn.isEdit = true
        }
    }
    
}
