//
//  ViewController.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 04/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import LGButton
import SwiftKeychainWrapper
class ViewController: UIViewController {
    
    let apiObj = CboServices()
//    let showAlert = ShowAlert()
    
    @IBAction func pressedLogin(_ sender: LGButton) {
        
        //showAlert.showAlert(msg: "you clicked on login button", vc: self, buttonTitle: "Ok", alertTitle: "Login")
     
        if let uuid = KeychainWrapper.standard.string(forKey: "imei_CurrentDeviceId") {
            print(uuid)
        }
//        apiObj.getXMLApi(vc: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // printing the keychain value
        mainScreenBackground()
        accessDeviceID()
    }
    
    //MARK:- functions
    //MARK:- MainScreen background
    func mainScreenBackground(){
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    //MARK:- function to access IMEI number
    func  accessDeviceID() {
        let id = KeychainWrapper.standard.string(forKey: "imei_CurrentDeviceId")
        if(id == nil){
            print("keysave..","saved....")
            if let uuid = UIDevice.current.identifierForVendor?.uuidString {
                
                 print(uuid)
                KeychainWrapper.standard.set(uuid, forKey: "imei_CurrentDeviceId")
            }
            
            
            
        }
    }
    
    
}

