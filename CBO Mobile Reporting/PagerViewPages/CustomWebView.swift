//
//  CustomWebView.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 08/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
import WebKit
class CustomWebView: CustomUIViewController ,  UIWebViewDelegate  , WKUIDelegate , WKNavigationDelegate{

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var fileExtention = ""

    var indexId = 0
    var path = ""
    
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var salesbtn: CustomeUIButton!
    @IBOutlet weak var marketbtn: CustomeUIButton!
    @IBOutlet weak var btnview: NSLayoutConstraint!
    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnview.constant = 0 //50
        salesbtn.backgroundColor = AppColorClass.tab_sellected
        marketbtn.backgroundColor = AppColorClass.colorPrimaryDark
        salesbtn.addTarget(self, action: #selector(btnclicksales), for: .touchUpInside )
        marketbtn.addTarget(self, action: #selector(btnclicksmarket), for: .touchUpInside )
        
        myWebView.delegate = self
        if path.isEmpty{
                        var urlString = VCIntent["url"]!
                        if ( !urlString.contains("http")) {
//                            if ( !urlString.lowercased().contains("www.")) {
//                                urlString = "www." + urlString;
//                            }
                            urlString = "http://" + urlString;
                        }
                        if ( urlString.contains("?")) {
                            urlString = urlString + "&LAT_LONG=" + Custom_Variables_And_Method.GLOBAL_LATLON ;
                        }else{
                            urlString = urlString + "?LAT_LONG=" + Custom_Variables_And_Method.GLOBAL_LATLON ;
                        }

                       
                         let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        //                if (urlString.contains("/Documents/Cbo/Product/")){
        //                    url = URL(fileURLWithPath:urlString)
        //                }
                       
                        
                       
                        
                        var request = URLRequest(url: url!)
                        request.cachePolicy = .returnCacheDataElseLoad
                        myWebView.loadRequest(request)
                        myWebView.reload()
                    }else {
                        
                            
                            guard let filePath = Optional( path )
                                else {
                                    // File Error
                                    print ("File reading error")
                                    return
                            }
                            let fileManager = FileManager.default
                            
                         //   print(filePath)
                            if fileManager.fileExists(atPath: filePath){
                            let url = URL(fileURLWithPath: filePath )
                            var request = URLRequest(url: url)
                            request.cachePolicy = .returnCacheDataElseLoad
                                
                            if #available(iOS 11.0, *) {
                               
                                if fileExtention == ".html"{
                                    myWebView.allowsInlineMediaPlayback = true
                                    myWebView.mediaPlaybackRequiresUserAction = true
                                    myWebView.loadRequest(request)
                                }else {
                                    myWebView.isHidden = true
                                    var webView: WKWebView!
                                   
                                    let webConfiguration = WKWebViewConfiguration()
                                    let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewContainer.frame.size.height))
                                    
                                    webView = WKWebView (frame: customFrame , configuration: webConfiguration)
                                    
                                    webView.uiDelegate = self
                                    webView.translatesAutoresizingMaskIntoConstraints = false
                                    self.webViewContainer.addSubview(webView)
                                    webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
                                    webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
                                    webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
                                    webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
                                    webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
                                
                                    webView.loadFileURL(url, allowingReadAccessTo: url)
                                }
                            }else{
                                myWebView.allowsInlineMediaPlayback = true
                                myWebView.mediaPlaybackRequiresUserAction = true
                                myWebView.loadRequest(request)
                            }
                        }
        }
    }
    
    @objc func btnclicksales(){
            
        salesbtn.backgroundColor = AppColorClass.tab_sellected
        marketbtn.backgroundColor = AppColorClass.colorPrimaryDark
              
    }
       
    @objc func btnclicksmarket(){
            
        salesbtn.backgroundColor = AppColorClass.colorPrimaryDark
        marketbtn.backgroundColor = AppColorClass.tab_sellected
              
    }
       

    
    func startActivity(){
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        activityIndicator.transform = transform
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
       
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        startActivity()
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
       startActivity()
    }


}
