      //
//  CustomUIViewController.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 18/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import CoreLocation
import Darwin
class CustomUIViewController: UIViewController , UITextFieldDelegate, CLLocationManagerDelegate{
    
    var keyboardHeight : CGFloat = 0.0
    
    var myview : UIView!
    var manage = true;
    var  customVariablesAndMethod1 = Custom_Variables_And_Method.getInstance()
    var FORCEFULLY_ACCEPT_GPS_LOCATION = false
    var Parent_VC : CustomUIViewController? = nil
    var locationManager: CLLocationManager!
    var mcontext : CustomUIViewController!
    
    func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        print(dataFromAPI)
    }
    
    func getDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override public func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
      viewControllerToPresent.modalPresentationStyle = .fullScreen
      super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
   
    override public func viewDidLoad() {
        mcontext = self
        self.modalPresentationStyle = .fullScreen
        if #available(iOS 13.0, *) {
            mcontext.isModalInPresentation = true
        } else {
            // Fallback on earlier versions
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    
        if (customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self,key: "gps_needed",defaultValue: "Y") == "Y") {
        
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            // For use when the app is open & in the background
            locationManager.requestAlwaysAuthorization()
            
            // For use when the app is open
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                // You can change the locaiton accuary here.
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                
            }
        }
        
       
        getDelegate().refressUser()
        
        if( Parent_VC != nil){
            Parent_VC?.dismiss(animated: true, completion: nil)
        }
        
        
    }
    

    
    func manageView(manage : Bool){
        self.manage = manage
    }
    

   
    
  public var VCIntent =  [String : String]()
    public var VCIntentArray = [String : Any]()
    
    // Print out the location to the console
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            
            let msg = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            
            
            let lat = "\(location.coordinate.latitude)"
            let lon = "\(location.coordinate.longitude)"
           
            var lastLatLong =  customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self, key: "shareLatLong", defaultValue: "")
          
            var MyTime = customVariablesAndMethod1.currentTime(context: self);
            
            if (lastLatLong == ("")) {
                //lastLatLong = "0.0,0.0";
                lastLatLong = msg;
                customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareLatLong", value: msg);
                
            }
      
            customVariablesAndMethod1.putObject(context: self,key: "currentBestLocation",location: location);
            //}
            if (lastLatLong == (msg)) {
                customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareLat", value: "" + lat);
                customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareLon", value: "" + lon);
                customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareMyTime", value: "" + MyTime);
               
                Custom_Variables_And_Method.GLOBAL_LATLON = msg;
               
            } else {
                if (IsValidLocation(lat_long_current: msg,who: 0)) {
                    customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareLat", value: "" + lat);
                    customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareLon", value: "" + lon);
                    customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareMyTime", value: MyTime);
                    
                    customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "shareLatLong", value: msg);
                    customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "last_location_update_time_in_minites", value: customVariablesAndMethod1.get_currentTimeStamp());
                    Custom_Variables_And_Method.GLOBAL_LATLON = msg;
                    
                    customVariablesAndMethod1.putObject(context: self,key: "currentBestLocation_Validated",location: location);
                    
                } else {
                    Custom_Variables_And_Method.GLOBAL_LATLON = customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self, key: "shareLatLong",defaultValue: msg);
                }
               
                
            }
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Location Access Disabled",
                                                message: "In order to use the app  we need your location\nPlease Switch ON your GPS and Allow the app to use your Location Always",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

    // Show the popup to the user to switch on the GPS
    func SwitchOnGPS() {
//        let alertController = UIAlertController(title: "GPS switched OFF",
//                                                message: "Please Switch ON your GPS",
//                                                preferredStyle: .alert)
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        alertController.addAction(cancelAction)
//
//        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
//           //"App-Prefs:root=Privacy&path=LOCATION/your.bundle.identifier"
//            if let url = URL(string: "App-prefs:root=MOBILE_DATA_SETTINGS_ID") {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
//        }
//        alertController.addAction(openAction)
//
//        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    func IsValidLocation(lat_long_current : String, who : Int) -> Bool{
        
        
        var last_location = customVariablesAndMethod1.getObject(context: self,key: "currentBestLocation_Validated");
        
        if (last_location.coordinate.latitude == CLLocation().coordinate.latitude){
            return true;
        }
        
        
        var km = distance(lat1: Double(lat_long_current.components(separatedBy: ",")[0])!, lon1: Double(lat_long_current.components(separatedBy: ",")[1])!
            ,  lat2: last_location.coordinate.latitude, lon2: last_location.coordinate.longitude, unit: "K");
        
        
        if(FORCEFULLY_ACCEPT_GPS_LOCATION){
            FORCEFULLY_ACCEPT_GPS_LOCATION=false;
            customVariablesAndMethod1.deleteFmcg_ByKey(vc: self, key: "last_location_update_time_in_minites")
//            customVariablesAndMethod1.setDataInTo_FMCG_PREFRENCE(vc: self, key: "last_location_update_time_in_minites", value: customVariablesAndMethod1.get_currentTimeStamp());
            km=0.0;
        }
        let estimated_time_taken=km/3;             //3km per min allowed

        let current_time=customVariablesAndMethod1.get_currentTimeStamp();
         let last_update_time = customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self, key: "last_location_update_time_in_minites",defaultValue: current_time);
        let real_time_taken = (Double(current_time)! - Double(last_update_time)!)/60; //000; timestamp returns in sec not in milliseconds
        return estimated_time_taken <= real_time_taken;
        
