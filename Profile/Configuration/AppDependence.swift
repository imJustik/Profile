//
//  AppDependents.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit
import Fabric
import DigitsKit

class AppDependence {
    let window : UIWindow?
    let userManager = UserManager()
    let rootViewModel = RootControllerViewModel()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func startConfiguration() {
        if let rootController = window?.rootViewController as? RootViewController {
            rootController.rootControllerViewModel = rootViewModel
        }
        
        Fabric.with([Digits.self])
        
    }
    
    func setPageViewAppearance() {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.backgroundColor = UIColor.red
    }
    
    
}
