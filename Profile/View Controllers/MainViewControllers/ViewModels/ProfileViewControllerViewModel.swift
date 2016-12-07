//
//  ProfileViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 07.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
protocol ProfileViewModel {
    weak var delegate : ProfileViewModelDelegate? {get set}
}

protocol ProfileViewModelDelegate : class {
    
}

class ProfileViewControllerViewModel: ProfileViewModel {
    weak var delegate : ProfileViewModelDelegate?
    
}
