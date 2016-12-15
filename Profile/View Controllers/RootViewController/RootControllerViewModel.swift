//
//  RootControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol RootViewControllerViewModelDelegate : class {
    func moveToRegistationScreen()
    func moveToMainScreen()
    func moveToCreateProfileScreen()
}

protocol RootViewControllerViewModel {
    weak var delegate: RootViewControllerViewModelDelegate? {get set}
    func getCurrentUser()
}

class RootControllerViewModel : RootViewControllerViewModel {
    weak var delegate : RootViewControllerViewModelDelegate?
    
    func getCurrentUser() {
        print("getCurrentUser")
        let currentUser = DBManager.shared.loadUserFromCache()
        if currentUser != nil {
            if currentUser!.profiles.count != 0 {
                delegate?.moveToMainScreen()
            } else {
                delegate?.moveToCreateProfileScreen()
              }
        } else {
            delegate?.moveToRegistationScreen()
        }
        
    }
    
    
}
