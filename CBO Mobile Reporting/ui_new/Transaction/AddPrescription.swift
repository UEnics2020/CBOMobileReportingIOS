//
//  AddPrescription.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 09/01/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import UIKit

protocol AddPrescriptionDelegate {
  func pass(data: String)  //data: string is an example parameter
}

class AddPrescription: CustomUIViewController {
    
    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var qty: UITextField!
    @IBOutlet weak var remark: UITextField!
    @IBOutlet weak var viewbox: UIView!
    
    var delegate: AddPrescriptionDelegate!
    var section: Int = 0
    
    var customVariablesAndMethod : Custom_Variables_And_Method!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        viewbox.layer.cornerRadius = 4
      
        //self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
       // self.showAnimate()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
       
        //self.removeAnimate()
        self.dismiss(animated: false, completion: nil)
        
    }
    
    @IBAction func addProdcut(_ sender: AnyObject) {
        
        //self.view.removeFromSuperview()
        if product.text!.isEmpty || qty.text!.isEmpty || remark.text!.isEmpty {
            
            customVariablesAndMethod.getAlert(vc: self, title: "Error !!!", msg: "Please fill all fields");
            
        } else {
            //delegate?.pass(data: "check")
            UserDefaults.standard.set(product.text!, forKey: "product")
            UserDefaults.standard.set(qty.text!, forKey: "qty")
            UserDefaults.standard.set(remark.text!, forKey: "remark")
            UserDefaults.standard.set(section, forKey: "section")
            self.dismiss(animated: false, completion: nil)
           // delegate?.pass(data: "check")
            
        }
    }
    
    
    func showAnimate()
       {
           self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           self.view.alpha = 0.0;
           UIView.animate(withDuration: 0.25, animations: {
               self.view.alpha = 1.0
               self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           });
       }
       
       func removeAnimate()
       {
           UIView.animate(withDuration: 0.25, animations: {
               self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
               self.view.alpha = 0.0;
               }, completion:{(finished : Bool)  in
                   if (finished)
                   {
                       self.view.removeFromSuperview()
                   }
           });
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
