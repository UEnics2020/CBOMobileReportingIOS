//
//  Custom_Variable_And_Method.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 19/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//
import UIKit
import Foundation
import SystemConfiguration
import CoreLocation
import SwiftKeychainWrapper
class Custom_Variables_And_Method {
    
    fileprivate static var ourInstance : Custom_Variables_And_Method!
    //fileprivate static var LocationInstance : GPS_LOCATION_PROVIDER!
   
    //  private static CBO_DB_Helper cbohelp;
    

    public static var vc : CustomUIViewController!
    public static var ip : String!
    public static var user : String!
    public static var pwd : String!
    public static var db : String!
    public static var PA_ID : Int = 0
    public static var PA_NAME : String!
    public static var HEAD_QTR : String!
    public static var DESIG : String!
    public static var DCR_ID : String = "0"
    public static var name : String!
    public static var work_val : String!
    public static var FAILED_REASON : String!
    public static var location_required = "N"
    public static var WORKING_TYPE : String!
    public static var CHEMIST_NOT_VISITED : String!
    public static var STOCKIST_NOT_VISITED : String!
    public static var DR_NAME : String!
    public static var user_name : String!
    public static var GLOBAL_LATLON = "0.0,0.0"
    public static var FMCG_PREFRENCE = "FMCG_PREFRENCE"
    public static var work_with_area_id = ""
    public static var ROOT_NEEDED : String!
    public static var CHEMIST_ID : String!
    public static var DOCTOR_CHECK = ""
    public static var COMPANY_NAME : String!
    public static var checkVersion = "20200302"
    public static var VERSION = "20200302"
    public static var RPT_DATE : String!
    public static var EMP_ID : String!
    public static var DCR_DATE : String!
    public static var DCR_DATE_TO_SUBMIT : String! = "Y"
    public static var RPT_TIME : String!
    public static var DR_ID : String! = "0"
    public static var VISUAL_REQUIRED : String!
    public static var global_address : String = ""
    public static var WEB_URL : String!
    public static var pub_area : String!
    public static var pub_desig_id : String!
    public static var pub_doctor_spl_code : String!
    public static var doctor_image_name : String!
    public static var DOCTOR_SPL_ID : Int!
    public static var COMPANY_CODE : String!
    public static var lastLocation : String!
    public static var SELECTED_AREA : String!
    public static var INTERNET_REQ : String = ""
    public static var GCMToken : String = ""
    
    public static var extraFrom = ""
    public static var extraTo = ""
    public static var CURRENTTAB = 0
    public static var BATTERYLEVEL="0"
    public static var SAMPLE_POB_MANDATORY="N"
    
    public static var GPS_STATE_CHANGED=true;
    public static var GPS_STATE_CHANGED_TIME="0";
    public static var DcrPending_datesList = [String]()
    //011 - 33667777
    
    private init(){
        
    }
    
    static func getIntValue(value : String ) -> Int{
        return (Int(value) ?? 0)
    }
    
    
    
