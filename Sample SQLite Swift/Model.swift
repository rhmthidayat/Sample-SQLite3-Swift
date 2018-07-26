//
//  Model.swift
//  Sample SQLite Swift
//
//  Created by Rahmat Hidayat on 7/26/18.
//  Copyright © 2018 Rahmat Hidayat. All rights reserved.
//

import UIKit
import SQLite

struct Model {
    
    //Database Conenction
    static var db: Connection!
    //Table Users
    static var tbUsers = Table("users")
    static let fieldId = Expression<Int64>("id")
    static let fieldName = Expression<String?>("name")
    static let fieldEmail = Expression<String>("email")
    static let fieldPass = Expression<String>("password")
    //User Login
    static var idLogin: Int64!
    
}
