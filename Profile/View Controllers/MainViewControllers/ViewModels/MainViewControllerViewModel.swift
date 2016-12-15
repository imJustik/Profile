//
//  MainViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 07.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import RealmSwift

protocol MainViewViewModel {
    weak var delegate : MainViewViewModelDelegate? {get set}
    var profiles : List<RealmProfile>? {get}
    var friendProfiles : List<RealmProfile>? {get}
    func updateData()
}

protocol MainViewViewModelDelegate : class {
    
}

class MainViewControllerViewModel : MainViewViewModel {
    weak var delegate : MainViewViewModelDelegate?
    var profiles : List<RealmProfile>?
    var friendProfiles: List<RealmProfile>?
    private var user : RealmUser
    private let userManager = UserManager()
    
    init () {
        user = userManager.getAuthUserFromDB()!
        self.profiles = user.profiles
        self.friendProfiles = user.friendProfiles
    }

    func updateData() {
        user = userManager.getAuthUserFromDB()!
        self.profiles = user.profiles
        self.friendProfiles = user.friendProfiles
        print(user.profiles)
    }
}
