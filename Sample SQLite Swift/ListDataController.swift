//
//  ListDataController.swift
//  Sample SQLite Swift
//
//  Created by Rahmat Hidayat on 7/26/18.
//  Copyright © 2018 Rahmat Hidayat. All rights reserved.
//

import UIKit
import SQLite

class ListDataController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbData: UITableView!
    
    var listId = [Int64]()
    var listName = [String]()
    var listEmail = [String]()
    var idUserSelected: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for user in try! Model.db.prepare(Model.tbUsers) {
            self.listId.append(user[Model.fieldId])
            self.listName.append(user[Model.fieldName]!)
            self.listEmail.append(user[Model.fieldEmail])
        }
        
        self.tbData.tableFooterView = UIView()
        self.tbData.delegate = self
        self.tbData.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as! ListDataCell
        
        cell.lblName.text = self.listName[indexPath.row]
        cell.lblEmail.text = self.listEmail[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.idUserSelected = self.listId[indexPath.row]
        self.performSegue(withIdentifier: "showDetailData", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (_, index) in
            do {
                let idSelected = self.listId[index.row]
                let filter = Model.tbUsers.filter(Model.fieldId == idSelected)
                if try Model.db.run(filter.delete()) > 0 {
                    print("deleted alice")
                }
            } catch {
                print("delete failed: \(error)")
            }
        }
        delete.backgroundColor = UIColor.red
        
        return [delete]
    }
    
    @IBAction func btnAddTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showAddData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailData" {
            let conn = segue.destination as! DetailDataController
            conn.idUser = self.idUserSelected
        }
        if segue.identifier == "showAddData" {
            let conn = segue.destination as! SettingDataUserController
            conn.isEdit = false
        }
    }
    
}
