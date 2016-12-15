//
//  TypeLink.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 03.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import RealmSwift

class RealmTypeLink: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var basicURL = ""
    dynamic var imageURL = ""
    
    convenience init(name: String, basicURL: String, imageURL: String) {
        self.init()
        self.name = name
        self.basicURL = basicURL
        self.imageURL = imageURL
    }
}
