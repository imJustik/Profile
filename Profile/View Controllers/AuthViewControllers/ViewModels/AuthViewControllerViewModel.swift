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
    var user : RealmUser? {get}
    func didStartButtonTap(session: DGTSession)
    
}

protocol AuthViewControllerViewModelDelegate : class {
    
}

class AuthViewControllerViewModel : AuthViewControlViewModel {
    weak var delegate : AuthViewControllerViewModelDelegate?
    let pageViewModels : [PageViewModel]?
    var user : RealmUser?
    let userManager = UserManager()
    
    init() {
        pageViewModels = PageViewModelManager.all()
    }
    
    func didStartButtonTap(session: DGTSession) {
        self.userManager.createUser(with: session)
    }
    
}



