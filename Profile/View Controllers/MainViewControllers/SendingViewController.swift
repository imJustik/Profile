//
//  SendingViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 18.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class SendingViewController: UIViewController {
    
    override func viewDidLoad() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchUp))
        self.view.addGestureRecognizer(tap)
    }
    
    func touchUp() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
