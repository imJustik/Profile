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
            delegate?.moveToMainScreen()
        } else {
            delegate?.moveToRegistationScreen()
        }
        
    }
    
    
}
