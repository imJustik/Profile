//
//  MainViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 07.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import RealmSwift



protocol MainViewViewModelDelegate : class {
    func updateProfile()
}

class MainViewControllerViewModel {
    weak var delegate : MainViewViewModelDelegate?
    
    private var user : RealmUser?
    private let userManager : UserManager
    var profiles : List<RealmProfile>?
    
    private var indexProfile = 0
    
    var username: String?
    var phoneNumber: String?
    var email: String?
    var image: Data?
    var links: List<RealmLink>?
    
    var numberOfCells = 1
    
    init (with userManager: UserManager) {
        self.userManager = userManager
    }
    
 
    func loadUser() {
        self.user = userManager.getAuthUserFromDB()
        guard user != nil else { fatalError("User is nil") }
        self.profiles = user?.profiles
        updateProfile()
    }
    
    func updateProfile() {
        if let profile = profiles?[indexProfile] {
            if profile.lastName != nil {
                self.username = profile.firstName + " " + profile.lastName!
            } else {
                self.username = profile.firstName
            }
            
            self.phoneNumber = profile.phoneNumber
            self.email = profile.email
            self.image = profile.image
            self.links = profile.links
            self.numberOfCells = profile.links.count + 1
            delegate?.updateProfile()
        }
    }
    
    func flipProfile() {
        if indexProfile < profiles!.count - 1 {
            indexProfile += 1
        } else {
            indexProfile = 0
        }
        updateProfile()
    }
    
    func getCurrentProfile() -> RealmProfile {
        guard let profile = profiles?[indexProfile] else { fatalError("Profiles is nil") }
        return profile
    }
    
}



