//
//  SMSService.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 26.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import Foundation
import Alamofire

class SMSService {
    
    private var SMSCode : UInt32?
    private var apiID = ""
    var token : String?
    var phoneNumber:String!
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    func sendCode(completion: @escaping (_ success: Bool) -> Void) {
        guard phoneNumber != nil  else {fatalError("Phone Number is NIL")}
        SMSCode = arc4random_uniform(8999) + 1000
        let url = "https://sms.ru/sms/send?api_id=\(apiID)&to=\(phoneNumber!)&text=\(SMSCode!)"
        Alamofire.request(url).responseString { response in
            if response.result.isSuccess {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func checkCode(code: String) -> Bool {
        guard let codeInt = UInt32(code),
                  codeInt == SMSCode else { return false }
        return true
        }
    
}
