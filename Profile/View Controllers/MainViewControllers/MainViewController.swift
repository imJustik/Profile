//
//  MainViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit
import PeekPop

class MainViewController: UIViewController,
    MainViewViewModelDelegate {
    var router : StoryboardRouter<UIViewController>?
    var isPresent = false
    var longPress : UILongPressGestureRecognizer?
    
    var viewModel : MainViewControllerViewModel! {
        didSet {
            viewModel!.delegate = self
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var isBackSide = false
    let cellAddID = "AddCell"
    let cellLinkID = "LinkCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    
    let strboard = UIStoryboard(name: "Profile", bundle: nil)
    var controller : SendingViewController?
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        router = StoryboardRouter(viewController: self)
        self.automaticallyAdjustsScrollViewInsets = false
        
        let tap  = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(tap)
        self.view.isUserInteractionEnabled = true
        
        
        profileView.layer.shadowColor = UIColor.black.cgColor
        profileView.layer.shadowOpacity = 0.10
        profileView.layer.shadowOffset = CGSize.zero
        profileView.layer.shadowRadius = 5
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(longtap(gestureRecognizer:)))
        longPress?.minimumPressDuration = 0.7
        profileView.addGestureRecognizer(longPress!)
    }
 
    
    func longtap(gestureRecognizer: UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state == .began {
            controller = strboard.instantiateViewController(withIdentifier: "SendingViewController") as? SendingViewController
            controller?.modalPresentationStyle = .overCurrentContext
            controller?.image = profileView.screenshotView()
            self.present(controller!, animated: false, completion: nil)
        }
        if gestureRecognizer.state == .ended {
            controller?.dismiss(animated: false, completion: nil)
            controller = nil
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadUser()
    }
    
  
    func updateProfile() {
        usernameLabel.text = viewModel.username
        phoneNumberLabel.text = viewModel.phoneNumber
        emailLabel.text = viewModel.email
        collectionView.reloadData()
    }
    
    
    @IBAction func addNewProfileButtonTapped(_ sender: Any) {
        router?.navigateToCreateProfileScreen(animated: true)
        
    }
    
    
    func tapped() {
        guard viewModel.profiles!.count > 1 else { return }
        viewModel.flipProfile()
        
        UIView.transition(with: profileView, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: nil, completion: {(bool) in
            self.isBackSide = !self.isBackSide
        })
        
        
    }
    
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.numberOfCells - 1 || viewModel.numberOfCells == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellAddID, for: indexPath) as! AddNewLinkCell
            
            
            cell.didAddButtonTap = {
               self.router?.navigateToAddLinkScreen(animated: true, profile: self.viewModel.getCurrentProfile())
            }
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellLinkID, for: indexPath) as! LinkCell
            cell.linkImageView.image = UIImage(named:viewModel.links![indexPath.item].type!.imageURL)
            return cell
        }
        
    }
}