//        if (who>0){
//            if (km>30  && who!=3){
//                //Location loc= latLongFromInternet(context);
//                Location loc=  tracker.getLocation();
//                if (loc!=null) {
//                    return IsValidLocation(context, loc.getLatitude() + "," + loc.getLongitude(), who + 1);
//                }else {
//                    return IsValidLocation(context, lat_long_current, who + 1);
//                }
//            }else {
//                if (estimated_time_taken <= real_time_taken) {
//                    Custom_Variables_And_Method.GLOBAL_LATLON = lat_long_current;
//                    setDataInTo_FMCG_PREFRENCE(context, "shareLatLong", lat_long_current);
//                    setDataInTo_FMCG_PREFRENCE(context, "last_location_update_time_in_minites", get_currentTimeStamp());
//                    putObject(context,"currentBestLocation_Validated",getObject(context,"currentBestLocation",Location.class));
//                }
//                //tracker.stopUsingGPS();
//                return false;
//            }
//        }
//        if (km>30 || IsLocationTooOld(context,0)){
//            // Location loc= latLongFromInternet(context);
//            Location loc=  tracker.getLocation();
//            if (loc!=null) {
//                return IsValidLocation(context, loc.getLatitude() + "," + loc.getLongitude(), who + 1);
//            }else {
//                return IsValidLocation(context, lat_long_current, who + 1);
//            }
//        }else {
//            tracker.stopUsingGPS();
//            return estimated_time_taken <= real_time_taken;
//        }
    }
    
    func IsLocationTooOld( count : Int) -> Bool{
        var  time_difference = 0.0;
            if (customVariablesAndMethod1.getObject(context: self,key: "currentBestLocation_Validated") != CLLocation()) {
            let location_time = customVariablesAndMethod1.getObject(context: self, key: "currentBestLocation_Validated").timestamp.timeIntervalSince1970
            let current_time = Double(customVariablesAndMethod1.get_currentTimeStamp())!;
                time_difference = current_time - location_time;
        }
        let allowed_time = Double(5*60*1000);  // 5min
    
        if(!FORCEFULLY_ACCEPT_GPS_LOCATION) {
            return time_difference == 0 || time_difference > allowed_time;
        }else {
            return false;
        }
    }


@objc func keyboardWillShow(notification: NSNotification) {
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        if keyboardHeight == 0.0 {
            keyboardHeight = keyboardSize.height + 40
            print(keyboardHeight)
            if manage {
                self.view.frame.size.height -= keyboardHeight
            }
        }
//        myview?.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height - (keyboardSize.height) )
    }
}
@objc func keyboardWillHide(notification: NSNotification) {
//    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//        keyboardHeight = keyboardSize.height
//        print(keyboardHeight)
//        myview.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height + (keyboardSize.height) )
          if manage {
            self.view.frame.size.height += keyboardHeight
            keyboardHeight = 0.0
    }
}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}



 func  distance( lat1 : Double ,lon1 : Double, lat2 : Double,  lon2 : Double , unit : String ) -> Double{
    let theta = lon1 - lon2;
    var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta));
    dist = acos(dist);
    dist = rad2deg(rad: dist);
    dist = dist * 60 * 1.1515;
    if (unit == "K") {
        dist = dist * 1.609344;
    } else if (unit == "N") {
        dist = dist * 0.8684;
    }
    
    dist = (dist * 100).rounded()/100
    
    return (dist);
}

/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
/*::    This function converts decimal degrees to radians                         :*/
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
func deg2rad( deg : Double) -> Double {
    let π = Double.pi
    return (deg * π / 180.0);
}

/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
/*::    This function converts radians to decimal degrees                         :*/
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
func rad2deg( rad : Double)-> Double {
    let π = Double.pi
    return (rad * 180 / π);
}





extension CustomUIViewController {
    
    func showToast(message : String , vc : CustomUIViewController) {
        
        let toastLabel = UILabel(frame: CGRect(x: vc.view.frame.size.width/2 - 75, y: vc.view.frame.size.height-100, width: 150, height: 35))
//        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = AppColorClass.colorPrimary
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        vc.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
//            toastLabel.removeFromSuperview()
        })
    }
    
      }
