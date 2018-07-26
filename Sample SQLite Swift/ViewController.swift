//
//  ViewController.swift
//  Sample SQLite Swift
//
//  Created by mac on 7/24/18.
//  Copyright © 2018 Rahmat. All rights reserved.
//

import UIKit
import SQLite
import SQLite3

class ViewController: UIViewController {

    var db: Connection!
    let tbUsers = Table("users")
    let fieldId = Expression<Int64>("id")
    let fieldName = Expression<String?>("name")
    let fieldEmail = Expression<String>("email")
    let fieldPass = Expression<String>("password")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("db.sqlite3")
//        print(fileUrl)
//        if sqlite3_open(fileUrl.path, &self.db) != SQLITE_OK {
//            print("Error Opening Database")
//        }
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        self.db = try! Connection("\(path)/db.sqlite3")
        
        self.createTbUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createTbUsers(){
//        if sqlite3_exec(self.db, "CREATE TABLE IF NOT EXISTS users(id interger primary key autoincrement, name text, email text unique, password text)", nil, nil, nil) != SQLITE_OK {
//            print("error creating table")
//        }
        
        try! db.run(self.tbUsers.create(ifNotExists: true) { t in
            t.column(self.fieldId, primaryKey: .autoincrement)
            t.column(self.fieldName)
            t.column(self.fieldEmail, unique: true)
            t.column(self.fieldPass)
        })
        
        print("create")
        self.insertUsers()
    }
    
    func insertUsers(){
        do {
            let insert = self.tbUsers.insert(self.fieldName <- "John", self.fieldEmail <- "john@mail.com", self.fieldPass <- "john123")
            let rowId = try self.db.run(insert)
            print(rowId)
        } catch let Result.error(message, code, _) where code == SQLITE_CONSTRAINT {
            print("constraint failed: \(message)")
        } catch let error {
            print("insertion failed: \(error)")
        }
        
        
        print("inserrt")
        self.showUsers()
    }
    
    func showUsers(){
        for user in try! self.db.prepare(self.tbUsers) {
            print("Id: \(user[self.fieldId]), Name: \(user[self.fieldName]!)")
        }
    }

}

