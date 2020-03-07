 

//  APIClass.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 04/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import Alamofire
//import SWXMLHash
//import StringExtensionHTML
//import AEXML


class CboServices {
    var url = "http://cboservices.com/mobilerpt.asmx"
    var customVariablesAndMethod : Custom_Variables_And_Method!
   let showAlert = ShowAlert()
    private var  objBroadcastErrorMail : BroadcastErrorMail!
    
    init() {
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
    }

    
    func setParameters(params : [String : String]) -> NSMutableData {
        
        var param : String = ""
        for i in params
        {
            
            let val = (i.value == nil ? "" : i.value)
            param = "\(param)\(i.key)=\(val.replacingOccurrences(of: "&", with: ""))&"
            print(i.key)
            print(i.value)
        }
        
//        print(params)
        param = String(param.dropLast())
    
        let ALLOWED_URI_CHARS = "@#&=*-_.,:!?()/~?'%";
        param = param.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: ALLOWED_URI_CHARS))!
        print(param)
        //String params = Uri.encode(urlParameters.toString(), ALLOWED_URI_CHARS);
        return NSMutableData(data: param.data(using: String.Encoding.utf8)!)
        //return param
    }
    
  
    
    //MARK:- fetching data from api
    func customMethodForAllServices( params : [String : String] , methodName :  String , tables : [Int] ,response_code: Int, vc : CustomUIViewController ,multiTableResponse : Bool )  {
        
        if (!customVariablesAndMethod.internetConneted(context: vc , ShowAlert: false , SkipMadatory: true)){
            var ReplyMsg = [String:NSArray]()
            ReplyMsg["Error"] = ["Not Connected to Internet....\nPlease Switch ON your Mobile Data/WiFi..."]
            vc.getDataFromApi(response_code: 99, dataFromAPI: ReplyMsg)
            return
        }
        
        if(!customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: vc, key: "WEBSERVICE_URL", defaultValue: self.url).isEmpty){
            self.url = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: vc, key: "WEBSERVICE_URL", defaultValue: self.url)
        }
        
        print(params)
        let params1 = setParameters(params: params)
        

        let url = URL(string:"\(self.url)/\(methodName)")
        //for var i in 0..<3 {
            var xmlRequest = URLRequest(url: url!)
             var stringResponse: String = "[ERROR]"
            
            xmlRequest.httpBody = params1 as Data
            
            xmlRequest.httpMethod = "POST"
            xmlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            Alamofire.request(xmlRequest)
              .responseData { (response) in
               // let statusCode = response.response?.statusCode
                switch (response.result) {
                case .success:
                    stringResponse = String(data: response.data!, encoding: String.Encoding.utf8) as String!
                    stringResponse = stringResponse.replacingOccurrences(of: "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<string xmlns=\"http://tempuri.org/\">", with: "").replacingOccurrences(of: "</string>", with: "").replacingOccurrences(of: "&gt;", with: ">").replacingOccurrences(of: "&amp;", with: "&")
                    //i = 3
                    
                    print(stringResponse)
                    
                    //MARK:- check if the stringReponse contains \n 
                    if stringResponse.contains("\n"){
                        stringResponse = stringResponse.replacingOccurrences(of: "\n", with: "\\n")
                    }
                    break
                case .failure(let error):
                    
                    if error._code == NSURLErrorTimedOut {
                        //HANDLE TIMEOUT HERE
                        stringResponse = "Socket : [ERROR] service  method  \(String(describing: response.error))"
//                       let WEBSERVICE_URL_ALTERNATE = self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: vc, key: "WEBSERVICE_URL_ALTERNATE", defaultValue: self.url)
//                        if (WEBSERVICE_URL_ALTERNATE != "") {
//                            self.url = WEBSERVICE_URL_ALTERNATE
//                        }
                        //self.threadMethod(result: " Socket timeout : [ERROR] \(String(describing: response.error))" , tables: tables, methodName:methodName ,response_code: response_code, vc : vc , multiTableResponse:  multiTableResponse)
                    } else {
                        //i = 3
                         stringResponse = " [ERROR] service  method  \(String(describing: response.error))"
                       // self.threadMethod(result: " Server Error : [ERROR] \(String(describing: response.error))" , tables: tables, methodName:methodName ,response_code: response_code, vc : vc , multiTableResponse:  multiTableResponse)
                    }
                    print("\n\nAuth request failed with error:\n \(error)")
                    break
                }
//                2DispatchQueue.main.async{
                    //if (i >= 3){
                        self.threadMethod(result: stringResponse , tables: tables, methodName:methodName ,response_code: response_code, vc : vc, multiTableResponse: multiTableResponse)
                    //}
//                }

            }
       // }
    }
    func customMethodForAllServices( params : [String : String] , methodName :  String , tables : [Int] ,response_code: Int, vc : CustomUIViewController  )  {
        
        customMethodForAllServices(params: params, methodName: methodName, tables: tables, response_code: response_code, vc: vc, multiTableResponse: true)
        
    }
    // MARK:- function to convert string to dictionary
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    
    func threadMethod(result : String , tables: [Int] , methodName : String ,response_code: Int, vc: CustomUIViewController , multiTableResponse : Bool ){
        
        print(result)
        var dataTables = tables
        var ReplyMsg = [String:NSArray]()
        do{
            
        if dataTables.count==0{
            
        } else if( !result.isEmpty && !result.uppercased().contains("[ERROR]")){
            
            if (self.convertStringToDictionary(text: result)) != nil {
                
                let jsonResponse : [String : AnyObject] = (self.convertStringToDictionary(text: result))!
                var data : NSArray!
                if multiTableResponse {
                    
                    data = try jsonResponse.getValue(key: "Tables") as? NSArray
                    
                    if dataTables[0] == -2 {
                        dataTables.remove(at: 0)
                        dataTables.insert(-1, at: 0)
                    }
                    
                    if dataTables[0] == -1 {
                        dataTables.remove(at: 0)
                        for i in 0 ..< data!.count{
                            dataTables.insert(i, at: i)
                        }
                    }
                    
                    //  old logic
                    for i in  dataTables {
                        //print (dataTables)
                        let dic = (data![i] as! [String : AnyObject])
                        // print(dic)
                        let val = try dic.getValue(key: "Tables"+"\(i)") as? NSArray
                        //let dataitem2 = val![0] as! [String: AnyObject]
                        ReplyMsg["Tables"+"\(i)"] = val
                    }
                    
                } else {
                    data = jsonResponse["Tables0"] as? NSArray
                    ReplyMsg["Tables0"]  = data
                }
                
            }
            
            
            
            // old logic
           //-1 get all tables in reply and also give error back
            //-2 get all tables in reply and don't give error back
          
            if (response_code != -1){
                vc.getDataFromApi(response_code: response_code, dataFromAPI: ReplyMsg)
            }
            
        }else{
            var title = ""
            if(dataTables[0] != -2){
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
                
                let dataDict = ["Web Services : " : url ,  "Method Name":  methodName , "Error Alert : ":"\(title) \n \(result)"]
                
                objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(subject)", vc: vc)

                objBroadcastErrorMail.requestAuthorization()
            }
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
                     
            
            let dataDict = [ "Method Name":  methodName , "Error Alert : ":"Missing table error \n \(error.localizedDescription )"]
            
            objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(subject)", vc: vc)
            
            objBroadcastErrorMail.requestAuthorization()
           
        }
    }
    
    
    func dictToString(dict : [String : AnyObject]){
        let dictionary = dict
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
    }
}
