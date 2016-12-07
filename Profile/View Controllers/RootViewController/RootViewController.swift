//
//  FirstViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 02.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit
import DigitsKit


class RootViewController: UIViewController, RootViewControllerViewModelDelegate {
    var rootControllerViewModel : RootControllerViewModel? {
        didSet {
            rootControllerViewModel?.delegate = self
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        DBManager.shared.cleanDB()
        Digits.sharedInstance().logOut()
        if let viewModel = rootControllerViewModel {
            viewModel.getCurrentUser()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func moveToRegistationScreen() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AuthStoryboard") as! AuthViewController
        controller.viewModel = AuthViewControllerViewModel()
        self.present(controller, animated: false, completion: nil)
    }
    
    func moveToMainScreen() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileStoryboard")
        self.present(controller, animated: false, completion: nil)
    }
    
}


//MARK: - Delegats

