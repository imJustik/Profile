//
//  EnterNumberViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 26.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class PhoneNumberViewController: UIViewController, PhoneNumberViewModelDelegate {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    var router: StoryboardRouter<UIViewController>?
    
    var viewModel: PhoneNumberViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        self.router = StoryboardRouter(viewController: self)
    }

    @IBAction func enterButtonTapped(_ sender: UIButton) {
        viewModel?.enterButtonTapped(with: phoneNumberTextField.text!)
    }
    
    func sengingSuccess(viewModel: EnterCodeViewModel) {
        router?.navigateToEnterCodeScreen(viewModel: viewModel)
    }
    
    func errorSending() {
        print("kek")
    }
    
    func numberIsNotCorrect() {
        print("Number is not Correct")
    }



}