    public static func getInstance() -> Custom_Variables_And_Method{
        if ourInstance == nil{
            ourInstance = Custom_Variables_And_Method()
        }
        return ourInstance
    }
    
//    func getAlert(vc : CustomUIViewController , title : String , msg : String) {
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
//        let okButton = UIAlertAction(title: "Ok", style: .cancel , handler: nil)
//        alert.addAction(okButton)
//        vc.present(alert, animated: true, completion: nil)
//    }
    
    
    func msgBox(vc : CustomUIViewController , msg : String) {
        getAlert(vc: vc,title: "Alert !!!",msg: msg);
//        vc.showToast(message: msg, vc: vc)
    }
    func msgBox(vc : CustomUIViewController , msg : String, completion : @escaping (UIAlertAction)  -> Void)  {
        let alert = UIAlertController(title: "Alert !!!", message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel , handler: completion)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func getAlert(vc : CustomUIViewController , title : String , msg : String, completion : @escaping (UIAlertAction)  -> Void)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel , handler: completion)
        alert.addAction(okButton)
        vc.present(alert, animated: true, completion: nil)
    }
    func getDecisionAlert(vc : CustomUIViewController , title : String ,Ok_Title : String , msg : String, completion : @escaping (UIAlertAction)  -> Void)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: Ok_Title, style: .cancel , handler: completion)
        alert.addAction(okButton)
        let cancelbtn = UIAlertAction(title: "Cancel", style: .default , handler: nil)
        alert.addAction(cancelbtn)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func getAlert(vc : CustomUIViewController , title : String , msg : String) {
        getAlert(vc: vc,title: title,msg: msg,table_list: nil,url: nil,resultVisible: false);
    }
    
    func getAlert(vc : CustomUIViewController , title : String , msg : String,resultVisible : Bool) {
        getAlert(vc: vc,title: title,msg: msg,table_list: nil,url: nil,resultVisible: resultVisible);
    }
    func getAlert(vc : CustomUIViewController , title : String , msg : String, url : String) {
        getAlert(vc: vc,title: title,msg: msg,table_list: nil,url: url,resultVisible: false);
    }
    func getAlert(vc : CustomUIViewController , title : String , msg : String, table_list : [String] ) {
        getAlert(vc: vc,title: title,msg: nil,table_list: table_list,url: nil,resultVisible: false);
    }
    
    
    func getAppName() -> String{
        let infoDictionary: NSDictionary = (Bundle.main.infoDictionary as NSDictionary?)!
        let appName: NSString = infoDictionary.object(forKey: "CFBundleName") as! NSString
        
        NSLog("Name \(appName)")
        
        return appName as String
    }
    
    
    
    func getAlert(vc : CustomUIViewController , title : String , msg : String? = nil, table_list : [String]? = nil, url : String? = nil, resultVisible : Bool) {
        
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .cancel , handler:  { (alert: UIAlertAction!) in
                if (url != nil && !(url?.isEmpty)!  && url != ""){
                    self.setDataForWebView(vcself: vc, mode: 0,title: title,url: url!)
                }
            })
            alert.addAction(okButton)
            vc.present(alert, animated: true, completion: nil)
        
