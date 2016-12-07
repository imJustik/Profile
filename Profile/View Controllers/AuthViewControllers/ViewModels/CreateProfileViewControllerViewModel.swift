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
    init(session: DGTSession)
//    var image : UIImage {get}
//    var firstName : String {get}
//    var lastName : String? {get}
//    var middleName: String? {get}
//    var phoneNumber: String? {get}
//    var email: String? {get}
//    var birthday: String? {get}
    
    
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
    let user = RealmUser()
    let profile = RealmProfile()
    let userManager = UserManager()
    
    required init(session: DGTSession) {
        user.phoneNumber = session.phoneNumber
        user.authToken = session.authToken
        user.authTokenSecret = session.authTokenSecret
        user.userID = session.userID
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
        profile.image = UIImagePNGRepresentation(image!) as NSData?
    }
    
    func birthdayTextDidChange(text: String?) {
        profile.birthbay = text
    }
    
    func enterButtonTapped() {
        user.profiles.append(profile)
        user.isAuth = true
        userManager.createUser(user)
        delegate?.moveToMainScreen()
    }
    
    
}



