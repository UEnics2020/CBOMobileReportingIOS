//
//  AppAlert.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 19/02/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit


protocol OnClickListener  : class {
    func onPositiveClicked(item : UIView?,  result : String);
    func onNegativeClicked(item: UIView?, result : String);
}


class AppAlert : NSObject {

    fileprivate static var ourInstance : AppAlert!
    private var positiveTxt : String = "OK";
    private var nagativeTxt : String = "Cancel";
    
    
    private override init(){
        
    }
    
    public static func getInstance() -> AppAlert{
        if ourInstance == nil{
            ourInstance = AppAlert()
        }
        return ourInstance
    }

    
    public func getPositiveTxt() -> String {
        return positiveTxt;
    }
    
    public func setPositiveTxt( positiveTxt : String) -> AppAlert {
        self.positiveTxt = positiveTxt;
        return self;
    }
    
    public func getNagativeTxt() -> String{
        return nagativeTxt;
    }
    
    public func setNagativeTxt( nagativeTxt : String) -> AppAlert {
        self.nagativeTxt = nagativeTxt;
        return self;
    }
    
    public func getAlert( vc : CustomUIViewController,  title : String, massege : String){
        Alert(vc: vc, title: title, massege: massege){
            
        }
    }
    
    public func Alert( vc : CustomUIViewController,  title : String, massege : String, listener :@escaping () -> Void){
        var alertViewController : UIAlertController!
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            listener()
        }
        alertViewController = UIAlertController(title: "\(title)!!!", message: massege, preferredStyle: .alert)
        alertViewController.addAction(ok)
        
        vc.present(alertViewController, animated: true, completion: nil)
    }
    
    public func DecisionAlert( vc : CustomUIViewController,  title : String, massege : String, listener :@escaping () -> OnClickListener){
    
        var alertViewController : UIAlertController!
        let cancel = UIAlertAction(title: getNagativeTxt(), style: .cancel) { (action) in
            listener().onNegativeClicked(item: nil, result: "")
        }
        let ok = UIAlertAction(title: getPositiveTxt(), style: .default) { (action) in
            listener().onPositiveClicked(item: nil, result: "")
        }
        setNagativeTxt(nagativeTxt: "Cancel");
        setPositiveTxt(positiveTxt: "OK");
        
        alertViewController = UIAlertController(title: "\(title)!!!", message: massege, preferredStyle: .alert)
            alertViewController.addAction(cancel)
            alertViewController.addAction(ok)
        
        vc.present(alertViewController, animated: true, completion: nil)
        
    }
  
}
