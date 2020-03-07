//
//  AvailableDownload.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 26/02/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import UIKit

class AvailableDownload: CustomUIViewController, UITableViewDataSource , UITableViewDelegate, CheckBoxDelegate  {
    
    
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        let tag = sender.getTag() as! [Any]
        let index = tag[1] as! Int
        let smp_id = zipName[index]
        let smp_name = sample_name[index]

        if(ischecked && !SelectedzipName.contains(smp_id)){
            selected.insert(smp_name)
            SelectedzipName.append(smp_id)
            SelectedBrandId.append(brandId[index])
            SelectedVersion.append(fileVserion[index])
        }else if (!ischecked){
            selected.remove(smp_name)
            
            if let index = SelectedzipName.index(of: smp_id) {
                SelectedzipName.remove(at: index)
                SelectedBrandId.remove(at: index)
                SelectedVersion.remove(at: index)
            }
            
        }else if selecedBrandPre.contains(smp_id){
            showAdTableView.reloadData()
        }
            
        print(SelectedzipName)
    }
    
   
    var sample_name = [String]()
    var selecedBrandPre = [String]()
    var fileVserion = [String]()
    var brandId = [String]()
    var downloadDate = [String]()
    var uploaddDate = [String]()
    let promoted_tag = 0
    var selected = Set<String>()
    
     var dataList = [DocSampleModel]()
    
    let INTERNET_MSG_VISUALAID_DOWNLAOD_ZIP = 1
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var zipName = [String]()
    var SelectedzipName = [String]()
    var SelectedBrandId = [String]()
    var SelectedVersion = [String]()
    var customVariablesAndMethod : Custom_Variables_And_Method!
    @IBOutlet weak var mytopView: TopViewOfApplication!
       
    @IBOutlet weak var showAdTableView: UITableView!
    @IBOutlet weak var continuebtn: CustomeUIButton!
    
    static var alert : UIAlertController!
    var dbBrandId = [String]()
    var dbDownloadDate = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mytopView.setText(title: VCIntent["title"]!)
        continuebtn.setTitle("Start Download", for: .normal)
        mytopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        continuebtn.addTarget(self, action: #selector(downloadButtonPressed), for: .touchUpInside)
        customVariablesAndMethod=Custom_Variables_And_Method.getInstance()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SelectedzipName.removeAll()
        //showAdTableView.reloadData()
        selected.removeAll()
        self.showAdTableView.reloadData()
        var params = [String:String]()
        params["sCompanyFolder"]  = cbohelp.getCompanyCode()
        params["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"

        let tables = [0]
        CboServices().customMethodForAllServices(params: params, methodName: "VISUALAID_DOWNLOAD_ZIP", tables: tables, response_code: INTERNET_MSG_VISUALAID_DOWNLAOD_ZIP, vc : self , multiTableResponse: false)
        
    }
    
    @objc func closeVC() {
   
        mytopView.CloseCurruntVC(vc: self)
    }
    
    @objc func downloadButtonPressed(){
        
        if SelectedzipName.count > 0 {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let visualAidDownloadVC = storyBoard.instantiateViewController(withIdentifier: "VisualAidDownload") as! VisualAidDownload
            
            visualAidDownloadVC.VCIntent["title"] = "Visual Aids Download"
            visualAidDownloadVC.zipName = SelectedzipName
            visualAidDownloadVC.downloadVersion = SelectedVersion
            visualAidDownloadVC.BrandId = SelectedBrandId
            self.present(visualAidDownloadVC, animated: false, completion: nil)
            
            
        } else {
            
            customVariablesAndMethod.getAlert(vc: self, title: "Alert", msg: "Please select atleast one visual aid for downloading")
        }
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sample_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("VisualAdRow", owner: self, options: nil)?.first as! VisualAdRow
        cell.selectionStyle = .none
        cell.imgwidth.constant = 0
        cell.adName.text = sample_name[indexPath.row]
        cell.checkbox.isHidden = false
        cell.promoted.isHidden = true
        cell.checkbox.delegate = self
        cell.checkbox.setTag(tag: [promoted_tag,indexPath.row,cell] )
        cell.checkbox.setChecked(checked: selected.contains(sample_name[indexPath.row]));
        
        if uploaddDate[indexPath.row] != "" {
            cell.uploaddateTime.text = "Upload \(uploaddDate[indexPath.row])"
            cell.uploaddateTime.isHidden = false
        } else {
            cell.uploaddateTime.isHidden = true
        }
        
        for i in 0 ..< dbBrandId.count{
            
            if dbBrandId[i] == brandId[indexPath.row] {
                
                if dbDownloadDate[i] != "" {
                    cell.downloaddateTime.text = "Download \(dbDownloadDate[i])"
                    cell.downloaddateTime.isHidden = false
                } else {
                    cell.downloaddateTime.isHidden = true
                }
                
                
                break
            } else {
                cell.downloaddateTime.isHidden = true
            }
            
        }
            
        cell.myImageView.isHidden = true
        return cell
    }
    
   
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]) {
          
           switch response_code {
        
           case INTERNET_MSG_VISUALAID_DOWNLAOD_ZIP:
               
               parser_zip(dataFromAPI : dataFromAPI)
               
           case 99:
               customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
               break
           default:
               print("Error")
           }
           
       }
    
    
     private func parser_zip(dataFromAPI : [String : NSArray]) {
         
        //cbohelp.deleteListVisualData()
            zipName.removeAll()
            sample_name.removeAll()
            brandId.removeAll()
            fileVserion.removeAll()
            AvailableDownload.alert = nil
            
            let db = self.cbohelp
            do {
            
                var list = try self.cbohelp.getListVisualByBrand();
                
                while let c2 = list.next(){
                    
                    dbBrandId.append(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "brandId")] as! String)
                    dbDownloadDate.append(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "downloadDateTime")] as! String)
                    print(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "itemName")] as! String)
                    print(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "brandId")] as! String)
                    
                }
                
                //print("list ",list)
                
            } catch {
                print(error)
            }
        
            if(!dataFromAPI.isEmpty){
                
                var downloadData = [String]()
                let jsonArray =   dataFromAPI["Tables0"]!
                for i in 0 ..< jsonArray.count{
                                        
                    let innerJson = jsonArray[i] as! [String : AnyObject]
                    
                   // if !dbBrandId.contains(innerJson["BRAND_ID"]! as! String){
                        
                        let baseUrl = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "API_URL_MOBILE", defaultValue: "")
                         
                        //let tpken = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "WEBSERVICE_URL", defaultValue: "")
                         
                         zipName.append("\(baseUrl)download/VISUALAID/"+(innerJson["FILE_NAME"]! as! String).replacingOccurrences(of: ".zip", with: "")+"/zip")
                         sample_name.append((innerJson["FILE_NAME"]! as! String).replacingOccurrences(of: ".zip", with: ""))
                         
                         fileVserion.append((innerJson["FILE_VERSION"]! as! String))
                         
                         brandId.append((innerJson["BRAND_ID"]! as! String))
                         uploaddDate.append((innerJson["UPLOAD_DATE"]! as! String))
                        
                    //} else {
                      //  downloadData.append((innerJson["FILE_NAME"]! as! String).replacingOccurrences(of: ".zip", with: ""))
//                    }
                    
                    if dbBrandId.count > 0 {
                        
                        if !dbBrandId.contains(innerJson["BRAND_ID"]! as! String) {
                            cbohelp.SaveVisualAdd(itemId: innerJson["ITEM_ID"]! as! String, itemName: (innerJson["FILE_NAME"]! as! String), fileName: (innerJson["FILE_NAME"]! as! String), downLoadVersion: (innerJson["FILE_VERSION"]! as! String), brandId: (innerJson["BRAND_ID"]! as! String), submitYN: "0")
                        }
                        
                    } else {
                       
                        cbohelp.SaveVisualAdd(itemId: innerJson["ITEM_ID"]! as! String, itemName: (innerJson["FILE_NAME"]! as! String), fileName: (innerJson["FILE_NAME"]! as! String), downLoadVersion: (innerJson["FILE_VERSION"]! as! String), brandId: (innerJson["BRAND_ID"]! as! String), submitYN: "0")
                    }
                    
                    
                    
                }
                
                if zipName.count > 0 || downloadData.count > 0{
                    
//                    for i in 0 ..< downloadData.count{
//                        self.sample_name.append(downloadData[i])
//                    }
                    
                    
                    self.showAdTableView.reloadData()
                   
                } else {
                    //customVariablesAndMethod.msgBox(vc: self, msg: "No File To Download")
                    AvailableDownload.alert = self.showAlertView()
                    self.present( AvailableDownload.alert, animated: true, completion: nil)
                }
                
            }
        }
    
    
    func showAlertView() -> UIAlertController {
        
        let alertViewController = UIAlertController(title: "No File To Download" , message: "Press Ok"
        , preferredStyle: .alert)
        
        let okbutton = UIAlertAction(title: "ok", style: .cancel) { (action) in
            
            self.dismiss(animated: true, completion: nil)
        }
                    
        alertViewController.addAction(okbutton)
        return alertViewController
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
