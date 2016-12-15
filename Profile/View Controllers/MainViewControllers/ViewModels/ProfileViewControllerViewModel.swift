//
//  ProfileViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 07.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import RealmSwift

protocol ProfileViewModel {
    weak var delegate : ProfileViewModelDelegate? {get set}
    var username : String {get}
    var phoneNumber : String? {get}
    var email : String? {get}
    var image : NSData? {get}
    var links : List<RealmLink>? {get}
}

protocol ProfileViewModelDelegate : class {
    
}

class ProfileViewControllerViewModel: ProfileViewModel {
    weak var delegate : ProfileViewModelDelegate?
    var username: String
    var phoneNumber: String?
    var email: String?
    var image: NSData?
    var links: List<RealmLink>?
    
    init(_ profile: RealmProfile) {
        self.username =  profile.lastName != nil ? profile.firstName + " " + profile.lastName! : profile.firstName
        self.phoneNumber = profile.phoneNumber
        self.email = profile.email
        self.image = profile.image
        self.links = profile.links
    }
    
}

