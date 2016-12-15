//
//  RealmLink.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 03.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import RealmSwift

class RealmLink : Object {
    dynamic var id = 0
    dynamic var type : RealmTypeLink?
    dynamic var url = ""
}
