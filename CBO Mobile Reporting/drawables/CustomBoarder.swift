//
//  CustomBoarder.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 25/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
class CustomBoarder : UIView {
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    

    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = AppColorClass.colorPrimary?.cgColor
        if cornerRadius == 0{
            self.layer.cornerRadius =  CGFloat(2)
        }else {
            self.layer.cornerRadius =  CGFloat(cornerRadius)
        }
        if boarderWidth == 0{
            self.layer.borderWidth =  CGFloat(2)
        }else {
            self.layer.borderWidth =  CGFloat(boarderWidth)
        }
        
    
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var boarderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = boarderWidth
        }
    }
}
