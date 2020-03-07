//
//  VisualAidDownload.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 24/02/18.
//  Copyright © 2018 rahul sharma. All rights reserved.
//

import UIKit
import Alamofire
import Zip
import Foundation
import SystemConfiguration
import MZDownloadManager
//import GoldRaccoon

let alertControllerViewTag: Int = 500

class VisualAidDownload: CustomUIViewController , Up_Down_Output, URLSessionDelegate, URLSessionDownloadDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return zipName.count
         
        return downloadManager.downloadingArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
//        let cell = Bundle.main.loadNibNamed("ReminderRow", owner: self, options: nil)?.first as! ReminderRow
//        cell.selectionStyle = .none
//        cell.Name.text = "\(indexPath.row + 1)). \(zipName[indexPath.row])"
//        cell.Name.textColor = UIColor.black
//        cell.Qty.isHidden = true
//        cell.leftline.isHidden = true
//        cell.rightline.isHidden = true
//        return cell
        
        let cellIdentifier : NSString = "MZDownloadingCell"
        let cell : MZDownloadingCell = self.downloadTable.dequeueReusableCell(withIdentifier: cellIdentifier as String, for: indexPath) as! MZDownloadingCell
        
        if zipName.count > 0 {
            
            let baseUrl = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "API_URL_MOBILE", defaultValue: "")
            
            let title = zipName[indexPath.row].replacingOccurrences(of: "\(baseUrl)download/VISUALAID/", with: "").replacingOccurrences(of: "/zip", with: "")
                   
            cell.lblTitle?.text = "\(title)"
            let downloadModel = downloadManager.downloadingArray[indexPath.row]
            cell.updateCellForRowAtIndexPath(indexPath, downloadModel: downloadModel)
            
            
            
        } else {
            for i in 0..<downloadManager.downloadingArray.count {
                self.downloadManager.cancelTaskAtIndex(i)
            }
        }
        
        
          
        return cell
        
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndexPath = indexPath
//
//        let downloadModel = downloadManager.downloadingArray[indexPath.row]
//        self.showAppropriateActionController(downloadModel.status)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        //VisualAidDownload.alert = nil
        DispatchQueue.main.async {
            self.progressBar.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        }
    }
    
    func downloadImage() {
        // A 10MB image from NASA
        let url = URL(string: "https://photojournal.jpl.nasa.gov/jpeg/PIA08506.jpg")!

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)

        // Don't specify a completion handler here or the delegate won't be called
        session.downloadTask(with: url).resume()
    }
    
    lazy var downloadManager: MZDownloadManager = {
        [unowned self] in
        
        let sessionIdentifer: String = "com.app.CBO-Mobile-Reporting.BackgroundSession"
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var completion = appDelegate.backgroundSessionCompletionHandler
        
        let downloadmanager = MZDownloadManager(session: sessionIdentifer, delegate: self, completion: completion)
        return downloadmanager
    
    }()
    
    
    let myDownloadPath = MZUtility.baseFilePath + "/Cbo/Product"
    var selectedIndexPath : IndexPath!

    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var contentView: UIView!
    
    let cbohelp: CBO_DB_Helper = CBO_DB_Helper.shared
    var pa_name = "" , PA_ID = ""
    
    static var alert : UIAlertController!
    
    var localpath : String = ""
    var arrayString =  [String]()
    var myImages = [UIImage]()
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    let UPDATE_VISUALAID_DOWNLAOD = 0
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var tname: UILabel!
    @IBOutlet weak var extractText: UILabel!
    @IBOutlet weak var comp_name: UILabel!
    @IBOutlet weak var downloadPercent: UILabel!
    @IBOutlet weak var fileName: UILabel!
  //  var requestsManager : GRRequestsManager!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var downloadTable: UITableView!
    var upDownFTP : Up_Down_Ftp!
    @IBOutlet weak var downloadButton: CustomeUIButton!
    var zipName = [String]()
    var selectedzipName = [String]()
    var downloadVersion = [String]()
    var BrandId = [String]()
    
    var afterdownloadVersion = [String]()
    var afterBrandId = [String]()
    
    var base_local_root = ""
    var count = 0, totalfile = 0
    
    var checkrequests: Alamofire.Request?
    
    override func viewDidLoad() {
        
        progressBar.progress = 0.0
        super.viewDidLoad()
        myTopView.setText(title: VCIntent["title"]!)
        progressBar.layer.cornerRadius = 6
        progressBar.clipsToBounds = true
        contentView.isHidden = true
        downloadButton.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        downloadButton.isHidden = true
        // when user login first time
//        if VCIntent["V_DOWNLOAD"] == "Y" {
//            myTopView.backButton.isHidden = true
//            myTopView.backButtonConstraint.constant = 0
//            downloadButtonPressed()
//        }
       
        myTopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        PA_ID = "\(Custom_Variables_And_Method.PA_ID)"
        pa_name = Custom_Variables_And_Method.PA_NAME
        customVariablesAndMethod=Custom_Variables_And_Method.getInstance()
        
        if(pa_name != (Custom_Variables_And_Method.PA_NAME)) {
             tname.text = ("       user Logged-Out");
            
            comp_name.text = ("");
            customVariablesAndMethod.msgBox(vc: self, msg: "Connection Reset...\nplease login again from login screen")
            
        } else {
            tname.text = "Welcome \( pa_name)";
            comp_name.text = (Custom_Variables_And_Method.COMPANY_NAME);
        }
        
        downloadTable.delegate = self//presenter
        downloadTable.dataSource = self
        
        if !FileManager.default.fileExists(atPath: myDownloadPath) {
            try! FileManager.default.createDirectory(atPath: myDownloadPath, withIntermediateDirectories: true, attributes: nil)
        }
                    
        debugPrint("custom download path: \(myDownloadPath)")
        
        for i in 0..<downloadManager.downloadingArray.count {
                   self.downloadManager.cancelTaskAtIndex(i)
        }
        
        
    }
     
    override func viewWillAppear(_ animated: Bool) {
        
        // clearDiskCache()
        for i in 0..<downloadManager.downloadingArray.count {
            self.downloadManager.cancelTaskAtIndex(i)
        }
        
        for i in 0 ..< zipName.count{
                                  
            let fileURL  : NSString = zipName[i] as NSString
            var fileName : NSString = fileURL.lastPathComponent as NSString
            fileName = MZUtility.getUniqueFileNameWithPath((myDownloadPath as NSString).appendingPathComponent(fileName as String) as NSString)
                                  
                              
            VisualAidDownload.alert = nil
            downloadManager.addDownloadTask(fileName as String, fileURL: fileURL as String, destinationPath: myDownloadPath, companyCode : cbohelp.getCompanyCode())
                                   
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   @objc func closeVC() {
    
//        for i in 0..<downloadManager.downloadingArray.count {
//            self.downloadManager.cancelTaskAtIndex(i)
//        }
    
        if downloadManager.downloadingArray.count > 0 || selectedzipName.count > 0 {
            let alert = UIAlertController(title: "Alert", message: "You can not cancel before download...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            
        
            myTopView.CloseCurruntVC(vc: self)
        }
    
        
    }
    
    
    @objc func downloadButtonPressed(){
  
        downloadButton.isHidden = true
        
        for i in 0 ..< zipName.count{
                                  
            let fileURL  : NSString = zipName[i] as NSString
            var fileName : NSString = fileURL.lastPathComponent as NSString
            fileName = MZUtility.getUniqueFileNameWithPath((myDownloadPath as NSString).appendingPathComponent(fileName as String) as NSString)
                                  
                               
            VisualAidDownload.alert = nil
            downloadManager.addDownloadTask(fileName as String, fileURL: fileURL as String, destinationPath: myDownloadPath, companyCode : cbohelp.getCompanyCode())
                            
        }
        
        
    }
    
    
    
    func createFolder(folderName:String)->URL
    {
        var paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory: String = paths[0] as? String ?? ""
        let dataPath: String = URL(fileURLWithPath: documentsDirectory).appendingPathComponent(folderName).absoluteString
        if !FileManager.default.fileExists(atPath: dataPath) {
            try? FileManager.default.createDirectory(atPath: dataPath, withIntermediateDirectories: false, attributes: nil)
        }
        let fileURL = URL(string: dataPath)
        return fileURL!
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
    
    func getDocumentDirectory() throws -> String{
           let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
       
           let fileManager = FileManager.default
           
           let filePath = documentDirectory.appending("/Cbo/Product/")
           base_local_root = filePath
            if !fileManager.fileExists(atPath: filePath) {
                do {
                    try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    throw error
                }
                   return filePath
            } else {
                return  filePath
            }
        
       }
   
    
   
    
    func resumeDownload(){
        if customVariablesAndMethod.internetConneted(context: self) {
            print("Connected to the internet")
            self.checkrequests?.resume()
            //  Do something
        } else {
            print("No internet connection")
            resumeDownload()
            //  Do something
        }
    }
    
    
    
    
    func getPercant(precent: Int , fileName : String) {
        VisualAidDownload.alert = nil
        downloadPercent.text = "\(precent)% Downloaded"
        progressBar.progress = Float(precent) * 0.01
        self.fileName.text = fileName
        if (Float(precent) * 0.01) == 1.0 {
            VisualAidDownload.alert = showAlertView()
           self.present( VisualAidDownload.alert, animated: true, completion: nil)
            downloadButton.isHidden = false
        }
    }
    
   
    
    func showAlertView() -> UIAlertController {
        
        let alertViewController = UIAlertController(title: "Download Complete" , message: "Press Ok"
        , preferredStyle: .alert)
        
        let okbutton = UIAlertAction(title: "ok", style: .cancel) { (action) in
            
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "dd/MM/yyyy h:mm a"
            let dateString = df.string(from: date)
            
             var dbBrandID = ""
            
            for i in 0 ..< self.afterBrandId.count{
                
                dbBrandID = dbBrandID + self.afterBrandId[i] + "^"
                
                self.cbohelp.updateListVisualData(submitYN: "1", brandId: self.afterBrandId[i], dateTime: dateString)
                
            }
            
           
            
            var params = [String:String]()
            params["sCompanyFolder"]  = self.cbohelp.getCompanyCode()
            params["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
            params["sBRAND_ID_ARR"] = dbBrandID

            let tables = [0]
            CboServices().customMethodForAllServices(params: params, methodName: "VISUALAIDDOWNLOADED_COMMIT", tables: tables, response_code: self.UPDATE_VISUALAID_DOWNLAOD, vc : self , multiTableResponse: false)
                   
            
            
            if (Custom_Variables_And_Method.getInstance().isVisualAddDownloadRequired(context: self)) {
                
                let visualversion = self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "VISUALAID_VERSION", defaultValue: "")
                self.customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE( vc : self ,key: "VISUALAID_VERSION_DOWNLOAD", value: visualversion);
                
                self.myTopView.CloseAllVC(vc: self)
                
               
            } else {
                
                //self.dismiss(animated: true, completion: nil)
                self.myTopView.CloseAllVC(vc: self)
                
            }
            
            
        }
                    
            alertViewController.addAction(okbutton)
            return alertViewController
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
       
        switch response_code {
     
        case UPDATE_VISUALAID_DOWNLAOD:
            
           // parser_zip(dataFromAPI : dataFromAPI)
            print("dataFromAPI ",dataFromAPI)
            
        case 99:
            customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
            break
        default:
            print("Error")
        }
        
    }
    
    
    
    
    
    
    
    // display all file
//    func displayAllFile(){
//           let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//
//        let myFilesPath = documentDirectoryPath.appending("/")
//        let files = FileManager.default.enumerator(atPath: myFilesPath)
//        while let file = files?.nextObject() {
//            print(file)
//        }
//
//    }
    
    
    // function to download images
//    func startDownloadImages( indexValue : Int){
//        fileName.text = arrayString[index]
        
//        if( index == 0){
//            downloadPercent.text = "0 % download"
//        }else if (index == arrayString.count - 1){
//            progressBar.progress = 1.0
//              downloadPercent.text = "100 % download"
//        }else{
//
//            let per : Float = (Float((index * 100) / 15))
//            print(per)
//            progressBar.progress = Float(per/100)
//
//            downloadPercent.text = "\(per) % download"
//        }
    
        
//        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

//        localpath = (documentDirectory as NSString).appendingPathComponent(arrayString[indexValue])
//
//        print("\(arrayString[indexValue]) is downloading")
//
//        print(localpath)
////        self.upDownFTP.addRequestForDownloadFile(atRemotePath: arrayString[indexValue], toLocalPath: localpath)
//        self.upDownFTP.startProcessingRequests()
        
//    }

    
    
//    func removeOldFileIfExist( indexValue : Int) {
//        var indValue = indexValue
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        if paths.count > 0 {
//            let dirPath = paths[0]
//
//            let filePath = NSString(format:"%@/%@", dirPath, arrayString[indValue]) as String
//            if FileManager.default.fileExists(atPath: filePath) {
//                do {
//                    try FileManager.default.removeItem(atPath: filePath)
//                    indValue += 1
//                    removeOldFileIfExist(indexValue: indexValue)
//                    print("User photo has been removed")
//                } catch {
//                    print("an error during a removing")
//                }
//            }
//        }
//    }

    
    
    //////////////////////// upload download delegate function /////////////
//    func requestsManager(_ requestsManager: GRRequestsManagerProtocol!, didScheduleRequest request: GRRequestProtocol!){
//        print("Start")
//
//    }
//    var index = 0
//    func requestsManager(_ requestsManager: GRRequestsManagerProtocol!, didCompleteListingRequest request: GRRequestProtocol!, listing: [Any]!) {
//        arrayString = listing as! [String]
//
//
//        for i in 0 ..< arrayString.count - 1{
//         print(arrayString[i].substringFrom(offSetTo: 0))
//
//        }
//
//        print("List Of files visual add :\n" , listing )
//       // startDownloadImages(indexValue: index)
//    }

//    func requestsManager(_ requestsManager: GRRequestsManagerProtocol!, didCompletePercent percent: Float, forRequest request: GRRequestProtocol!) {
//
//        print("request compeleted" , percent)
//    }
//
//
//    func requestsManager(_ requestsManager: GRRequestsManagerProtocol!, didCompleteDownloadRequest request: GRDataExchangeRequestProtocol!) {
//
//        print(localpath)
//        if index < arrayString.count {
//
//            myImages.insert((UIImage(contentsOfFile: localpath))!, at: index)
//        }
//        index += 1
//
//
//        if myImages.count - 1   == arrayString.count - 1{
//            downloadButton.isHidden  = false
//            showAlertView()
//        }else {
//
//            startDownloadImages(indexValue: index)
//        }
//    }
//
//
//    func showAlertView(){
//        let alertViewController = UIAlertController(title: "Download Complete" , message: "Press Ok to cloase this massege or Press open to display visual Ad", preferredStyle: .alert)
//
//        let okbutton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//
//        alertViewController.addAction(okbutton)
//        self.present(alertViewController, animated: true, completion: nil)
//    }
//
//
//
//    func redirectToVisualAdPage(){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//
////        vc.arrayString = arrayString
////        vc.myImages = myImages
//
//        self.present(vc, animated: true, completion: nil)
//    }
//
//
//    func requestsManager(_ requestsManager: GRRequestsManagerProtocol!, didFailRequest request: GRRequestProtocol!, withError error: Error!) {
//        startDownloadImages( indexValue : index)
//
//        print(error)
//    }
//
//    func requestsManager(_ requestsManager: GRRequestsManagerProtocol!, didFailWritingFileAtPath path: String!, forRequest request: GRDataExchangeRequestProtocol!, error: Error!) {
//        print(error)
//    }

    
    func refreshCellForIndex(_ downloadModel: MZDownloadModel, index: Int) {
        let indexPath = IndexPath.init(row: index, section: 0)
        let cell = self.downloadTable.cellForRow(at: indexPath)
        if let cell = cell {
            let downloadCell = cell as! MZDownloadingCell
            downloadCell.updateCellForRowAtIndexPath(indexPath, downloadModel: downloadModel)
        }
    }
    
    
}


// MARK: UIAlertController Handler Extension

extension VisualAidDownload {
    
    func showAppropriateActionController(_ requestStatus: String) {
        
        if requestStatus == TaskStatus.downloading.description() {
            self.showAlertControllerForPause()
        } else if requestStatus == TaskStatus.failed.description() {
            self.showAlertControllerForRetry()
        } else if requestStatus == TaskStatus.paused.description() {
            self.showAlertControllerForStart()
        }
    }
    
    func showAlertControllerForPause() {
        
        let pauseAction = UIAlertAction(title: "Pause", style: .default) { (alertAction: UIAlertAction) in
            self.downloadManager.pauseDownloadTaskAtIndex(self.selectedIndexPath.row)
        }
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (alertAction: UIAlertAction) in
            self.downloadManager.cancelTaskAtIndex(self.selectedIndexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tag = alertControllerViewTag
        alertController.addAction(pauseAction)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertControllerForRetry() {
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (alertAction: UIAlertAction) in
            self.downloadManager.retryDownloadTaskAtIndex(self.selectedIndexPath.row)
        }
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (alertAction: UIAlertAction) in
            self.downloadManager.cancelTaskAtIndex(self.selectedIndexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tag = alertControllerViewTag
        alertController.addAction(retryAction)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertControllerForStart() {
        
        let startAction = UIAlertAction(title: "Start", style: .default) { (alertAction: UIAlertAction) in
            self.downloadManager.resumeDownloadTaskAtIndex(self.selectedIndexPath.row)
        }
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (alertAction: UIAlertAction) in
            self.downloadManager.cancelTaskAtIndex(self.selectedIndexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.view.tag = alertControllerViewTag
        alertController.addAction(startAction)
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func safelyDismissAlertController() {
        /***** Dismiss alert controller if and only if it exists and it belongs to MZDownloadManager *****/
        /***** E.g App will eventually crash if download is completed and user tap remove *****/
        /***** As it was already removed from the array *****/
        if let controller = self.presentedViewController {
            guard controller is UIAlertController && controller.view.tag == alertControllerViewTag else {
                return
            }
            controller.dismiss(animated: true, completion: nil)
        }
    }
}


extension VisualAidDownload: MZDownloadManagerDelegate {
    
    func downloadRequestStarted(_ downloadModel: MZDownloadModel, index: Int) {
        let indexPath = IndexPath.init(row: index, section: 0)
        downloadTable.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
    }
    
    func downloadRequestDidPopulatedInterruptedTasks(_ downloadModels: [MZDownloadModel]) {
        downloadTable.reloadData()
    }
    
    func downloadRequestDidUpdateProgress(_ downloadModel: MZDownloadModel, index: Int) {
        self.refreshCellForIndex(downloadModel, index: index)
    }
    
    func downloadRequestDidPaused(_ downloadModel: MZDownloadModel, index: Int) {
        self.refreshCellForIndex(downloadModel, index: index)
    }
    
    func downloadRequestDidResumed(_ downloadModel: MZDownloadModel, index: Int) {
        self.refreshCellForIndex(downloadModel, index: index)
    }
    
    func downloadRequestCanceled(_ downloadModel: MZDownloadModel, index: Int) {
        
        self.safelyDismissAlertController()
        
        let indexPath = IndexPath.init(row: index, section: 0)
        downloadTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        
    }
    
    func downloadRequestFinished(_ downloadModel: MZDownloadModel, index: Int) {
        
        let baseUrl = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "API_URL_MOBILE", defaultValue: "")
                   
        let zipPath = zipName[index].replacingOccurrences(of: "\(baseUrl)download/VISUALAID/", with: "").replacingOccurrences(of: "/zip", with: "")
        
        
        self.selectedzipName.append(zipPath)
        self.afterBrandId.append(BrandId[index])
        self.afterdownloadVersion.append(downloadVersion[index])
               
        self.safelyDismissAlertController()
        
        downloadManager.presentNotificationForDownload("Ok", notifBody: "Download did completed")
        
        let indexPath = IndexPath.init(row: index, section: 0)
        downloadTable.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        
        
        let docDirectoryPath : NSString = (MZUtility.baseFilePath as NSString).appendingPathComponent(downloadModel.fileName) as NSString
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: MZUtility.DownloadCompletedNotif as String), object: docDirectoryPath)
        
         self.zipName.remove(at: index)
         self.BrandId.remove(at: index)
         self.downloadVersion.remove(at: index)
        
        if zipName.count == 0 {
           // VisualAidDownload.alert = self.showAlertView()
            //self.present( VisualAidDownload.alert, animated: true, completion: nil)
            
            var dbBrandId = [String]()
            let db = self.cbohelp
            do {
            
                var list = try self.cbohelp.getListVisualByBrand();
                
                while let c2 = list.next(){
                    
                    dbBrandId.append(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "brandId")] as! String)
                    print(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "itemName")] as! String)
                    print(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "brandId")] as! String)
                    
                }
                
                //print("list ",list)
                
            } catch {
                print(error)
            }
            
            
            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
            
            let myDownloadPath = MZUtility.baseFilePath + "/Cbo/Product"
            let fileName = MZUtility.getUniqueFileNameWithPath((myDownloadPath as NSString).appendingPathComponent(downloadModel.fileName as String) as NSString)
            
            extractText.isHidden = false
            
            for i in 0..<selectedzipName.count{
                
                //remove previous folder of same name
                //let foldername =  MZUtility.baseFilePath+"/"+selectedzipName[i]
               // try? FileManager.default.removeItem(atPath: foldername)
                let fileManager = FileManager.default
                let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let path3 = ("\(documentDirectoryPath)/Cbo/Product/\(selectedzipName[i])")
                        
                //let fileManager = FileManager.default
                if fileManager.fileExists(atPath: path3) {
                    print("true")
                   // try! FileManager.default.removeItem(atPath: path3)
                }  else {
                    print("false")
                }
                
                                   
                
                let path =  myDownloadPath+"/"+selectedzipName[i]+"."+(fileName as String)
                
                
                var path2 = ""
                
                do {
                    
                    //let unzipDirectory = try Zip.quickUnzipFile(URL(fileURLWithPath: path))
                        
                    try Zip.unzipFile(URL(fileURLWithPath: path), destination: URL(string:"\(documentsUrl)Cbo/Product")!, overwrite: true, password: nil, progress:
                    {
                        (progress) -> () in
                       // print(progress)
                            
                    })
                        
                    //print("unzipDirectory",unzipDirectory)
                    //remove previous zip of same name
                    try? FileManager.default.removeItem(atPath: path)
                    
                    
                    if dbBrandId.contains(afterBrandId[i]) {
                         self.cbohelp.updateListVisualData(submitYN: "0", brandId: afterBrandId[i], dateTime: "")
                    }
                    
                    
                   // cbohelp.SaveVisualAdd(itemId: "", itemName: selectedzipName[i], fileName: selectedzipName[i], downLoadVersion: afterdownloadVersion[i], brandId: afterBrandId[i], submitYN: "0")
                   
                    path2 = try (self.getDocumentDirectory()) as String
                    
                } catch (let writeError) {
                    print("Error unzip a file : \(writeError)")
                }
                            
                //let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let path1 = "\(myDownloadPath)/\(selectedzipName[i])/" //("\(documentDirectoryPath)/\(selectedzipName[i])")
                       
                do {
                    
                    let originFolder = try Folder(path: path1)
                    let targetFolder = try Folder(path: path2)
                    try originFolder.subfolders.move(to: targetFolder)
                    try originFolder.files.move(to: targetFolder)
//
//                  try FileManager.default.copyItem(atPath: path1, toPath: path2);
                    try FileManager.default.removeItem(atPath: path1)
                            
                } catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
                
                if i == selectedzipName.count-1 {
                    VisualAidDownload.alert = self.showAlertView()
                    self.present( VisualAidDownload.alert, animated: true, completion: nil)
                    
                }
                
                
            }
            
            
            
            
            
        }
        
        
    }
    
    func downloadRequestDidFailedWithError(_ error: NSError, downloadModel: MZDownloadModel, index: Int) {
        self.safelyDismissAlertController()
        self.refreshCellForIndex(downloadModel, index: index)
        
        debugPrint("Error while downloading file: \(String(describing: downloadModel.fileName))  Error: \(String(describing: error))")
    }
    
    //Oppotunity to handle destination does not exists error
    //This delegate will be called on the session queue so handle it appropriately
    func downloadRequestDestinationDoestNotExists(_ downloadModel: MZDownloadModel, index: Int, location: URL) {
       
         
        
        let myDownloadPath = MZUtility.baseFilePath + "/Cbo/Product"
        if !FileManager.default.fileExists(atPath: myDownloadPath) {
            try! FileManager.default.createDirectory(atPath: myDownloadPath, withIntermediateDirectories: true, attributes: nil)
        }
        let fileName = MZUtility.getUniqueFileNameWithPath((myDownloadPath as NSString).appendingPathComponent(downloadModel.fileName as String) as NSString)
        debugPrint("Default folder path: \(myDownloadPath)")
        
        let baseUrl = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "API_URL_MOBILE", defaultValue: "")
                   
        let zipPath = zipName[index].replacingOccurrences(of: "\(baseUrl)download/VISUALAID/", with: "").replacingOccurrences(of: "/zip", with: "")
       
       
        let path =  myDownloadPath+"/"+zipPath+"."+(fileName as String)
        
        do {
            try FileManager.default.moveItem(at: location, to: URL(fileURLWithPath: path))
            //try FileManager.default.copyItem(at: location, to: URL(fileURLWithPath: path))
                
        } catch (let writeError) {
            print("file move error : \(writeError)")
        }
        
        
        
        
    }
}



