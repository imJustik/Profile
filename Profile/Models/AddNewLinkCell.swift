//
//  AddNewLinkCell.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 09.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit



class AddNewLinkCell: UICollectionViewCell {
    var didAddButtonTap : ( () -> () )? = nil
    
  
    @IBAction func addButtonTap(_ sender: Any) {
        if let action = didAddButtonTap {
            action()
        } else {
            print("Add New Link error. Line 21")
        }
    }
}
