//
//  CBOContantViewController4.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 07/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

class ReportMenuInGrid: CustomUIViewController , MenuGridAdaptorDelegate{

    var adpator : MenuGridAdaptor!
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    fileprivate var  Report_Menu = [[String : String]]()
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Report_Menu = cbohelp.getMenu(menu: "REPORTS", code: "" )
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        // Do any additional setup after loading the view.
        
        adpator = MenuGridAdaptor(collectionViewGrid: collectionView, vc: self, menu: Report_Menu )
        
        adpator.delegate = self
        
        // Do any additional setup after loading the view.
        
        collectionView.delegate = adpator;
        
        collectionView.dataSource = adpator;
        
    }
    override func viewDidAppear(_ animated: Bool) {
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Report_Menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? CBOContantCollectionViewCell {
          
            cell1.myImageView.image = setImage(menu_code:  Report_Menu[indexPath.row]["menu_code"]! )
            cell1.myNotificationBackground.layer.cornerRadius = cell1.myNotificationBackground.frame.height / 2
            cell1.myNotificationBackground.isHidden = true
            cell1.myNotificationCounter.text = ""
            cell1.myLabel.text = Report_Menu[indexPath.row]["menu_name"]
            return cell1
        }
        return UICollectionViewCell()
    }
    
    
    func setImage(menu_code : String) -> UIImage{
        var image : UIImage!
        
        if (menu_code == ("R_LOGUNL")) {
              image = UIImage(named: "logged_unlogged_white.png")
        } else if (menu_code == ("R_DCRRPT")) {
              image = UIImage(named: "dcr_reports_white.png")
        } else if (menu_code == ("R_DASH")) {
              image = UIImage(named: "secondary_sales_white.png")
        } else if (menu_code == ("R_DRWISE")) {
              image = UIImage(named: "dr_wise_reports.png")
        } else if (menu_code == ("R_TP")) {
              image = UIImage(named: "tp_reports_.png")
        } else if (menu_code == ("R_SPO")) {
              image = UIImage(named: "spo_reports.png")
        }else if (menu_code == ("DOB_DOA")) {
              image = UIImage(named: "birthday.png")
        }else if (menu_code == ("MSG_HO")) {
              image = UIImage(named: "msg_ho.png")
        }else if (menu_code == ("GIFT_DIST")) {
              image = UIImage(named: "gift_distribution_status.png")
        }else{
            image = UIImage(named: "reset_day_plan_white.png")
        }
        
        return image!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onClickListener(menu_code: Report_Menu[indexPath.row]["menu_code"]! , name : Report_Menu[indexPath.row]["menu_name"]!)
        
    }
    
    
    func onClickListener(menu_code : String , name : String) {
        let url = cbohelp.getMenuUrl(menu: "REPORTS", menu_code: menu_code)
        
        if (!url.isEmpty){
            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
        }else {
            
            switch menu_code{
            case "R_DCRRPT" :
                if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DCR_Report" ) as! DCR_Report

                    vc.VCIntent["title"] = name
                    vc.VCIntent["type"] = "DCRRPT"
                    self.present(vc, animated: true, completion: nil)
                }
                break
            case "R_DASH" :
                if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DashboardReport" ) as! DashboardReport

                    vc.VCIntent["title"] = name
                    self.present(vc, animated: true, completion: nil)
                }
                break
                    
            case "R_SPO":
                
               if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SPO_Report" ) as! SPO_Report
                    
                    vc.VCIntent["title"] = name //"SPO Consignee Wise Report"
                    self.present(vc, animated: true, completion: nil)
                }
                break;
            case "R_DRWISE":
                
                if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DCR_Report" ) as! DCR_Report
                    
                    vc.VCIntent["title"] = name
                    vc.VCIntent["type"] = "DRWISE"
                    self.present(vc, animated: true, completion: nil)
                }
                break
                
                
            case "R_TP":
                
                if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DCR_Report" ) as! DCR_Report
                    
                    vc.VCIntent["title"] = name
                    vc.VCIntent["type"] = "TP"
                    self.present(vc, animated: true, completion: nil)
                }
                
                break;
                
            case "DOB_DOA" :
                
                if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DOB_DOA" ) as! DOB_DOA

                    vc.VCIntent["title"] = name
                    self.present(vc, animated: true, completion: nil)
                }
                break
                
            case "R_LOGUNL":
                if(customVariablesAndMethod.internetConneted(context: self)){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "LoggedUnloggedReport" ) as! LoggedUnloggedReport

                    vc.VCIntent["title"] = name
                    self.present(vc, animated: true, completion: nil)
                }
                break
                
            default:
                customVariablesAndMethod.getAlert(vc: self, title: "Under Development", msg: "\(name) is presently under Development...")
            }
        }
        
//        if (!url.isEmpty){
//            customVariablesAndMethod.setDataForWebView(vcself: self, mode: 0, title: name, url: url)
//        } else if (menu_code == ("R_LOGUNL")) {
//              print("User has been selected \(menu_code) index cell")
//        } else if (menu_code == ("R_DCRRPT")) {
//            print("User has been selected \(menu_code) index cell")
//        } else if (menu_code == ("R_DASH")) {
//            print("User has been selected \(menu_code) index cell")
//        } else if (menu_code == ("R_DRWISE")) {
//            print("User has been selected \(menu_code) index cell")
//        } else if (menu_code == ("R_TP")) {
//          print("User has been selected \(menu_code) index cell")
//        } else if (menu_code == ("R_SPO")) {
//            print("User has been selected \(menu_code) index cell")
//        }else if (menu_code == ("DOB_DOA")) {
//         print("User has been selected \(menu_code) index cell")
//        }else if (menu_code == ("MSG_HO")) {
//            print("User has been selected \(menu_code) index cell")
//        }else if (menu_code == ("GIFT_DIST")) {
//            print("User has been selected \(menu_code) index cell")
//        }else{
//            print("User has been selected \(menu_code) index cell")
//        }
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let size = objCustomCollectionViewLayout.MyCollectionViewLayoutSet(collectionView: collectionView, collectionViewLayout: collectionViewLayout as! UICollectionViewFlowLayout)
//
//        return size
//
//    }
    
}