//    LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
//    final View dialogLayout = inflater.inflate(R.layout.alert_view, null);
//    final TextView Alert_title= (TextView) dialogLayout.findViewById(R.id.title);
//
//    final TextView Alert_message= (TextView) dialogLayout.findViewById(R.id.message);
//    final TableLayout Alert_message_list= (TableLayout) dialogLayout.findViewById(R.id.table_view);
//    final Button Alert_Positive= (Button) dialogLayout.findViewById(R.id.positive);
//    Alert_title.setText(title);
//
//    final TextView pa_id_txt= (TextView) dialogLayout.findViewById(R.id.PA_ID);
//    pa_id_txt.setText(""+PA_ID);
//
//    final TextView report= (TextView) dialogLayout.findViewById(R.id.report);
//    if (reportVisible) {
//    report.setVisibility(View.VISIBLE);
//    }
//
//    if (table_list==null ) {
//    Alert_message.setText(massege);
//    Alert_message_list.setVisibility(View.GONE);
//    }else{
//    Alert_message.setVisibility(View.GONE);
//    TableRow.LayoutParams params = new TableRow.LayoutParams(0, TableLayout.LayoutParams.WRAP_CONTENT, 1f);
//    TableRow.LayoutParams params1 = new TableRow.LayoutParams(0, 1, 1f);
//    Alert_message_list.removeAllViews();
//    for (int i = 0; i < table_list.length; i++) {
//    TableRow tbrow = new TableRow(context);
//    if ( !table_list[i].contains(":")) {
//    TextView t1v = new TextView(context);
//    t1v.setText(table_list[i].replace("\n",""));
//    t1v.setPadding(15, 10, 15, 10);
//    t1v.setBackgroundColor(0xff5477cf);
//    t1v.setTextColor(Color.WHITE);
//    t1v.setTextSize(16);
//    t1v.setTypeface(Typeface.DEFAULT, Typeface.BOLD);
//    t1v.setLayoutParams(params);
//    tbrow.addView(t1v);
//    }else{
//    TextView t1v = new TextView(context);
//    t1v.setText(table_list[i]);
//    t1v.setPadding(15, 5, 15, 0);
//    t1v.setTextColor(Color.BLACK);
//    t1v.setLayoutParams(params);
//    t1v.setTypeface(Typeface.MONOSPACE, Typeface.NORMAL);
//    tbrow.addView(t1v);
//    }
//    /* TextView t2v = new TextView(context);
//     t2v.setText(table_list[i]);
//     t2v.setPadding(5, 5, 5, 0);
//     t2v.setTextColor(Color.BLACK);
//     t2v.setGravity(Gravity.CENTER);
//     tbrow.addView(t2v);*/
//    TableRow tbrow1 = new TableRow(context);
//    TextView t3v = new TextView(context);
//    t3v.setPadding(15, 1, 15, 0);
//    t3v.setLayoutParams(params1);
//    t3v.setBackgroundColor(0xff125688);
//    tbrow1.addView(t3v);
//    Alert_message_list.addView(tbrow);
//    Alert_message_list.addView(tbrow1);
//    }
//    }
//
//
//    AlertDialog.Builder builder1 = new AlertDialog.Builder(context);
//
//
//    final AlertDialog dialog = builder1.create();
//
//    dialog.setView(dialogLayout);
//
//
//    report.setOnClickListener(new View.OnClickListener() {
//    @Override
//    public void onClick(View view) {
//    /*Location currentBestLocation=getObject(context,"currentBestLocation",Location.class);
//     List toEmailList = Arrays.asList("mobilereporting@cboinfotech.com".split("\\s*,\\s*"));
//     *//*new SendMailTask().execute("mobilereporting@cboinfotech.com",
//     "mreporting",toEmailList , Custom_Variables_And_Method.COMPANY_CODE+": Out of Range Error report",context.getResources().getString(R.string.app_name)+"\n Company Code :"+Custom_Variables_And_Method.COMPANY_CODE+"\n DCR ID :"+Custom_Variables_And_Method.DCR_ID+"\n PA ID : "+Custom_Variables_And_Method.PA_ID+"\n App version : "+Custom_Variables_And_Method.VERSION+"\n massege : "+massege+"\n Error Alert :"+title+"\n"+
//     "\nLocation-timestamp : "+currentBestLocation.getTime()+"\nLocation-Lat : "+currentBestLocation.getLatitude()+
//     "\nLocation-long : "+currentBestLocation.getLongitude()+"\n time : " +currentTime(context)+"\nlatlong : "+ getDataFrom_FMCG_PREFRENCE(context,"shareLatLong",Custom_Variables_And_Method.GLOBAL_LATLON));
//     *//*
//
//     if (ContextCompat.checkSelfPermission(context, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED || ContextCompat.checkSelfPermission(ExpenseRoot.this, Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
//     //takePictureButton.setEnabled(false);
//     ActivityCompat.requestPermissions(context, new String[] { Manifest.permission.CAMERA,Manifest.permission.WRITE_EXTERNAL_STORAGE }, ExpenseRoot.this.REQUEST_CAMERA);
//     Toast.makeText(context, "Please allow the permission", Toast.LENGTH_LONG).show();
//
//     }else {
//
//     capture_Image();
//     }*/
//    //new SendAttachment((Activity) context).execute("HELLO JAVED",);
//    dialog.dismiss();
//    }
//    });
//    dialog.setCancelable(false);
//    dialog.show();
    }

    
    
    func drChemEntryAllowed(context : CustomUIViewController) -> Bool{
    
        var toDayDate = getDataFrom_FMCG_PREFRENCE(vc: context,key: "CUR_DATE",defaultValue: currentDate());
        let dcrDateReal = getDataFrom_FMCG_PREFRENCE(vc: context,key: "dcr_date_real",defaultValue: "")
        let dcrPlanedDate = getDataFrom_FMCG_PREFRENCE(vc: context,key: "Dcr_Planed_Date",defaultValue: "")
        if (dcrDateReal == "Y") {
            toDayDate = "Y"
        }
    
        if ((dcrDateReal == dcrPlanedDate) && (toDayDate != dcrPlanedDate)) {
            return false
        }else {
            return true
        }
    
    }
    
    func IsBackDate(context : CustomUIViewController) -> Bool {
    
        let toDayDate = getDataFrom_FMCG_PREFRENCE(vc: context,key: "CUR_DATE",defaultValue: currentDate());
        let DCR_DATE = getDataFrom_FMCG_PREFRENCE(vc: context,key: "DCR_DATE", defaultValue: "");
        if (DCR_DATE == toDayDate) {
            return false;
        } else {
            return true;
        }
    
    }
    
    
    func currentDate() -> String{
        return currentDate(dateFormat: "MM/dd/yyyy")
    }
    
    func currentDate(dateFormat : String ) -> String{
        
        let date : Date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = dateFormat
        let currentDate = dateFormatter.string(from: date)
        
        
        return currentDate;
    }
    ///////////////////////////////Getting Current time ///////////////////
    
    func currentTime(context : CustomUIViewController?) -> String {
        return  currentTime(context: context,addServerTimeDifference: true);
    }
    
    func currentTime(context : CustomUIViewController?, addServerTimeDifference : Bool) -> String {
        var date = Date()
        
        let calendar = NSCalendar.current
         if (addServerTimeDifference){
            date = calendar.date(byAdding: .minute, value: Int( getDataFrom_FMCG_PREFRENCE( key: "DcrPlanTime_server", defaultValue: "0" ))!, to: date)!
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let currentDate = dateFormatter.string(from: date)
        
        return currentDate
    
    }
    
    func get_currentTimeStamp() -> String {
        //return  "\(Date().datetime)"
        return "\(Date().timeIntervalSince1970)"
    }
    
    var batteryNotificationHandler: Any?
    
    ///A computed property that returns the battery level as an int, using rounding.
    var batteryLevel: Int {
        return Int(round(UIDevice.current.batteryLevel * 100))
    }
    
    ///A function to display the current battery level to a label,
    ////or the string "n/a" if the battery level can't be determined.
    func getBatteryLevel()  {
        if UIDevice.current.batteryState == .unknown {
            Custom_Variables_And_Method.BATTERYLEVEL = "n/a"
            
        } else {
           Custom_Variables_And_Method.BATTERYLEVEL = "\(self.batteryLevel)"
        }
    }
    
    
    func betteryCalculator (){
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        batteryNotificationHandler =
            NotificationCenter.default.addObserver(forName: .UIDeviceBatteryLevelDidChange,
                                                   object: nil,
                                                   queue: nil, using: {
                                                    (Notification) in
                                                    self.getBatteryLevel()
            })
    }
    
    
    func getCurrentBestTime(context : CustomUIViewController) -> String {
        let  currentBestLocation=getObject(context: context,key: "currentBestLocation");
        if (currentBestLocation == CLLocation()) {
            return currentTime(context: context);
        }
        
        let date : Date =  currentBestLocation.timestamp
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let locationTime = Float(dateFormatter.string(from: date))!
        
        let deviceTime = Float(currentTime(context: context))!
        if (deviceTime > locationTime){
            return String(describing: locationTime)
        }
        return currentTime(context: context);
    }
    
    
    func internetConneted(context : CustomUIViewController, ShowAlert : Bool?  = true,SkipMadatory : Bool? = false) ->Bool{
    
        var result = false;
        var skipMandatory_local = SkipMadatory!
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            result = false
        }
        
        if !result {
            let isReachable = flags == .reachable || (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = flags == .connectionRequired || (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            result = isReachable && !needsConnection
        }
        
      
        
        if (!result && ShowAlert! ) {
           // if ((getDataFrom_FMCG_PREFRENCE(vc: context,key: "MOBILEDATAYN", defaultValue: "N") == "Y"  ) || ShowAlert! ) {
                Connect_to_Internet_Msg(context: context);
                skipMandatory_local = true
            //}
            
        }
        if ((getDataFrom_FMCG_PREFRENCE(vc: context,key: "MOBILEDATAYN", defaultValue: "N") != "Y"  ) && !skipMandatory_local) {
            return true
        }else{
           return result
        }
        //return result

    }
    
    func IsGPS_ON(context : CustomUIViewController) -> Bool {
        var mode = CLAuthorizationStatus.authorizedAlways
        var GPS_enabled = true;
        
        if (getDataFrom_FMCG_PREFRENCE(vc: context,key: "gps_needed",defaultValue: "Y") == "Y") {
            mode =  CLLocationManager.authorizationStatus()
            GPS_enabled = CLLocationManager.locationServicesEnabled()
        }
        
       
        
        if (!GPS_enabled || mode != CLAuthorizationStatus.authorizedAlways) {
            context.showLocationDisabledPopUp()
            return false;
        }
         if (getDataFrom_FMCG_PREFRENCE(vc: context,key: "gps_needed",defaultValue: "Y") == "Y") {
            context.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        return true;
    }
    
    func IsGPS_GRPS_ON(context : CustomUIViewController, ShowAlert : Bool?  = false) -> Bool{
       
        return IsGPS_ON(context: context) && internetConneted(context: context,ShowAlert: (getDataFrom_FMCG_PREFRENCE(vc: context,key: "MOBILEDATAYN", defaultValue: "N") == "Y" || ShowAlert!));
    }
    
    func Connect_to_Internet_Msg(context : CustomUIViewController){
        getAlert(vc: context,title: "Internet !!!",msg: "Not Connected to Internet....\nPlease Switch ON your Mobile Data/WiFi...");
    }
    
    func getTime() {
        let date = NSDate()
        
        // *** create calendar object ***
        var calendar = NSCalendar.current
        
        // *** Get components using current Local & Timezone ***
        print(calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date as Date))
        
        // *** define calendar components to use as well Timezone to UTC ***
        let unitFlags = Set<Calendar.Component>([.hour, .year, .minute])
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        // *** Get All components from date ***
        let components = calendar.dateComponents(unitFlags, from: date as Date)
        print("All Components : \(components)")
        
        // *** Get Individual components from date ***
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        let seconds = calendar.component(.second, from: date as Date)
        print("\(hour):\(minutes):\(seconds)")
    }
    
    
    func putObject(context : CustomUIViewController, key : String,location : CLLocation? = nil) {
        let who="_"+key;
        
        
        if (location == nil) {
            deleteFmcg_ByKey(vc: context, key: "LOCATION_LAT"+who)
             deleteFmcg_ByKey(vc: context, key: "LOCATION_LON"+who)
             //deleteFmcg_ByKey(vc: context, key: "LOCATION_PROVIDER"+who)
             deleteFmcg_ByKey(vc: context, key: "LOCATION_ACCURACY"+who)
             deleteFmcg_ByKey(vc: context, key: "LOCATION_TIME"+who)
             deleteFmcg_ByKey(vc: context, key: "LOCATION_SPEED"+who)
      
        } else {
            setDataInTo_FMCG_PREFRENCE(vc: context, key: "LOCATION_LAT"+who, value: String(describing: (location?.coordinate.latitude)!))
            setDataInTo_FMCG_PREFRENCE(vc: context, key: "LOCATION_LON"+who, value: String(describing: (location?.coordinate.longitude)!))
            //setDataInTo_FMCG_PREFRENCE(vc: context, key: "LOCATION_PROVIDER"+who, value: location)
            setDataInTo_FMCG_PREFRENCE(vc: context, key: "LOCATION_ACCURACY"+who,value: String(describing: (location?.horizontalAccuracy)!))
            setDataInTo_FMCG_PREFRENCE(vc: context, key: "LOCATION_TIME"+who, value: String(describing: (location?.timestamp.timeIntervalSince1970)!) )
            setDataInTo_FMCG_PREFRENCE(vc: context, key: "LOCATION_SPEED"+who, value: String(describing: (location?.speed)!))
            
        }

    
    }
    
    
    func getObject(context : CustomUIViewController?, key : String ) -> CLLocation {
        let  who="_\(key)";
       
        
        let lat = getDataFrom_FMCG_PREFRENCE(vc: context, key: "LOCATION_LAT"+who, defaultValue: "")
        let lon = getDataFrom_FMCG_PREFRENCE(vc: context, key: "LOCATION_LON"+who, defaultValue: "")
        var location : CLLocation = CLLocation()
        if (lat != "") {
            //var provider = myPrefrence.getString("LOCATION_PROVIDER"+who, null);
            let time = getDataFrom_FMCG_PREFRENCE(vc: context, key: "LOCATION_TIME"+who, defaultValue: "");
            let speed = getDataFrom_FMCG_PREFRENCE(vc: context, key: "LOCATION_SPEED"+who, defaultValue: "")
            let accuracy = getDataFrom_FMCG_PREFRENCE(vc: context, key: "LOCATION_ACCURACY"+who, defaultValue: "")
            
            let location1 = CLLocation(latitude: Double(lat)!, longitude: Double(lon)!)
            print(location1.coordinate)
            location = CLLocation(coordinate: location1.coordinate, altitude: 0, horizontalAccuracy: Double(accuracy)!, verticalAccuracy: 0, course: 0, speed: Double(speed)!, timestamp: Date(timeIntervalSince1970: Double(time)!))
        }
        return location;
  
    }

    
    func setDataInTo_FMCG_PREFRENCE(vc : UIViewController? ,key : String , value : String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func setDataInTo_FMCG_PREFRENCE(key : String , value : String){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getDataFrom_FMCG_PREFRENCE(vc : UIViewController? ,key : String , defaultValue : String ) -> String{
        return ( UserDefaults.standard.object(forKey: key) as? String ?? defaultValue)
    }
    
    func getDataFrom_FMCG_PREFRENCE(key : String , defaultValue : String ) -> String{
        return ( UserDefaults.standard.object(forKey: key) as? String ?? defaultValue)
    }
    
    func deleteFmcg_ByKey(vc : UIViewController ,key : String ){
        (UserDefaults.standard.removeObject(forKey: key))
    }

    
    
    func setDataForWebView(vcself : CustomUIViewController , mode :  Int , title : String , url : String){
        setDataForWebView(vcself: vcself,mode: mode,title: title,url: url,CloseParent: false)
    }
    func setDataForWebView(vcself : CustomUIViewController , mode :  Int , title : String , url : String,CloseParent : Bool){
        
        let StoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  StoryBoard.instantiateViewController(withIdentifier: "CBOwebViewViewController") as!  CBOwebViewViewController
        vc.VCIntent["title"] = title
        vc.VCIntent["url"] = url
        if CloseParent{
            vc.Parent_VC = vcself
        }
        vcself.present(vc , animated: true, completion: nil)
    }
    
    static func closeCurrentPage( vc : UIViewController)  {
       vc.dismiss(animated: true, completion: nil)
    }
    
    
    static func closeCurrentPage( vc : UIViewController, completion : @escaping ()  -> Void)  {
        vc.dismiss(animated: true, completion: completion)
    }
    

    /////////////splittingRouteData/////////////
    
    func splitRouteData(route : String) -> [String]{
        
        let myData1 = route.replacingOccurrences(of: "^", with: "_")
        var parsingdata = myData1.components(separatedBy: "_")
        let newResult1 = parsingdata[0];
        let newResult2 = parsingdata[1];
        let newResult3 = parsingdata[2];
        
        //        let index4 = newResult2.index(newResult2.startIndex, offsetBy: 4)
        //        let fno = newResult2[index4...]      //.substring(4);
        //
        //        let index7 = newResult3.index(newResult3.startIndex, offsetBy: 7)
        //        let vf = newResult2[index7...]      //.substring(7);
        //
        let fno = newResult2.substringFrom(offSetFrom: 4)
        let vf = newResult3.substringFrom(offSetFrom: 7)
        
        var data = [String]()
        data.append(newResult1);
        data.append(String(fno));
        data.append(String(vf));
        
        return data;
    }
    
    public func IsProductEntryReq(context : CustomUIViewController) -> Bool{
        return getDataFrom_FMCG_PREFRENCE(vc: context,key:"DCRPPNA",defaultValue: "N").uppercased() == ("N");
    }

    
    func srno(context : CustomUIViewController) -> String{
        let count = getDataFrom_FMCG_PREFRENCE(vc: context,key: "srno",defaultValue: "0");
        
        let a = Int(count)! + 1;
        setDataInTo_FMCG_PREFRENCE(vc: context,key: "srno",value: "\(a)");
        return "\(a)"
    }
    
    
    func get_best_latlong(context : CustomUIViewController) -> String {
    
        return getDataFrom_FMCG_PREFRENCE(vc: context,key: "shareLatLong",defaultValue: Custom_Variables_And_Method.GLOBAL_LATLON);
    }
    
    
    func getDeviceInfo() -> String{
        var id = KeychainWrapper.standard.string(forKey: "imei_CurrentDeviceId")
        if(id == nil){
            if let uuid = UIDevice.current.identifierForVendor?.uuidString {
                KeychainWrapper.standard.set(uuid, forKey: "imei_CurrentDeviceId")
                id = uuid
            }
        }
        return id!
    }
    
    public func getTaniviaTrakerMenuName(context : CustomUIViewController) -> String{
        do{
             let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
            if(getDataFrom_FMCG_PREFRENCE(vc: context,key: "Tenivia_NOT_REQUIRED",defaultValue: "Y") == ("N")) {
                return try cbohelp.getMenuNew(menu: "DCR", code: "D_DR_RX").getString(key:"D_DR_RX");
            }
            
            if(getDataFrom_FMCG_PREFRENCE(vc: context,key: "Rx_NOT_REQUIRED",defaultValue: "Y") == ("N")) {
                return try cbohelp.getMenuNew(menu: "DCR", code: "D_RX_GEN").getString(key:"D_RX_GEN");
            }
            
            if(getDataFrom_FMCG_PREFRENCE(vc: context,key: "Rx_NA_NOT_REQUIRED",defaultValue: "Y") == ("N")) {
                return try cbohelp.getMenuNew(menu: "DCR", code: "D_RX_GEN_NA").getString(key: "D_RX_GEN_NA");
            }
        }catch{
            return "";
        }
        
        return "";
    }
    
    public func getTaniviaTrakerMenuCode(context : CustomUIViewController) -> String{
        
        
        let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
        if(getDataFrom_FMCG_PREFRENCE(vc: context,key: "Tenivia_NOT_REQUIRED",defaultValue: "Y") == ("N")) {
            return "D_DR_RX";
        }
        
        if(getDataFrom_FMCG_PREFRENCE(vc: context,key: "Rx_NOT_REQUIRED",defaultValue: "Y") == ("N")) {
             return "D_RX_GEN";
        }
        
        if(getDataFrom_FMCG_PREFRENCE(vc: context,key: "Rx_NA_NOT_REQUIRED",defaultValue: "Y") == ("N")) {
            return "D_RX_GEN_NA";
        }
   
        return "";
    }
    
    
    public func isVisualAddDownloadRequired(context : CustomUIViewController) -> Bool {
    
        let Version = getDataFrom_FMCG_PREFRENCE(vc: context, key: "VISUALAID_VERSION", defaultValue: "")
        
        let previousVersion = getDataFrom_FMCG_PREFRENCE(vc: context, key: "VISUALAID_VERSION_DOWNLOAD", defaultValue: "")

        return getDataFrom_FMCG_PREFRENCE(vc: context, key: "DCRSAMPLE_AFTERVISUALAIDYN", defaultValue: "N").uppercased() == "Y" && (previousVersion.isEmpty || previousVersion.uppercased() != Version);

    }
    
    public func isCheckForProduct(s : String, context : CustomUIViewController) -> Bool {
        
        if getDataFrom_FMCG_PREFRENCE(vc: context, key: "DRCALLPRODUCT_MANDATORYYN", defaultValue: "N").contains(s) || getDataFrom_FMCG_PREFRENCE(vc: context, key: "DRCALLPRODUCT_MANDATORYYN", defaultValue: "N").contains("Y") {
            return true
        } else {
            return false
        }
        
    }
    
    public func isGeoFencingRequired(s : String, context : CustomUIViewController) -> Bool {
        
        if getDataFrom_FMCG_PREFRENCE(vc: context, key: "GEO_FANCING_KM_FOR", defaultValue: "N").contains(s) || getDataFrom_FMCG_PREFRENCE(vc: context, key: "GEO_FANCING_KM_FOR", defaultValue: "N").contains("Y") {
            return true
        } else {
            return false
        }
        
    }
    
    
   
}

