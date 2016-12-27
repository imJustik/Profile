//
//  EnterCodeViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 26.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit

class EnterCodeViewController: UIViewController, EnterCoreViewModelDelegate {

    @IBOutlet weak var codeTextField: UITextField!
    var router : StoryboardRouter<UIViewController>?
    var viewModel : EnterCodeViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        router = StoryboardRouter(viewController: self)

        // Do any additional setup after loading the view.
    }

    func codeSuccess() {
        router?.navigateToCreateProfileScreen(animated: true)
    }
    
    func codeFailed() {
        print("Code is wrong!")
    }
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        viewModel?.nextButtonTapped(wihtCode: codeTextField.text!)
    }
}
