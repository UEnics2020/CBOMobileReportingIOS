//
//  MyNavigationBar.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 26/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class MyNavigationBar: UINavigationController {
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        myNavigationBar.barTintColor = AppColorClass.colorPrimary
        myNavigationBar.layer.shadowRadius = 3.0
        myNavigationBar.layer.masksToBounds = false
        myNavigationBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        myNavigationBar.layer.shadowOpacity = 0.5
//     UIApplication.shared.statusBarStyle = .lightContent
    }
}
