//
//  AuthViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//
import DigitsKit

protocol AuthViewControlViewModel {
    weak var delegate : AuthViewControllerViewModelDelegate? {get set}
    var pageViewModels : [PageViewModel]? {get}
    var user : RealmUser {get}
    func didStartButtonTap()
    
}

protocol AuthViewControllerViewModelDelegate : class {
    func moveToNextScreen()
}

class AuthViewControllerViewModel : AuthViewControlViewModel {
    weak var delegate : AuthViewControllerViewModelDelegate?
    let pageViewModels : [PageViewModel]?
    let user = RealmUser()
    let userManager = UserManager()
    
    init() {
        pageViewModels = PageViewModelManager.all()
    }
    
    func didStartButtonTap() {
        let digits = Digits.sharedInstance()
        digits.authenticate { (session, error) in
            if (session != nil) {
                self.user.phoneNumber = session!.phoneNumber
                self.user.authToken = session!.authToken
                self.user.authTokenSecret = session!.authTokenSecret
                self.user.userID = session!.userID
                self.user.isAuth = true
                self.userManager.createUser(self.user)
                
                self.delegate?.moveToNextScreen()
            }
            else {
                print("Authentication error: %@", error!.localizedDescription)
            }
        }
    }
    
    
}
