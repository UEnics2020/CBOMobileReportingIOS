//
//  ViewController2.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 06/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.
//

import UIKit

import SHViewPager
class ViewController2: UIViewController {
    
    let cbohelp : CBO_DB_Helper  = CBO_DB_Helper.shared

    @IBOutlet weak var myMarqueeLabel: MarqueeLabel!
    @IBOutlet fileprivate var pager: SHViewPager!
    fileprivate var menuItems = [String]()
    fileprivate var tabs = [[String : String]]()
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var lblCompanyName: UINavigationItem!
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    var dashboardUrl = "";
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabs = cbohelp.getTab()
        
        dashboardUrl = cbohelp.getMenuUrl(menu: "REPORTS", menu_code: "R_DASH")
        if (!dashboardUrl.isEmpty){
             tabs.insert(["menu" : "DASHBOARD"], at: 1)
        }
        
       
        
        myView.backgroundColor = AppColorClass.colorPrimary
        
         lblCompanyName.title =  cbohelp.getCOMP_NAME()
        pager.reloadData()
           customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        marqueeRun()
        createTopBackButton()
        
        
    }
    
    func createTopBackButton() {
        
        let button = UIButton.init(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "back_hadder_2016.png"), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(ViewController2.pressedBackButton), for: UIControlEvents.touchUpInside)
        //set frame
        button.frame = CGRect(x: -15, y: 0, width: 30, height: 30)
       
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        
       // barButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = barButton

    }
    
    @objc func pressedBackButton(){
        Custom_Variables_And_Method.closeCurrentPage(vc: self)
    }
    
    fileprivate func marqueeRun()   {
        myMarqueeLabel.tag = 301
        myMarqueeLabel.type = .continuous
        myMarqueeLabel.speed = .rate(70.0)
        myMarqueeLabel.fadeLength = 10.0
        myMarqueeLabel.leadingBuffer = 30.0
        myMarqueeLabel.trailingBuffer = 20.0
        myMarqueeLabel.textAlignment = .center
        myMarqueeLabel.textColor = UIColor.white
        let myMarqueeMsg = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "mark", defaultValue: "")
        myMarqueeLabel.text =  myMarqueeMsg
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // fixes bug for scrollview's content offset reset.
        // check SHViewPager's reloadData method to get the idea.
        // this is a hacky solution, any better solution is welcome.
        // check closed issues #1 & #2 for more details.
        // this is the example to fix the bug, to test this
        // comment out the following lines
        // and check what happens.
        pager.pagerWillLayoutSubviews()
    }
}

// MARK: - SHViewPagerDataSource

extension ViewController2: SHViewPagerDataSource {
    
    func numberOfPages(in viewPager: SHViewPager) -> Int {
     
        return tabs.count
    }
    
    func containerController(for viewPager: SHViewPager) -> UIViewController {
        
        return self
    }
    
    func viewPager(_ viewPager: SHViewPager, controllerForPageAt index: Int) -> UIViewController {
        var contentVC = CustomUIViewController()
        let code = tabs[index]["menu"]!
        switch code {
            
        
           
        case "DASHBOARD":
            contentVC = CustomWebView(nibName: "CustomWebView", bundle: nil)
            contentVC.VCIntent["url"] = dashboardUrl
        case "MAIL":
              contentVC = MailScreen(nibName: "MailScreen", bundle: nil)
          
        case "DCR":
            contentVC = DcrmenuInGrid(nibName: "DcrmenuInGrid", bundle: nil)
            
//        case "TRANSACTION":
//            contentVC = TransactionMenuInGrid(nibName: "TransactionMenuInGrid", bundle: nil)
        case "REPORTS":
            contentVC = ReportMenuInGrid(nibName: "ReportMenuInGrid", bundle: nil)
            
        case "PERSONAL_INFO":
            contentVC = PresonalMenuInGrid(nibName: "PresonalMenuInGrid", bundle: nil)
            
        case "UTILITY":
            contentVC = UtilitiesMenuInGrid(nibName: "UtilitiesMenuInGrid", bundle: nil)
            
        case "APPROVAL":
            contentVC = ApprovalMenuInGrid(nibName: "ApprovalMenuInGrid", bundle: nil)
            
        default:
            contentVC = TransactionMenuInGrid(nibName: "TransactionMenuInGrid", bundle: nil)
        }
        //contentVC.menuIndex = index + 1
        //contentVC.selectionIndicatorString = "Currently Selected :index \(index + 1)"
        
        contentVC.VCIntent["Code"] = code

        return contentVC
    }
    
    func viewPager(_ viewPager: SHViewPager, titleForPageMenuAt index: Int) -> String {
        //let tab = tabs[index]
    
        return tabs[index]["menu"]!
    }
}

// MARK: - SHViewPagerDelegate

extension ViewController2: SHViewPagerDelegate {
    
    func indexIndicatorImage(for viewPager: SHViewPager) -> UIImage {
        return UIImage(named: "IndexIndicatorIcon")!
    }
    
    func fontForMenu(in viewPager: SHViewPager) -> UIFont {
     var font = UIFont(name: "System", size: 12 )
            font = UIFont.boldSystemFont(ofSize: 12)
        
     return font!
    }
    
    func indexIndicatorImageDuringScrollAnimation(for viewPager: SHViewPager) -> UIImage {
        return UIImage(named: "IndexIndicatorMovingIcon")!
    }
    
    func menuWidthType(in viewPager: SHViewPager) -> SHViewPagerMenuWidthType {
        return .wide
    }
    
    func firstContentPageLoaded(for viewPager: SHViewPager) {
        print("first viewcontroller content loaded")
    }
    
    func viewPager(_ viewPager: SHViewPager, willMoveToPageAt toIndex: Int, from fromIndex: Int) {
        
        
        print("content will move to page \(toIndex) from page: \(fromIndex)");
    }
    
    func viewPager(_ viewPager: SHViewPager, didMoveToPageAt toIndex: Int, from fromIndex: Int) {
        print("content moved to page \(toIndex) from page: \(fromIndex)");
    }

}
