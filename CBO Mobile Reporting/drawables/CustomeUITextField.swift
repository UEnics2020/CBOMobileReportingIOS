//
//  CustomeUITextField.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 05/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import Foundation
import UIColor_HexRGB
class CustomeUITextField: UITextField {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        //            let darkGrey = UIColor(hexNum: 23323323 , alpha: 1.0)
        let lightGrey =  UIColor(hex:"#267b1b")
        //  let lightGreyRect = UIBezierPath(rect: rect)
        let width = rect.size.width
        let height = rect.size.height
        let yValue = rect.origin.y
        let xValue = rect.origin.x
        
        
        self.layer.borderColor = lightGrey?.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 4
        
        lightGrey?.setFill()
        //    lightGreyRect.fill()
        let darkGreyRect = UIBezierPath(rect: CGRect(x: xValue, y:yValue + ((3 * height)/3), width: width, height: height/3))
        //            darkGrey?.setFill()
        darkGreyRect.fill()
        let darkGreyRect2 = UIBezierPath(rect: CGRect(x: xValue+3, y:yValue, width: width - 6, height: height))
        //            darkGrey?.setFill()
        darkGreyRect2.fill()
        let whiteRect = UIBezierPath(rect: CGRect(x: xValue + 4, y:yValue + 1, width: width - 8, height: height - 4))
        UIColor.white.setFill()
        whiteRect.fill()
    }
    
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x += rightPadding
        return textRect
    }
    
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    
    @IBInspectable var leftPadding: CGFloat = 5
    @IBInspectable var rightPadding : CGFloat = 5
    
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
            
            
            
            
            let slashRight = UIView(frame: CGRect(x: 0 , y: 1.0, width: 1, height: self.frame.size.height - 8.0))
            slashRight.backgroundColor = UIColor.black
            
            
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = color
            rightView = imageView
            
            rightView?.addSubview(slashRight)
            
        } else {
            rightViewMode = UITextFieldViewMode.never
            rightView = nil
        }
        
        if let image = leftImage {
            leftViewMode = UITextFieldViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
            
            let slashLeft = UIView(frame: CGRect(x: 35, y: 1.0, width: 1, height: self.frame.size.height - 8.0))
            slashLeft.backgroundColor = UIColor.black
            
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = color
            
            leftView = imageView
            
            leftView?.addSubview(slashLeft)
        } else {
            leftViewMode = UITextFieldViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
    }
    
    
}


extension CustomeUITextField{
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    
}

