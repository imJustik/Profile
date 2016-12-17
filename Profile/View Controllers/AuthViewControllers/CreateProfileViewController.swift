//
//  CreateProfileViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 05.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class CreateProfileViewController : UITableViewController, UITextFieldDelegate, CreateProfileViewModelDelegate {
    
    var router: StoryboardRouter<UIViewController>?

    var viewModel : CreateProfileViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var middleNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        router = StoryboardRouter(viewController: self)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
       view.addGestureRecognizer(tap)
       tap.cancelsTouchesInView = false
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        middleNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
        birthdayTextField.delegate = self
    }
    
    func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        switch textField {
        case firstNameTextField:
            viewModel?.firstNameTextDidChange(text: text!)
        case lastNameTextField:
            viewModel?.lastNameTextDidChange(text: text)
        case middleNameTextField:
            viewModel?.middleNameTextDidChange(text: text)
        case phoneNumberTextField:
            viewModel?.phoneNumberTextDidChange(text: text)
        case emailTextField:
            viewModel?.emailTextDidChange(text: text)
        case birthdayTextField:
            viewModel?.birthdayTextDidChange(text: text)
        default:
            break
        }
        return true
    }
    
    @IBAction func enterButtonTapped(_ sender: UIButton) {
        viewModel?.enterButtonTapped()
    }

    func moveToMainScreen() {
        router?.navigateToMainProfileScreen(animated: true)
    }
}
