//
//  Splash.swift
//  CBOMobileReporting
//
//  Created by rahul sharma on 12/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class Splash: UIViewController {

 let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cbohelp : CBO_DB_Helper  = CBO_DB_Helper.shared
    var vc : UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mainstoryboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
       
        if(cbohelp.getCOMP_NAME() == "-1")
        {
             vc = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            //vc = mainstoryboard.instantiateViewController(withIdentifier: "ReminderApproval") as! ReminderApproval
//
//             vc = mainstoryboard.instantiateViewController(withIdentifier: "MailDetailsVC") as! MailDetailsVC

        }else
        {
//           vc = mainstoryboard.instantiateViewController(withIdentifier: "MailDetailsVC") as! MailDetailsVC

          vc = mainstoryboard.instantiateViewController(withIdentifier: "FakeLoginViewController") as! FakeLoginViewController
        }
         appDelegate.window?.rootViewController = vc
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       sleep(2)
       
        self.dismiss(animated: true, completion: nil)
    }
}
