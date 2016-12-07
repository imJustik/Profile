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
    func didStartButtonTap()
    
}

protocol AuthViewControllerViewModelDelegate : class {
    func moveToNextScreenWithSession(_ session: DGTSession)
}

class AuthViewControllerViewModel : AuthViewControlViewModel {
    weak var delegate : AuthViewControllerViewModelDelegate?
    let pageViewModels : [PageViewModel]?
    
    init() {
        pageViewModels = PageViewModelManager.all()
    }
    
    func didStartButtonTap() {
        let digits = Digits.sharedInstance()
        digits.authenticate { (session, error) in
            if (session != nil) {
                self.delegate?.moveToNextScreenWithSession(session!)
            }
            else {
                print("Authentication error: %@", error!.localizedDescription)
            }
        }
    }
    
    
}
