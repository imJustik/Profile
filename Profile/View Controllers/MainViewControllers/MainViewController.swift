//
//  MainViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,
    MainViewViewModelDelegate, MainViewControllerDelegate {
    var pageViewController : UIPageViewController!
    var index = 0 //current profile id
    
    var viewModel : MainViewViewModel! {
        didSet {
            viewModel!.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewProfile") as! UIPageViewController
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(index: 0)
        let viewControllers = [startVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
         self.pageViewController.view.frame = CGRect(x: 0,y:65, width: self.view.frame.width, height: self.view.frame.size.height - 115)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
    }
    
    func viewControllerAtIndex(index: Int) -> ProfileViewController {
        guard let pageProfiles = self.viewModel.profiles,
                  pageProfiles.count != 0,
            index < pageProfiles.count else { return ProfileViewController() }
        let vc : ProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileStoryboard") as! ProfileViewController
        vc.viewModel = ProfileViewControllerViewModel(pageProfiles[index])
        vc.mainVCDelegate = self
        vc.pageIndex = index
        return vc
    }

    override func viewDidAppear(_ animated: Bool) {
        viewModel.updateData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func moveToCreateLink() {
        self.performSegue(withIdentifier: "MoveToAddLinkSegue", sender: self)
        
    }
    
    @IBAction func addNewProfileButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Auth", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CreateFirstProfileStoryboard") as! CreateProfileViewController
        controller.viewModel = CreateProfileViewControllerViewModel()
        self.present(controller, animated: true, completion: nil)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveToAddLinkSegue"
        {
            if let destinationVC = segue.destination as? AddLinkViewController {
                destinationVC.viewModel = AddLinkViewControllerViewModel(profile: viewModel.profiles![index])
            }
        }
    }
}


extension MainViewController : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ProfileViewController
        index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index -= 1
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ProfileViewController
        index = vc.pageIndex as Int
        
        if (index == NSNotFound) { return nil }
        index += 1
        
        if (index == self.viewModel.profiles?.count) { return nil}
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
