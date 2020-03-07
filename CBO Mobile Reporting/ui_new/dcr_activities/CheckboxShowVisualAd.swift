//
//  CheckboxShowVisualAd.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 10/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
import Zip

class CheckboxShowVisualAd: CustomUIViewController, UITableViewDataSource , UITableViewDelegate, CheckBoxDelegate {
   
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        let tag = sender.getTag() as! [Any]
        let index = tag[1] as! Int
        let smp_id = sample_id[index]
//        if selected.contains(smp_id) {
//            selected.remove(smp_id)
//            //cbohelp.insertdata(drid: Custom_Variables_And_Method.DR_ID, item: sample_id[index], item_name: sample_name[index], qty: "", pob: "", stk_rate: "", visual: "", noc: "", tick: 0)
//        } else {
//            selected.insert(smp_id)
//        }
        
        if(ischecked && !selected.contains(smp_id)){
            selected.insert(smp_id)
        }else if (!ischecked && !selecedBrandPre.contains(smp_id)){
            selected.remove(smp_id)
        }else if selecedBrandPre.contains(smp_id){
            showAdTableView.reloadData()
        }
        
        print(selected)
    }
    
    
    var dataList = [DocSampleModel]()
    
    let promoted_tag = 0
    var myImagesDic = [[String : [String]]]()
    var selected = Set<String>()
    var indexId = 0
    var selecedBrandPre = [String]()
    
    var setimageId = [String]()
    
    var who = 1

    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var sample_id = [String]()
    var sample_name = [String]()
     
    private var sample_name_Stored = "" , sample_pob = "" , sample_sample = ""
    var MESSAGE_FROM_LIST_AD=2
    var responseCode : Int! = 0
    var vc : CustomUIViewController!
     
    //var presenter  : CheckVisualAdAdaptor!
    
    @IBOutlet weak var mytopView: TopViewOfApplication!
    
    @IBOutlet weak var showAdTableView: UITableView!
    @IBOutlet weak var continuebtn: CustomeUIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
        do {
            let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let Path = documentURL.appendingPathComponent("Cbo").absoluteURL
            let directoryContents = try FileManager.default.contentsOfDirectory(at: Path, includingPropertiesForKeys: nil, options: [])
            
            print("directoryContents ",directoryContents)
        }
        catch {
            print(error.localizedDescription)
        }
        
        
        /*let documentsDirectory = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
        
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent("Cbo.zip")
        
        do {
            
            let unzipDirectory = try Zip.quickUnzipFile(destinationFileUrl)
                                        
            print("unzipDirectory",unzipDirectory)
           

        } catch (let writeError) {
            print("Error creating a file \(destinationFileUrl) : \(writeError)")
        }*/
        
        

        continuebtn.setText(text: "Continue")
        continuebtn.addTarget(self, action: #selector(ContinueBtnClicked), for: .touchUpInside)
        
        if !((VCIntent["who"]?.isEmpty)!){
            who = Int(VCIntent["who"]!)!
        }
        
        
        if (who==0){
            
            if !((VCIntent["sample_name"]?.isEmpty)!){
                sample_name_Stored = VCIntent["sample_name"]!
            }
            if !((VCIntent["sample_pob"]?.isEmpty)!){
                sample_pob = VCIntent["sample_pob"]!
            }
            if !((VCIntent["sample_sample"]?.isEmpty)!){
               sample_sample = VCIntent["sample_sample"]!
            }
        }
        
        var splcode = ""
        
        do {
            let  statement  =  try  cbohelp.getDoctorSpecialityCodeByDrId(dr_id: Custom_Variables_And_Method.DR_ID);

            while let c1 = statement.next(){
                splcode = (try c1[cbohelp.getColumnIndex(statement: statement, Coloumn_Name: "remark")] as! String)
                
            }
        }catch{
            print(error)
        }
        
        Custom_Variables_And_Method.pub_doctor_spl_code = splcode
        
        if !(VCIntent["title"]?.isEmpty)!{
            mytopView.setText(title: VCIntent["title"]!)
        }
        mytopView.backButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selected.removeAll()
        
        dataList =  getAllVisualAdd()
        
        print("dataList",dataList)
        //presenter = CheckVisualAdAdaptor(tableView: showAdTableView , vc : self, dataList: getAllVisualAdd(), sample_id: sample_id, sample_name: sample_name)

        showAdTableView.delegate = self//presenter
        showAdTableView.dataSource = self//presenter
        showAdTableView.reloadData()
    
    }
    
    func clearDiskCache(){
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let diskCacheStorageBaseUrl = myDocuments.appendingPathComponent("/Cbo/Product/")
        guard let filePaths = try? fileManager.contentsOfDirectory(at: diskCacheStorageBaseUrl, includingPropertiesForKeys: nil, options: []) else { return }
        print(filePaths)
        for filePath in filePaths {
            try? fileManager.removeItem(at: filePath)
        }
    }
    
    @objc func ContinueBtnClicked(){
        
        //getAllVisualAdd()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListAdImageViewController") as! ListAdImageViewController
        vc.indexId = 0
        vc.VCIntentArray["sample_id"] = sample_id
        vc.VCIntentArray["sample_name"] = sample_name
        vc.responseCode = MESSAGE_FROM_LIST_AD
        vc.vc =  self
        vc.selected = selected
        
        self.present(vc, animated: true, completion: nil)
    }
    
   
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
            switch response_code {
            
            case MESSAGE_FROM_LIST_AD:

                self.dismiss(animated: true) {
                    self.vc.getDataFromApi(response_code: self.responseCode, dataFromAPI: dataFromAPI)
                }
                break;
            
            default:
                print("Error")
            }
    }


    func getAllVisualAdd() -> [DocSampleModel]{
            sample_id.removeAll()
            sample_name.removeAll()
            var list = [DocSampleModel]()
            var ItemIdNotIn = "0"
            
            do {
               let db = cbohelp
                
                selecedBrandPre = db.getDoctorVisualIdByBrand(drid: Custom_Variables_And_Method.DR_ID)
                
                for i in 0..<selecedBrandPre.count {
                    selected.insert(selecedBrandPre[i])
                }
            
                var cnt = 0;
//                var  statement3 = try cbohelp.getAllVisualAddByBrand(itemidnotin: ItemIdNotIn, SHOW_ON_TOP: "Y");
//                //Cursor c=myitem.getSelected();
//                //rs=stmt.getResultSet();
//
//                if  statement3.next() != nil {
//                    statement3 = try cbohelp.getAllVisualAddByBrand(itemidnotin: ItemIdNotIn, SHOW_ON_TOP: "Y");
//                    while let c = statement3.next() {
//
//
//                        sample_id.append(try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_ID")] as! String);
//
//                        sample_name.append(try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_NAME")] as! String);
//
//                        list.append( DocSampleModel(name: (try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_NAME")] as! String), id: (try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_ID")] as! String), rowid: "\(cnt)") )
//
//                        cnt += 1
//                    }
//                }
        
                
                var cnt3 = 0;
               Custom_Variables_And_Method.DOCTOR_SPL_ID = 1
                 var statement4 = try cbohelp.getphitemSplByBrand();
                var cnt2 = 0
     
                var  statement2  = try  cbohelp.getSelectedFromDrByBrand(dr_id: Custom_Variables_And_Method.DR_ID);

                while let c1 = statement2.next(){
                    
                    
                    list.append(DocSampleModel(name: (try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "BRAND_NAME")] as! String), id: "\(try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "BRAND_ID")]!)", rowid: "\(cnt2)"))
                    
                    
                    sample_id.append("\(try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "BRAND_ID")]!)");
                    sample_name.append(try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "BRAND_NAME")] as! String);
                    
                    
                    ItemIdNotIn = "\(ItemIdNotIn),\(String(describing: try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "BRAND_ID")]!))"
                    //print(ItemIdNotIn)
                    
                    cnt2 = cnt2+1;
                    
                }
                
                statement2  = try  cbohelp.getSelectedFromDrByBrand(dr_id: Custom_Variables_And_Method.DR_ID);

                if (statement2.next() != nil &&  who == 0 && customVariablesAndMethod1.getDataFrom_FMCG_PREFRENCE(vc: self, key: "VISUALAID_DRSELITEMYN", defaultValue: "N") == "Y") {
                    
    //                statement2  = try  cbohelp.getSelectedFromDr(dr_id: Custom_Variables_And_Method.DR_ID);
    //                while let c1 = statement2.next(){
    //
    //
    //                    list.append(DocSampleModel(name: (try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "item_name")] as! String), id: (try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "item_id")] as! String), rowid: "\(cnt2)"))
    //
    //
    //                    sample_id.append(try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "item_id")] as! String);
    //                    sample_name.append(try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "item_name")] as! String);
    //
    //
    //                    ItemIdNotIn = "\(ItemIdNotIn),\(String(describing: try c1[db.getColumnIndex(statement: statement2, Coloumn_Name: "item_id")])))"
    //                print(ItemIdNotIn)
    //
    //                    cnt2 = cnt2+1;
    //
    //                 }
                }else if  statement4.next() != nil &&  who == 0{
                    statement4 = try cbohelp.getphitemSplByBrand();
                    var list = [DocSampleModel]()
                    while let c2 = statement4.next(){

                        list.append(DocSampleModel(name: (try c2[db.getColumnIndex(statement: statement4, Coloumn_Name: "BRAND_NAME")] as! String), id: (try c2[db.getColumnIndex(statement: statement4, Coloumn_Name: "BRAND_ID")] as! String), rowid: "\(cnt3)"))

                        sample_id.append(try c2[db.getColumnIndex(statement: statement4, Coloumn_Name: "BRAND_ID")] as! String);

                        sample_name.append(try c2[db.getColumnIndex(statement: statement4, Coloumn_Name: "BRAND_NAME")] as! String);

    //                    ItemIdNotIn = "\(ItemIdNotIn),\(try c2[db.getColumnIndex(statement: statement4, Coloumn_Name: "item_id")]! ?? "0")"
                    }
                }
                else {
               
                    cnt = 0;
                    var  statement3 = try cbohelp.getAllVisualAddByBrand(itemidnotin: ItemIdNotIn, SHOW_ON_TOP: "N");
                    //Cursor c=myitem.getSelected();
                    //rs=stmt.getResultSet();
                    
                    if  statement3.next() != nil {
                        statement3 = try cbohelp.getAllVisualAddByBrand(itemidnotin: ItemIdNotIn, SHOW_ON_TOP: "N");
                        while let c = statement3.next() {
                            
                            
                            sample_id.append(try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_ID")] as! String);
                            
                            sample_name.append(try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_NAME")] as! String);
                            
                            list.append( DocSampleModel(name: (try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_NAME")] as! String), id: (try c[db.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_ID")] as! String), rowid: "\(cnt)") )
                            
                            cnt += 1
                        }
                    }
                }
                
                // get the list of files in mobile
                let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let myFilesPath = documentDirectoryPath.appending("/Cbo/Product/")
                let fileManager = FileManager.default
                
                
                let files = fileManager.enumerator(atPath: myFilesPath)


                while let file  = files?.nextObject()  {
                    
                    let file1 = file as! String
                    
                    if (file1.contains(".")){
                        let file_Name = file1.subString(offsetFrom:0, offSetTo: file1.lastIndexOf(char: ".") - 1 )
                        if (file1.contains(".") && sample_id.contains(file_Name) ){

                            for j in  0 ..< sample_id.count {
                                //print(sample_id[j])
                                //print("fileName : " + file_Name)
                                
                                if (sample_id[j] == (file_Name)) {
                                    list[j].set_file_ext(file_ext:getFileExtension(fileName: file1) )
                                    
                                    let imgfull: String = file1
                                    let first = imgfull.components(separatedBy: ".")
                                    list[j].setImgId(imgid: first[0])
                                    setimageId.append(first[0])
                                    //print("image ",file1)
                                    //print("path ", first[0])
                                    
                                    break;
                                }
                            }
                        }
                        
                    } else {
                        
                        if (sample_name.contains("CATALOG")) {
                            for j in 0 ..< sample_name.count {
                                //list[j].setImgId(imgid: first[0])
                                if (sample_name[j] == "CATALOG") {
                                    list[j].set_file_ext(file_ext: ".html");
                                    list[j].setImgId(imgid: "")
                                    setimageId.append("")
                                        break;
                                    }
                                }
                            }
                        }

                    print(sample_id)
                }

                
            }catch{
                print(error)
            }
            
            
            if (who==0) {
                var sample_name1  =  sample_name_Stored.split(separator: ",")
                /*String[] sample_qty1 = sample_sample.split(",");
                 String[] sample_pob1 = sample_pob.split(",");*/
                print(sample_name1)
                for  i in  0 ..< sample_name1.count {
                    for j in 0 ..< list.count  {
                        if (sample_name1[i] == (list[j].getName())) {
                            list[j].set_Checked(checked: true);
                        }
                    }
                }
            }

            
            
            return list
        }
        
        func getFileExtension(fileName : String) -> String {
            let  exte = NSURL ( fileURLWithPath: fileName).pathExtension ?? ""
            return ".\(exte)"
        }
        
        
        
        func convertingArrayToDictionary(listName : [String]){
            myImagesDic.removeAll()
            var tempArray = [String]()
            var l = 0
            for i in 0 ..< listName.count{
                if (listName[i] as NSString).pathExtension ==  "jpg" || (listName[i] as NSString).pathExtension ==  "png"   {
                    
                    tempArray.removeAll()
                    
                    for j in 0 ..< listName.count{
                        // print(listName[j].first! , i)
                        
                        var k = 0
                        let var1  : String = listName[j].subString(offsetFrom: 0, offSetTo: 0)  , var2 = "\(i)"
                        
                        if var1 == var2 {
                            //                    print("\(i)=\(listName[j])")
                            tempArray.insert(listName[j], at: k)
                            k += 1
                        }
                    }
                    if !( tempArray.isEmpty){
                        //                    print(tempArray)
                        myImagesDic.insert([tempArray[0] : tempArray], at: l)
                        l += 1
                    }
                }
            }
        }


        @objc func closeVC(){
            
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
             
             let myFilesPath1 = "\(documentDirectoryPath)/Cbo/Product"
             
            
             
             if FileManager.default.fileExists(atPath: myFilesPath1){
                 print("true")
                
                //clearDiskCache()
                           
             } else {
                 print("false")
             }
            
            mytopView.CloseCurruntVC(vc: self)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataList.count
       
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = Bundle.main.loadNibNamed("VisualAdRow", owner: self, options: nil)?.first as! VisualAdRow
            cell.selectionStyle = .none
            cell.adName.text = dataList[indexPath.row].getName()
            cell.checkbox.isHidden = false
            cell.promoted.isHidden = true
            cell.checkbox.delegate = self
            cell.checkbox.setTag(tag: [promoted_tag,indexPath.row,cell] )
            cell.checkbox.setChecked(checked: selected.contains(sample_id[indexPath.row]));
        
            if (dataList[indexPath.row].get_Checked()){
                
                cell.adName.textColor = UIColor(hex: "#7c7b7b")
               // cell.promoted.isHidden = false
                cell.contentView.backgroundColor = UIColor(hex: "#e7e7e8")
                
    //          view.setBackgroundResource(R.drawable.list_selector_selected);
                   
            } else {
                cell.adName.textColor = UIColor(hex:"#000000")
               // cell.promoted.isHidden = true
                cell.contentView.backgroundColor = UIColor.white
                //    view.setBackgroundResource(R.drawable.list_selector_unselected);
            }
            
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        var url: String = "\(dataList[indexPath.row].getId())"
        
       
        
       // print("url ",dataList[indexPath.row].getImgId())
        url = url.replacingOccurrences(of: ".jpg", with: "")
            
        let path1 =  ("\(documentDirectoryPath)/Cbo/Product/\(url)_\(Custom_Variables_And_Method.pub_doctor_spl_code ?? "").jpg");
        
        let path = ("\(documentDirectoryPath)/Cbo/Product/\(url).jpg")
        
        print("path ", path)
        let fileManager = FileManager.default
        
        cell.imgwidth.constant = 0
        cell.myImageView.isHidden = true
        
       /* if fileManager.fileExists(atPath: path1) {
            cell.myImageView?.image = UIImage(contentsOfFile: path1)
        } else if  fileManager.fileExists(atPath: path) {
           cell.myImageView?.image = UIImage(contentsOfFile: path)
            
        } else {
            cell.myImageView?.image = UIImage(named: "no_image.png")
        }*/
            
            /*switch (dataList[indexPath.row].get_file_ext().lowercased()) {
            case ".pdf":
                cell.myImageView?.image = UIImage(named: "pdf_icon.png")
                break;
            case ".avi",".mov",".3gp",".mp4":
                cell.myImageView?.image = UIImage(named: "mp4_icon.png")
                break
            case ".mp3":
                cell.myImageView?.image = UIImage(named: "music_icon.png")
                break;
            case ".html":
                cell.myImageView?.image = UIImage(named: "web_login_white.png")
                break;
            
            case ".bmp",".jpg",".gif",".png":
                cell.myImageView?.image = UIImage(named: "image_icon.png")
                break
            
            default:
                
                cell.myImageView?.image = UIImage(named: "no_image.png")
            }*/
        
            return cell
        
        }

}
