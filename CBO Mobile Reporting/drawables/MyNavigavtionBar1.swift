//
//  MyNavigavtionBar1.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 27/02/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit



class MyNavigavtionBar1: UINavigationController {
    @IBOutlet weak var myNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        myNavigationBar.barTintColor = AppColorClass.colorPrimary
        //     UIApplication.shared.statusBarStyle = .lightContent
    }
}
