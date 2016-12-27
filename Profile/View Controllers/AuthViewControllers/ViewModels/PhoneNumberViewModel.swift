//
//  PhoneNumberViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 26.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol PhoneNumberViewModelDelegate : class {
    func sengingSuccess(viewModel: EnterCodeViewModel)
    func numberIsNotCorrect()
    func errorSending()
    
}

class PhoneNumberViewModel {
    weak var delegate : PhoneNumberViewModelDelegate?
    private var phoneNumeber : String?
    private var smsService : SMSService?
    
    
    func enterButtonTapped(with phoneNumber: String) {
//TODO : Add number validation
        smsService = SMSService(phoneNumber: phoneNumber)
        smsService?.sendCode(completion: { (success) in
            if success {
                self.delegate?.sengingSuccess(viewModel: EnterCodeViewModel(smsService: self.smsService!, userManager: UserManager()))
            } else {
                self.delegate?.errorSending()
            }
        })
    }
}
