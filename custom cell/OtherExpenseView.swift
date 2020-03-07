//
//  OtherExpenseView.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 09/04/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
class OtherExpenseView: UIView {
 
    @IBOutlet weak var topline: UIView!
    @IBOutlet weak var buttomLine: UIView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var remark: UILabel!
    @IBOutlet weak var expHead: UILabel!
    @IBOutlet var view: UIView!
    var obj : OtherExpenseView!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //MARK:- Delegate with same Class type
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        obj = self;
        Bundle.main.loadNibNamed("OtherExpenseView", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
        
        setup()
    }
    
   private func setup (){
    
    topline.backgroundColor = .white
    
    buttomLine.backgroundColor = AppColorClass.colorPrimaryDark
    expHead.textColor = AppColorClass.colorPrimaryDark
    expHead.font = expHead.font.bold()
    
    
    }
    
}
