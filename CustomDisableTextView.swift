//
//  CustomDisableTextView.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 17/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit

class CustomDisableTextView: CustomTextView {

    
    override func awakeFromNib() {
        self.myCustomeTextVIew.isUserInteractionEnabled = false
    }
}
