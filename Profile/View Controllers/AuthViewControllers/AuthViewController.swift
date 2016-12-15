//
//  AuthViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//
import DigitsKit
import UIKit

class AuthViewController: UIViewController, AuthViewControllerViewModelDelegate {

    var pageViewController: UIPageViewController!
    var viewModel : AuthViewControllerViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(index: 0)
        let viewControllers = [startVC]
        self.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRect(x: 0,y:30, width: self.view.frame.width, height: self.view.frame.size.height - 60)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func viewControllerAtIndex(index:Int) -> AuthContentViewController {
        guard let pageModels = self.viewModel.pageViewModels,
                  pageModels.count != 0,
                  index < pageModels.count else {
        return AuthContentViewController()
        }
        
        let vc: AuthContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! AuthContentViewController
        
        
        vc.imageFile = pageModels[index].imageURL
        vc.titleText = pageModels[index].title
        vc.pageIndex = index
        return vc
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        self.viewModel.didStartButtonTap()
    }
    
    func moveToNextScreen() {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateFirstProfileStoryboard") as! CreateProfileViewController
        controller.viewModel = CreateProfileViewControllerViewModel()
        self.present(controller, animated: true, completion: nil)
    }
}







extension AuthViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! AuthContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! AuthContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) { return nil }
        index += 1
        
        if (index == self.viewModel.pageViewModels?.count) { return nil}
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
