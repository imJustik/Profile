//
//  MainViewControllerViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 07.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol MainViewViewModel {
    weak var delegate : MainViewViewModelDelegate? {get set}
}

protocol MainViewViewModelDelegate : class {
    
}

class MainViewControllerViewModel : MainViewViewModel {
    weak var delegate : MainViewViewModelDelegate? 
}
