//
//  CreateProfileViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 05.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import DigitsKit
protocol CreateProfileViewModel {
    weak var delegate : CreateProfileViewModelDelegate? {get set}
    var user : RealmUser? {get}
    
    
    func enterButtonTapped()
    
//TODO: - add validation for text fields
    func firstNameTextDidChange(text:String)
    func lastNameTextDidChange(text:String?)
    func middleNameTextDidChange(text:String?)
    func phoneNumberTextDidChange(text:String?)
    func emailTextDidChange(text:String?)
    func imageViewDidChange(image: UIImage?)
    func birthdayTextDidChange(text: String?)
}

protocol CreateProfileViewModelDelegate : class{

    func moveToMainScreen()
}

class CreateProfileViewControllerViewModel :  CreateProfileViewModel {
    weak var delegate: CreateProfileViewModelDelegate?
    var user : RealmUser?
    let profile = RealmProfile()
    let userManager = UserManager()
    
    init() {
        user = userManager.getAuthUserFromDB()
        profile.typeProfile = .User
    }
    
    func firstNameTextDidChange(text: String) {
        profile.firstName = text
    }
    
    func lastNameTextDidChange(text: String?) {
        profile.lastName = text
    }
    
    func middleNameTextDidChange(text: String?) {
        profile.middleName = text
    }
    
    func phoneNumberTextDidChange(text: String?) {
        profile.phoneNumber = text
    }
    
    func emailTextDidChange(text: String?) {
        profile.email = text
    }
    
    func imageViewDidChange(image: UIImage?) {
        profile.image = UIImagePNGRepresentation(image!) as Data?
    }
    
    func birthdayTextDidChange(text: String?) {
        profile.birthbay = text
    }
    
    func enterButtonTapped() {
        if user != nil {
        userManager.addProfile(user: user!, profile: profile)
        delegate?.moveToMainScreen()
        } else {
            print("Error with User")
        }
    }
    
    
}



