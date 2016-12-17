//
//  AuthContentViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 04.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class AuthContentViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var pageIndex : Int!
    var titleText: String!
    var imageFile: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = UIImage(named: self.imageFile)  
        self.titleLabel.text = titleText
        
    }

    
}
