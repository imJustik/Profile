//
//  UserManager.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import DigitsKit

class UserManager {
    
    func getAuthUserFromDB() -> RealmUser? {
        return DBManager.shared.loadUserFromCache()
    }
    
    func createUser(with session: DGTSession) {
        let user = RealmUser(session: session)
        user.isAuth = true
        DBManager.shared.cacheObject(user)
    }
    
    func addProfile(user: RealmUser, profile: RealmProfile) {
        DBManager.shared.addProfileToUser(user: user, profile: profile)
    }
    
    
    
}
