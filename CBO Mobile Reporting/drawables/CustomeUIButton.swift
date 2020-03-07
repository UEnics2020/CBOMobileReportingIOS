//
//  CustomeUIButton.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 05/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class CustomeUIButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func setText(text : String){
        self.setTitle(text, for: .normal)
    }
    func getText() -> String{
        return self.title(for: .normal)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = AppColorClass.textColorPrimary
        let disabledColor = color
        
//        let gradientColor1 = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1).cgColor
//        let gradientColor2 = UIColor(red: 42.0 / 255.0, green: 63.0 / 255.0, blue: 122.0 / 255.0, alpha: 1).cgColor
        
        let btnFont = "System"
        let bthWidth = frame.width
        let btnHeight = frame.height
        
    
        self.frame.size = CGSize(width: bthWidth, height: btnHeight)
        self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)
        
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor = color.cgColor
        self.backgroundColor = AppColorClass.colorPrimaryDark
     
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        self.titleLabel?.font = UIFont(name: btnFont, size: 18)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitle(self.titleLabel?.text, for: .normal)
        
        
       
//        let btnGradient = CAGradientLayer()
//        btnGradient.frame = self.bounds
//       // btnGradient.colors = [gradientColor1, gradientColor2]
//        self.layer.insertSublayer(btnGradient, at: 0)
       
    }

    


}
