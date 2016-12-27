//
//  EnterCodeViewModel.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 26.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation

protocol EnterCoreViewModelDelegate : class {
    func codeSuccess()
    func codeFailed()
}

class EnterCodeViewModel {
    weak var delegate: EnterCoreViewModelDelegate?
    var smsService : SMSService?
    var userManager : UserManager?
    
    init(smsService: SMSService, userManager : UserManager) {
        self.smsService = smsService
        self.userManager = userManager
    }
    
    func nextButtonTapped (wihtCode code: String) {
        if smsService!.checkCode(code: code) {
            userManager?.createUser(withToken: createToken(), phoneNumber: smsService!.phoneNumber)
            delegate?.codeSuccess()
        } else {
            delegate?.codeFailed()
        }
    }
    
    
    private func createToken(_ len : Int = 32)->String {
        let letters:NSString = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijkmnopqstuvwxyz0123456789";
        let n=60;
        var randomString="";
        for _ in 0 ..< len {
            let m=randomNumber(1..<n) as Int;
            randomString += letters.substring(with: NSRange(location: m, length: 1));
        }
        return randomString;
    }
    private func randomNumber(_ range: Range<Int>) -> Int {
        let min = range.lowerBound
        let max = range.upperBound
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }


}
