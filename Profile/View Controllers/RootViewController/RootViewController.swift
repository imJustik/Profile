//
//  FirstViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 02.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit
class RootViewController: UIViewController, RootViewControllerViewModelDelegate {
    
    var router : StoryboardRouter<UIViewController>?
    
    var rootControllerViewModel : RootControllerViewModel? {
        didSet {
            rootControllerViewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        router = StoryboardRouter(viewController: self)
       // rootControllerViewModel?.cleanAll()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let viewModel = rootControllerViewModel {
            viewModel.getCurrentUser()
        }
        
    }

    func moveToRegistationScreen() {
        router?.navigateToRegistationScreen(animated: false)
    }
    
    func moveToMainScreen() {
        router?.navigateToMainProfileScreen(animated: false)
    }
    
    func moveToCreateProfileScreen() {
        router?.navigateToCreateProfileScreen(animated: false)
    }
    
}


