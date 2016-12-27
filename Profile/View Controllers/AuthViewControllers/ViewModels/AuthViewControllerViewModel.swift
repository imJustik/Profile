//
//  AuthViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

protocol AuthViewControlViewModel {
    weak var delegate : AuthViewControllerViewModelDelegate? {get set}
    var pageViewModels : [PageViewModel]? {get}
    func didStartButtonTap()
    
}

protocol AuthViewControllerViewModelDelegate : class {
    func moveToEnterCodeScreen()
}

class AuthViewControllerViewModel : AuthViewControlViewModel {
    weak var delegate : AuthViewControllerViewModelDelegate?
    let pageViewModels : [PageViewModel]?

    
//TODO: сделать инициализию с Page Manager
    init() {
        pageViewModels = PageViewModelManager.all()
    }
    
    func didStartButtonTap() {
//TODO: добавить тут проверку
        delegate?.moveToEnterCodeScreen()
    }
    
}



