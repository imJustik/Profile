//
//  SendingViewController.swift
//  Profile
//
//  Created by Iliya Kuznetsov on 18.12.16.
//  Copyright © 2016 Iliya Kuznetsov. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox

class SendingViewController: UIViewController {
    
    var image : UIImage? = nil
    @IBOutlet weak var imageView: UIImageView!
    
    var motionManager: CMMotionManager?
    
    override func viewDidLoad() {
        
        imageView.layer.shadowColor = UIColor.white.cgColor
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowOffset = CGSize.zero
        imageView.layer.shadowRadius = 8
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if image != nil {
            imageView.image = self.image
        }
        
        startMotionManager()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4) {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
      stopMotionManager()
    }

    
    func startMotionManager() {
        motionManager = CMMotionManager()
        motionManager?.accelerometerUpdateInterval = 0.2
        motionManager?.gyroUpdateInterval = 0.2
        motionManager?.deviceMotionUpdateInterval = 0.02
        
        if !motionManager!.isDeviceMotionActive {
            motionManager?.startDeviceMotionUpdates(to: OperationQueue.current!) { deviceManager, error in
                if (deviceManager!.userAcceleration.y > 2.0 ) {
                    AudioServicesPlaySystemSound(SystemSoundID(1000))
                }
            }
        }

    }
    
    func stopMotionManager() {
        motionManager?.stopDeviceMotionUpdates()
        motionManager = nil
    }
    
}
