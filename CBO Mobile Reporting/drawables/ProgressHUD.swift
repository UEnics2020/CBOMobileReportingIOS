//
//  ProgressHUD.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 05/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import Foundation
import UIKit

class ProgressHUD: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
            label.numberOfLines = 0
        }
    }
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .light)
    let vibrancyView: UIVisualEffectView
    var vc  = CustomUIViewController()
    
    init(vc : CustomUIViewController) {
        self.vc = vc
        self.text = "Please Wait..."
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if let superview = self.superview {
            
            let width = superview.frame.size.width - 50 /// 2.3
            let height: CGFloat = 70.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds
            
            let activityIndicatorSize: CGFloat = 60
            activityIndictor.frame = CGRect(x: 5,
                                            y: height / 2 - activityIndicatorSize / 2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
            
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.left
            label.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label.textColor = AppColorClass.colorPrimaryDark
            label.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    func dismiss()  {
        self.isHidden = true
        self.removeFromSuperview()
        activityIndictor.stopAnimating()
         UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func show(text : String){
        self.text = text
        vc.view.addSubview(self)
        self.isHidden = false
        self.setup()
    }
    
    func hide() {
        
    }
}
