//
//  RealmUser.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 03.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import RealmSwift
enum AccountType : Int {
    case Basic
    case Pro
}

class RealmUser: Object {
    dynamic var id = 0
    
    private dynamic var typeAccount = AccountType.Basic.rawValue
    var typeAccountEnum: AccountType {
        get {
            return AccountType(rawValue: typeAccount)!
        }
        set {
            typeAccount = newValue.rawValue
        }
    }
    
    dynamic var authToken = ""
    dynamic var authTokenSecret = ""
    dynamic var userID = ""
    dynamic var phoneNumber = ""
    dynamic var isAuth = false
    var profiles = List<RealmProfile>()
    var friendProfiles = List<RealmProfile>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
