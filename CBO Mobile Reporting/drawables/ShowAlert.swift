//
//  ShowAlert.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 04/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class ShowAlert: UIViewController {

    func showalertWithTime(msg : String, vc : UIViewController)
    {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        vc.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func showAlert(msg : String , vc: UIViewController, buttonTitle : String, alertTitle : String){
        let alert = UIAlertController(title: alertTitle, message: msg
            , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title : buttonTitle , style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showCustomeAlert(vc: ViewController) {
        
        let alertController = UIAlertController(title: "Alert Title", message: "This is testing message.", preferredStyle: UIAlertControllerStyle.alert)
        // Background color.
        let backView = alertController.view.subviews.last?.subviews.last
        backView?.layer.cornerRadius = 10.0
        backView?.backgroundColor = UIColor.blue
        
        // Change Title With Color and Font:
        
        let myString  = "Alert Title"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:myString.count))
        alertController.setValue(myMutableString, forKey: "attributedTitle")
        
        // Change Message With Color and Font
        
        let message  = "This is testing message."
        var messageMutableString = NSMutableAttributedString()
        messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0)!])
        messageMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: NSRange(location:0,length:message.count))
        alertController.setValue(messageMutableString, forKey: "attributedMessage")
        
        
        // Action.
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        action.setValue(UIColor.orange, forKey: "titleTextColor")
        alertController.addAction(action)
       vc.present(alertController, animated: true, completion: nil)
    
    }
}
