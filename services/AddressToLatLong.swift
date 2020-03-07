//
//  AddressToLatLong.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 10/03/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
import Alamofire

class AddressToLatLong: NSObject {

    private var context : CustomUIViewController!
    private var address : String!
    private var  customVariablesAndMethod : Custom_Variables_And_Method!
    private var  url : URL!
    private var  objBroadcastErrorMail : BroadcastErrorMail!
    
    init( context : CustomUIViewController,address : String) {
        self.context = context;
        self.address = address;
         customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
    }
    
    
    //MARK:- fetching data from api
    func getLatLong(response_code: Int)  {
        if (!customVariablesAndMethod.internetConneted(context: context , ShowAlert: false , SkipMadatory: true)){
            var ReplyMsg = [String:NSArray]()
            ReplyMsg["Error"] = ["Not Connected to Internet....\nPlease Switch ON your Mobile Data/WiFi..."]
            context.getDataFromApi(response_code: 99, dataFromAPI: ReplyMsg)
            return
        }
        
        
        url = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?address=\(address.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)&key=AIzaSyB4UzWR8_mncvSPW_CyA485WryqI6Z4D20")
        var xmlRequest = URLRequest(url: url!)
        var stringResponse: String = "[ERROR]"
        
        xmlRequest.httpMethod = "GET"
        xmlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        Alamofire.request(xmlRequest)
            .responseData { (response) in
                // let statusCode = response.response?.statusCode
                switch (response.result) {
                case .success:
                    stringResponse = String(data: response.data!, encoding: String.Encoding.utf8) as String!
//                    stringResponse = stringResponse.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">", with: "").replacingOccurrences(of: "</string>", with: "").replacingOccurrences(of: "&gt;", with: ">").replacingOccurrences(of: "&amp;", with: "&")
                    
                    print(stringResponse)
                    
                    //MARK:- check if the stringReponse contains \n
//                    if stringResponse.contains("\n"){
//                        stringResponse = stringResponse.replacingOccurrences(of: "\n", with: "\\n")
//                    }
                    
                    
                
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        //HANDLE TIMEOUT HERE
                        stringResponse = "Socket : [ERROR] service  method  \(String(describing: response.error))"
                      
                    }else{
                        //i = 3
                        stringResponse = " [ERROR] service  method  \(String(describing: response.error))"
                      
                    }
                    print("\n\nAuth request failed with error:\n \(error)")
                    break
                }
                self.threadMethod(result: stringResponse ,response_code: response_code, vc : self.context)
        }
    }
    
    // MARK:- function to convert string to dictionary
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    func threadMethod(result : String ,response_code: Int, vc: CustomUIViewController ){
        var ReplyMsg = [String:NSArray]()
        do{
             if( !result.isEmpty && !result.uppercased().contains("[ERROR]")){
                
                
                let jsonResponse : [String : AnyObject] = (self.convertStringToDictionary(text: result))!
                var data : NSArray!
            
                data = jsonResponse["results"] as? NSArray
                let innerJson = data[0] as! [String : AnyObject]
                let location = innerJson["geometry"]!["location"] as! [String : AnyObject]
                //var latLong = [try location.getString(key: "lat") + location.getString(key : "lng")];
                
                
                ReplyMsg["latLong"]  =  [try location.getString(key: "lat") + "," + location.getString(key : "lng")]
                ReplyMsg["address"]  = [address]
                vc.getDataFromApi(response_code: response_code, dataFromAPI: ReplyMsg)
                
            }else{
                var title = ""
                    if (result.contains("service  method")) {
                        if(result.contains("Socket")){
                            title = "Internet Error"
                            ReplyMsg["Error"] = ["Connection timeout. Please try after some time or Switch ON/OFF your Internet "]
                        }else{
                            title="Server Error";
                            ReplyMsg["Error"] = ["Please Check your Internet Connection..."]
                            //[result]
                        }
                        
                    } else {
                        title="Server Error";
                        ReplyMsg["Error"] = ["Please try after sometime...."]
                    }
                    
                    
                    
                    vc.getDataFromApi(response_code: 99, dataFromAPI: ReplyMsg)
                    
                    
                    var subject = ""
                    if (result.count > 22 && result.count >= 80) {
                        subject = result.subString(offsetFrom: 22, offSetTo: 80)
                    } else if (result.count > 22) {
                        subject = result.substringFrom(offSetFrom: 22);
                    } else {
                        subject = result;
                    }
                    
                let dataDict = ["Web Services : " : url.absoluteString ,  "Method Name":  "AddressToLatlong" , "Error Alert : ":"\(title) \n \(result)"]
                    
                    objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(subject)", vc: vc)
                    
                    objBroadcastErrorMail.requestAuthorization()
                
            }
        }catch {
            print("MYAPP", "objects are: \(error)")
            ReplyMsg["Error"] = [error.localizedDescription]
            vc.getDataFromApi(response_code: -1, dataFromAPI: ReplyMsg)
            customVariablesAndMethod.getAlert(vc: vc, title: "Missing Table error", msg: error.localizedDescription )
            
            var subject = ""
            if (error.localizedDescription.count > 22   && error.localizedDescription.count >= 80){
                subject = error.localizedDescription.subString(offsetFrom: 22, offSetTo: 80)
            }else if (error.localizedDescription.count > 22){
                subject = error.localizedDescription.substringFrom(offSetFrom: 22)
            }else{
                subject = error.localizedDescription
            }
            
            
            let dataDict = [ "Method Name":  "AddressToLatlong" , "Error Alert : ":"Missing table error \n \(error.localizedDescription )"]
            
            objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(subject)", vc: vc)
            
            objBroadcastErrorMail.requestAuthorization()
            
        }
    }
}
