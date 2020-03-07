//
//  checkBox.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 10/01/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
protocol CheckBoxDelegate : class {
    
    func onChackedChangeListner(sender : CheckBox, ischecked : Bool);
}

class CheckBox: UIView {
    var SelfObj : CheckBox!
    weak var delegate: CheckBoxDelegate?
    var HitDelegate = true
    @IBOutlet weak var checkBocButton: UIButton!
    private  var SelfTag : Any!
    @IBOutlet var view: UIView!

    func getTag() -> Any {
        return  SelfTag
    }
    func setTag(tag : Any){
        SelfTag = tag
    }
    
    func isChecked() -> Bool {
        return  checked
    }
    func setChecked(checked : Bool){
        self.checked = !checked
        HitDelegate = false
        buttonPressed(sender: checkBocButton)
    }
  private var checked : Bool = false
        required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SelfObj = self
        Bundle.main.loadNibNamed("CheckBox", owner: self, options: nil)
        self.addSubview(view)
        view.frame = self.bounds
        
            self.checkBocButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        checkBocButton.setImage(UIImage( named: "unchecked.png") , for: .normal)
            

    }
    
    @objc func buttonPressed (sender : UIButton){
        checked = !checked
        
        if checked {
            checkBocButton.setImage(UIImage( named: "checked.png") , for: .normal)
        }else {
            checkBocButton.setImage(UIImage( named: "unchecked.png") , for: .normal)
        }
        
        if (HitDelegate){
            delegate?.onChackedChangeListner(sender: SelfObj, ischecked: checked)
        }
        HitDelegate = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
}

