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
        UINavigationBar.appearance().barTintColor = UIColor(red: 250/255, green: 251/255, blue: 254/255, alpha: 1)
        
        UINavigationBar.appearance().tintColor = UIColor(red: 111/255, green: 127/255, blue: 141/255, alpha: 1)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor(red: 111/255, green: 127/255, blue: 141/255, alpha: 1)]
        
         UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
         UINavigationBar.appearance().shadowImage = UIImage()
        
    }
    
    func setPageViewAppearance() {
        let pageControl = UIPageControl.appearance()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.backgroundColor = UIColor.red
    }
    
    
}
