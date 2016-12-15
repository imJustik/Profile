//
//  AddLinkViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 12.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol AddLinkViewModel {
    weak var delegate : AddLinkViewModelDelegate? {get set}
    var typesLink : [RealmTypeLink] {get set}
    func linkDidChange(_ text: String)
    func typeLinkDidChange(_ type: RealmTypeLink)
    func saveLinkToProfile()
    
}

protocol AddLinkViewModelDelegate : class {

}

class AddLinkViewControllerViewModel: AddLinkViewModel {
    weak var delegate : AddLinkViewModelDelegate?
    var typesLink : [RealmTypeLink]
    
    private var typeLink = RealmTypeLink()
    private var link = ""
    private var userManeger = UserManager()
    private var profile : RealmProfile
    
    
    init(profile : RealmProfile) {
        self.typesLink = TypeLinkManager.all()
        self.profile = profile
    }
    
    func linkDidChange(_ text: String) {
        link = typeLink.basicURL + text
    }
    
    func typeLinkDidChange(_ type : RealmTypeLink) {
        typeLink = type
    }
    
    func saveLinkToProfile() {
        if !link.isEmpty {
            let newLink = RealmLink()
            newLink.type = typeLink
            newLink.url = link
            DBManager.shared.addLinkToProfile(profile: profile, link: newLink)
            
        }
        print("save \(link)")
    }
}
