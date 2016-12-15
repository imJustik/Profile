//
//  ProfileViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 07.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate {
    func moveToCreateLink()
}

class ProfileViewController: UIViewController, ProfileViewModelDelegate {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mainVCDelegate : MainViewControllerDelegate?
    
    var viewModel : ProfileViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var pageIndex : Int!
    let cellAddID = "AddCell"
    let cellLinkID = "LinkCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageData = viewModel.image {
            userImageView.image = UIImage(data: imageData as Data)!
        }
        nameLabel.text = viewModel.username
        numberLabel.text = viewModel.phoneNumber
        emailLabel.text = viewModel.email
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
}

extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let links = viewModel.links else {
            return 1
        }
        return links.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.links!.count || viewModel.links!.count == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellAddID, for: indexPath) as! AddNewLinkCell
            
            cell.didAddButtonTap = {
                self.mainVCDelegate?.moveToCreateLink()
            }
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellLinkID, for: indexPath) as! LinkCell
            cell.linkImageView.image = UIImage(named:viewModel.links![indexPath.item].type!.imageURL)
            return cell
        }
        
    }
    
    

    
}
