//
//  SendingGestureRecognizer.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 25.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

class SendingGestureRecognizer: UIGestureRecognizer {
    
    var viewController : UIViewController?
    var previewViewController : UIViewController?
    
    var timer : Timer?

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(touchBegun), userInfo: [touches,event], repeats: false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .ended
        timer?.invalidate()
        timer = nil
    }
    
    func touchBegun(timer:Timer) {
        let userInfo = timer.userInfo as! NSArray
        state = .began
        super.touchesBegan(userInfo[0] as! Set<UITouch>, with: userInfo[1] as! UIEvent)
        }
    
    //сделать кастомный енум??
}
