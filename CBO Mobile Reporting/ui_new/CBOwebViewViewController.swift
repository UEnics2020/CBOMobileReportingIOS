//
//  CBOwebViewViewController.swift
//  CBOMobileReporting
//
//  Created by rahul sharma on 12/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit
import WebKit
class CBOwebViewViewController: CustomUIViewController ,  UIWebViewDelegate  , WKUIDelegate , WKNavigationDelegate {

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var myTopView: TopViewOfApplication!
    
    
    @IBOutlet weak var myWebView: UIWebView!
    //@IBOutlet weak var play: UIButton!
    //@IBOutlet weak var webpage: UIButton!
    
    @IBOutlet weak var webViewContainer: UIView!
    
    
    var fileExtention = ""

    var indexId = 0
    var path = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        myWebView.delegate = self
       
        
            myTopView.backButton.addTarget(self, action: #selector(close), for: .touchUpInside)
            
            if path.isEmpty{
                var urlString = VCIntent["url"]!
                if ( urlString.contains("?")) {
                    urlString = urlString + "&LAT_LONG=" + Custom_Variables_And_Method.GLOBAL_LATLON ;
                }else{
                    urlString = urlString + "?LAT_LONG=" + Custom_Variables_And_Method.GLOBAL_LATLON ;
                }

                myTopView.setText(title: VCIntent["title"]!)
                let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
//                if (urlString.contains("/Documents/Cbo/Product/")){
//                    url = URL(fileURLWithPath:urlString)
//                }
               
                
               
                
                let request = URLRequest(url: url!)
                myWebView.loadRequest(request)
                myWebView.reload()
            }else {
                
                myTopView.setText(title: VCIntent["title"]!)
                    
                    guard let filePath = Optional( path )
                        else {
                            // File Error
                            print ("File reading error")
                            return
                    }
                    //let fileManager = FileManager.default
                    
                 //   print(filePath)
                
                    if FileManager.default.fileExists(atPath: filePath){
                        
                        let url = URL(fileURLWithPath: path )
                        let request = URLRequest(url: url)
                            
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
    
    
    @objc func close(){
        webViewContainer.removeFromSuperview()
        myTopView.CloseCurruntVC(vc: self)
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
        UIApplication.shared.beginIgnoringInteractionEvents()
       
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        startActivity()
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
         activityIndicator.stopAnimating()
        activityIndicator.isHidden=true;
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden=true;
        UIApplication.shared.endIgnoringInteractionEvents()
       //startActivity()
    }

    
  
    
}
