//
//  UserManager.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

class UserManager {
    
    func getAuthUserFromDB() -> RealmUser? {
        return DBManager.shared.loadUserFromCache()
    }
    
    func createUser(_ user: RealmUser) {
        DBManager.shared.cacheObject(user)
    }
    
}
