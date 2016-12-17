//
//  Router.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 16.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class StoryboardRouter<T: UIViewController> {
    weak fileprivate(set) var viewController : UIViewController?
    init(viewController: T) {
        self.viewController = viewController
    }
    
    func navigateToRegistationScreen(animated: Bool) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AuthStoryboard") as! AuthViewController
        controller.viewModel = AuthViewControllerViewModel()
        viewController?.present(controller, animated: animated, completion: nil)
    }
    
    func navigateToMainProfileScreen(animated: Bool) {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainStoryboard") as! UITabBarController
        let navVC = controller.viewControllers?.first as! UINavigationController
        let mainVC = navVC.viewControllers.first as! MainViewController
        mainVC.viewModel = MainViewControllerViewModel()
        viewController?.present(controller, animated: animated, completion: nil)
    }
    
    func navigateToCreateProfileScreen(animated: Bool) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateFirstProfileStoryboard") as! CreateProfileViewController
        controller.viewModel = CreateProfileViewControllerViewModel()
        viewController?.present(controller, animated: animated, completion: nil)
    }
    
    func navigateToAddLinkScreen(animated: Bool, profile: RealmProfile) {
        self.performSegue(identifier: "MoveToAddLinkSegue") { (viewController: AddLinkViewController) in
            viewController.viewModel = AddLinkViewControllerViewModel(profile: profile)
        }
    }
}


extension StoryboardRouter {
    
   fileprivate func performSegue<DestinationViewControllerType>(identifier: String, configurate:  ((_ viewController: DestinationViewControllerType) -> Void)?) {
        self.viewController?.performSegueWithIdentifier(identifier, sender: self, configurate: { (segue) in
            if let navigationViewController = segue.destination as? UINavigationController {
                if let rootViewController = navigationViewController.viewControllers.first {
                    self.perform(viewController: rootViewController, identifier: identifier, configurate: configurate)
                } else {
                    fatalError("segue with identifier: \(identifier) has destinationViewController as UINavigationController without viewControllers")
                }
            } else {
                self.perform(viewController: segue.destination, identifier: identifier, configurate: configurate)
            }
            
        })
    }
    
    fileprivate func perform<DestinationViewControllerType>(viewController: UIViewController, identifier: String, configurate: ((_ viewController: DestinationViewControllerType) -> Void)?) {
        guard let viewController = viewController as? DestinationViewControllerType else {
            fatalError("segue with identifier: \(identifier) doesn't has destinationViewController with type \(DestinationViewControllerType.self)")
        }
        
        configurate?(viewController)
    }
}
















