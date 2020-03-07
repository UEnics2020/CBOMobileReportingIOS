//
//  FakeLoginViewController.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 23/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import UserNotifications
class FakeLoginViewController: CustomUIViewController {

    let cbohelp : CBO_DB_Helper = CBO_DB_Helper.shared
    var context : CustomUIViewController!
    var customVariablesAndMethod : Custom_Variables_And_Method!
    var syncServices : SyncService!
    @IBOutlet weak var versionlbl: UILabel!
    @IBOutlet weak var tfEnterPin: CustomeUITextField!
    @IBOutlet weak var alertEnterPin: UIImageView!
    @IBOutlet weak var myView: UIView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view
    }
    
    
    func addNotification(){
        
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                    
                    // Schedule Local Notification
                    self.scheduleLocalNotification()
                })
            case .authorized:
                // Schedule Local Notification
                self.scheduleLocalNotification()
            case .denied:
                print("Application Not Allowed to Display Notifications")
            case .provisional:
                 print("Application Not Allowed to Display Notifications")
            }
        }
        
    }
    
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    
    private func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "Hello"
        notificationContent.subtitle = "Local Notifications"
        notificationContent.body = "CBOInfotech is Wishing you good Morning"
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.0, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "myNotification", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        
        if(cbohelp.getCOMP_NAME() == "-1"){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainstoryboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            appDelegate.window?.rootViewController = vc
            self.dismiss(animated: true, completion: nil)
        }else{
            
            context = self
            manageView(manage: false)
            customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
            
            versionlbl.text = "Version : \(Custom_Variables_And_Method.VERSION)"
            
            let img = UIImage(named: "login_bg.png")
            self.myView.layer.contents = img?.cgImage
            alertEnterPin.isHidden = true
            
            if (customVariablesAndMethod.internetConneted(context: self , ShowAlert: false)) {
                
                syncServices = SyncService(context: self)
//                self.progess = ProgressHUD(vc : self)
//                self.progess.show(text: "Please Wait.. \nRegistration in progess..." )
                self.syncServices.DCR_sync_all(responseCode: -1,ReplyYN : "N")
                
            }
        }
    }
    
    func IscallsFound() -> Bool{
        var result = cbohelp.getmenu_count(table: "phdcrdr_rc");
        result += cbohelp.getmenu_count(table: "tempdr");
        result += cbohelp.getmenu_count(table: "chemisttemp");
        result += cbohelp.getmenu_count(table: "phdcrstk");
        result += cbohelp.getmenu_count(table: "NonListed_call");
        result += cbohelp.getmenu_count(table: "Tenivia_traker");
        return result>0;
    }
    
    func clearDiskCache(){
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let diskCacheStorageBaseUrl = myDocuments.appendingPathComponent("/Cbo/")
        guard let filePaths = try? fileManager.contentsOfDirectory(at: diskCacheStorageBaseUrl, includingPropertiesForKeys: nil, options: []) else { return }
        print(filePaths)
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
   
    @IBAction func pressedLoginButton(_ sender: CustomeUIButton) {
         //addNotification()
        
        let pin = cbohelp.getPin()
        
        if ((tfEnterPin.text?.isEmpty)!) {
            customVariablesAndMethod.getAlert(vc: context , title: "Enter pin", msg: "Enter your Pin First....")
        }else if ( tfEnterPin.text == pin ){


            tfEnterPin.text = ""
            
            let dor = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "doryn",defaultValue: "N");
            let dos = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "dosyn",defaultValue: "N");
            let appVersion = Int(Custom_Variables_And_Method.VERSION);
            let dbVersion1 = Int(cbohelp.getNewVersion());

            if (customVariablesAndMethod.IsGPS_GRPS_ON(context: context)) {
                    if (dor == "Y" || dos == "Y") {
                        customVariablesAndMethod.getAlert(vc: context ,title: "Alert !!!!",msg: "Please contact your Administrator");
                    } else {

                        if (cbohelp.getNewVersion() == "" || dbVersion1! <= appVersion!){

                            let work_type_Selected = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: context,key: "work_type_Selected",defaultValue: "w");
                            switch (work_type_Selected){
                            case "l":
                                customVariablesAndMethod.msgBox(vc: context, msg: "Final Submit Pending...",completion: {_ in
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "FinalSubmit") as!
                                    FinalSubmit
                                    vc.VCIntent["title"] = "Final Submit"
                                    vc.VCIntent["Back_allowed"] = "N"
                                    self.present(vc, animated: true, completion: nil)
                                })
                                break;
                            case "n":
                                
                                
                                customVariablesAndMethod.msgBox(vc: context, msg: "Final Submit Pending...",completion: {_ in
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier: "Expenses_NotWorkingVC") as!
                                    Expenses_NotWorkingVC
                                    vc.VCIntent["title"] = "Final Submit"
                                    vc.VCIntent["form_type"] = "final"
                                    vc.VCIntent["Back_allowed"] = "N"
                                    self.present(vc, animated: true, completion: nil)
                                })
                                break;
                            default:
                                Custom_Variables_And_Method.GPS_STATE_CHANGED_TIME=customVariablesAndMethod.get_currentTimeStamp();
                                self.performSegue(withIdentifier: "FakeLogin", sender: nil)
                            }

                        } else {
                            customVariablesAndMethod.getAlert(vc: context, title: "Update Your App !!!", msg: "Service for this App has Stoped...\n Please Update your App")
//                            startActivity(new Intent(getApplicationContext(), Load_New.class));
//                            finish();

                        }
                }
            }
        }else{
            tfEnterPin.text = ""

                alertEnterPin.isHidden = false

                var negative = "Logout!"
//                if (IscallsFound()){
//                    negative =  "Forgot pin ?"
//                }

                let positive = "Try Again"
                let title = "Invalid Pin!!!"
                let msg = "You entered a wrong pin\n Re-Enter your pin and try again"

                let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
                let cancelBtn = UIAlertAction(title: positive, style: .default , handler: nil)

                let okButton = UIAlertAction(title: negative, style: .cancel , handler:  { (alert: UIAlertAction!) in
//                    if (self.IscallsFound()){
////                        Intent i = new Intent(getApplicationContext(), FogetPin.class);
////                        startActivity(i);
//                        self.reset_pin_delete_all_calls();
//
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                        self.present(vc, animated: true, completion: nil)
//                        self.dismiss(animated: true, completion: nil)
//
//                    }else {
                    self.clearDiskCache()
                        self.reset_pin_delete_all_calls();
                    
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let mainstoryboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        appDelegate.window?.rootViewController = vc
                        self.dismiss(animated: true, completion: nil)
                
                    //}

                })
                alert.addAction(okButton)
                alert.addAction(cancelBtn)
                context.present(alert, animated: true, completion: nil)

        }
}


    func reset_pin_delete_all_calls(){
        cbohelp.deleteLogin();
        cbohelp.deleteLoginDetail();
        cbohelp.deleteFTPTABLE();
        cbohelp.delete_Mail(mail_id: "");
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "WEBSERVICE_URL", value: "");
        customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: context, key: "DOB_DOA_notification_date", value: "");
        //myCustomMethod.stopDOB_DOA_Remainder();
    
        cbohelp.DropDatabase();
    
//    Intent i = new Intent(getApplicationContext(), LoginMain.class);
//    i.putExtra("picture", byteArray);
//    startActivity(i);
    }
}

extension FakeLoginViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
}

