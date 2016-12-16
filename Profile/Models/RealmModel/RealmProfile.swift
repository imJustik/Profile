//
//  RealmProfile.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 03.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import RealmSwift

enum ProfileType : Int {
    case User
    case Friend
}

class RealmProfile : Object {
    dynamic var id = 0
    
    private dynamic var type = ProfileType.User.rawValue
    var typeProfile: ProfileType {
        get {
            return ProfileType(rawValue: type)!
        }
        set {
            type = newValue.rawValue
        }
    }
    
    dynamic var firstName = ""
    dynamic var lastName : String?
    dynamic var middleName : String?
    dynamic var phoneNumber : String?
    dynamic var email : String?
    dynamic var image : NSData?
    dynamic var birthbay : String? // string for test
    let links = List<RealmLink>()
}
