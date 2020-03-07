//
//  TAmannualExpense.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 28/01/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import UIKit
import DLRadioButton

class TAmannualExpense: CustomUIViewController, CheckBoxDelegate, FTPUploadDelegate {
    
    @IBOutlet weak var perkmStackiew: UIStackView!
    @IBOutlet weak var fixStackiew: UIStackView!
    @IBOutlet weak var add: CustomeUIButton!
    @IBOutlet weak var cancel: CustomeUIButton!
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var ExpHeadDropDown :  DPDropDownMenu!
    @IBOutlet weak var AttachmentImageView: UIImageView!
    
    @IBOutlet weak var CameraButton: DLRadioButton!
    @IBOutlet weak var galleryButton: DLRadioButton!
    
    @IBOutlet weak var fromtext: UILabel!
    @IBOutlet weak var totext: UILabel!
    
    @IBOutlet weak var per_km_txt: CustomTextView!
    @IBOutlet weak var km_txt: CustomTextView!
    @IBOutlet weak var total_amt_txt: CustomTextView!
    @IBOutlet weak var remark_txt: CustomTextView!
    
    @IBOutlet weak var fix_amt: CustomTextView!
    @IBOutlet weak var fix_remark: CustomTextView!
    @IBOutlet weak var AttachmentOptionStackView: UIStackView!
    
    let inverseSet = NSCharacterSet(charactersIn:"0123456789.").inverted
    
    var areatype = ""
    var imagePickerController = UIImagePickerController()
    
    var cbohelp = CBO_DB_Helper.shared
    var progressHUD : ProgressHUD!
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    var objImagePicker : ImagePicker!
    var exp_hed = ""
    var exp_id = ""
    var taList = [SpinnerModel]();
    let CALL_DILOG = 5 , MESSAGE_INTERNET_POPULATE = 1, MESSAGE_INTERNET_COMMIT = 2, TA_MANUAL_UPDATE = 8
    
    var dropDownList =  [DPItem]()
    
    var filename = "", serverfilname = ""
    var vc : CustomUIViewController!
    var responseCode : Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objImagePicker = ImagePicker(imagePickerController: imagePickerController, vc: self , source : ImagePicker.camera)
        
        
        perkmStackiew.isHidden = true
        fixStackiew.isHidden = true
        AttachmentOptionStackView.isHidden =  true
        per_km_txt.isUserInteractionEnabled = false
        total_amt_txt.isUserInteractionEnabled = false
        
        progressHUD = ProgressHUD(vc : self)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        
        checkBox.delegate = self
        
        km_txt.setKeyBoardType(keyBoardType: .decimalPad)
        fix_amt.setKeyBoardType(keyBoardType: .decimalPad)
        
        cancel.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        add.addTarget(self, action: #selector(addTA), for: .touchUpInside )
        
        CameraButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(openGallery), for: .touchUpInside)
        
        fix_amt.onTextChanged = { text in
            
            do {
                let regex = try NSRegularExpression(pattern: ".*[^0-9].*", options: [])
                if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.characters.count)) != nil {
                    print("test")
                    self.customVariablesAndMethod1.msgBox(vc: self,msg: "Please Enter Only Numeric...");
                    
                    self.fix_amt.setText(text: text.substring(to: text.index(before: text.endIndex)))

                }
                
            } catch {

            }
            
        }
        
        km_txt.onTextChanged = { text in
            
            do {
                let regex = try NSRegularExpression(pattern: ".*[^0-9 ^.].*", options: [])
                if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.characters.count)) != nil {
                    print("test")
                    self.customVariablesAndMethod1.msgBox(vc: self,msg: "Please Enter Only Numeric...");
                    
                    self.km_txt.setText(text: text.substring(to: text.index(before: text.endIndex)))


                } else {

                    if text != "" {
                        
                        var price:Double = 0.0, amt:Double = 0.0
                        if text.contains(".") {
                            
                            let fullNameArr = text.components(separatedBy: ".")
                            
                            if fullNameArr[1].count > 0 {
                                price = Double(self.per_km_txt.getText())!
                                let amt = Float(price) * Float(text)!
                                self.total_amt_txt.setText(text: "\(round(amt*100)/100)")
                                print("amt check ",round(amt*100)/100)
                            }
                            
                        } else {
                            price = Double(self.per_km_txt.getText())!
                            amt = price * Double(Int(text)!)
                            self.total_amt_txt.setText(text: "\(amt)")
                            print("amt check ",amt)
                        }
                        
                        
                        
                    } else {
                        self.total_amt_txt.setText(text: "")
                    }
                    
                }
            }
            catch {

            }
            
        }
        
        
        ExpHeadDropDown.layer.borderWidth = CGFloat(2.0)
        ExpHeadDropDown.layer.cornerRadius = 8
        ExpHeadDropDown.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        ExpHeadDropDown.headerTextColor = AppColorClass.colorPrimaryDark!
        ExpHeadDropDown.menuTextColor = AppColorClass.colorPrimaryDark!
        ExpHeadDropDown.selectedMenuTextColor = AppColorClass.colorPrimaryDark!
        
        dropDownList.append(DPItem(title: "--Select--",code: "0"))
        dropDownList.append(DPItem(title: "As Per KM",code: "1"))
        dropDownList.append(DPItem(title: "Fix",code: "2"))
        
        ExpHeadDropDown.items = dropDownList
        ExpHeadDropDown.selectedIndex = 0
        ExpHeadDropDown.layer.borderColor = UIColor.white.cgColor
        
        ExpHeadDropDown.didSelectedItemIndex = { index in
            
            if self.dropDownList[index].title == "As Per KM"{
                
                self.exp_id = self.dropDownList[index].code!
                self.exp_hed = self.dropDownList[index].title
                self.perkmStackiew.isHidden = false
                self.fixStackiew.isHidden = true
                
                self.per_km_txt.setText(text: self.customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self, key: "PER_KM", defaultValue: "0"))
                
                
            } else if self.dropDownList[index].title == "Fix"{
                self.exp_id = self.dropDownList[index].code!
                self.exp_hed = self.dropDownList[index].title
                self.perkmStackiew.isHidden = true
                self.fixStackiew.isHidden = false
                
            } else {
                self.exp_id = ""
                self.exp_hed = ""
                self.perkmStackiew.isHidden = true
                self.fixStackiew.isHidden = true
                
            }
            
        }

        getAllindiaHq()
        
        // Do any additional setup after loading the view.
    }
    
    func onChackedChangeListner(sender: CheckBox, ischecked: Bool) {
        
        galleryButton.isSelected = true
        CameraButton.isSelected = true
        galleryButton.isSelected = false
        CameraButton.isSelected = false
        
        filename = ""
        AttachmentOptionStackView.isHidden = !ischecked
        AttachmentImageView.isHidden = true
        //AttachmentImageView.image = nil
        galleryButton.deselectOtherButtons()
        CameraButton.deselectOtherButtons()
        
        
    }
    
    
    func getAllindiaHq(){
        
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iLOGIN_PA_ID" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
        params["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
        params["sDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
        
        var tables = [Int]()
        tables.append(0)
        tables.append(1)
        tables.append(2)
        
        progressHUD.show(text: "Please Wait...")
        
        CboServices().customMethodForAllServices(params: params, methodName: "EXPTAMANUAL_POPULATE", tables: tables, response_code:MESSAGE_INTERNET_POPULATE, vc : self)
        
    }
    
    private func parser1(dataFromAPI : [String : NSArray]) {
        if(!dataFromAPI.isEmpty){
            do {
                
              
                let jsonArray1 =   dataFromAPI["Tables0"]!
                let jsonArray2 =   dataFromAPI["Tables2"]!
                
                taList.removeAll()
                for i in 0 ..< jsonArray1.count {
                    
                    let jsonObject1 = jsonArray1[i] as! [String : AnyObject]
                    print("data ",try jsonObject1.getString(key: "AREA"))
                    
                    taList.append(try SpinnerModel(name: jsonObject1.getString(key: "AREA"),id: "\(i)"))
                    
                }
                
                if jsonArray2.count > 0 {

                    let jsonObject1 = jsonArray2[0] as! [String : AnyObject]
                    fromtext.text = try jsonObject1.getString(key: "FROM_STATION")
                    totext.text = try jsonObject1.getString(key: "TO_STATION")
                    
                    if try jsonObject1.getString(key: "EXP_TYPE") == "As Per KM"{
                        
                        self.perkmStackiew.isHidden = false
                        self.fixStackiew.isHidden = true
                        
                        self.exp_id = self.dropDownList[1].code!
                        self.exp_hed = self.dropDownList[1].title
                         ExpHeadDropDown.headerTitle = self.dropDownList[1].title
                        
                        self.per_km_txt.setText(text: try jsonObject1.getString(key: "FARE"))
                        self.km_txt.setText(text: try jsonObject1.getString(key: "KM"))
                        self.total_amt_txt.setText(text: try jsonObject1.getString(key: "AMOUNT"))
                        self.remark_txt.setText(text: try jsonObject1.getString(key: "REMARK"))
                        
                    } else if try jsonObject1.getString(key: "EXP_TYPE") == "Fix"{
                        
                        self.perkmStackiew.isHidden = true
                        self.fixStackiew.isHidden = false
                        
                        self.exp_id = self.dropDownList[2].code!
                        self.exp_hed = self.dropDownList[2].title
                        ExpHeadDropDown.headerTitle = self.dropDownList[2].title
                        
                        self.fix_amt.setText(text: try jsonObject1.getString(key: "AMOUNT"))
                        self.fix_remark.setText(text: try jsonObject1.getString(key: "REMARK"))
                        
                        checkBox.setChecked(checked: true)
                        AttachmentOptionStackView.isHidden = true
                        AttachmentImageView.isHidden = false
                       // AttachmentImageView.image = UIImage(contentsOfFile: getPath().appending("/\(try jsonObject1.getString(key: "FILE_NAME"))"))
                        
                        let url = URL(string: try jsonObject1.getString(key: "FILE_NAME"))
                        let data = try? Data(contentsOf: url!)

                        if let imageData = data {
                            AttachmentImageView.image = UIImage(data: imageData)
                        }
                        
                        filename = try jsonObject1.getString(key: "FILE_NAME")
                        serverfilname = try jsonObject1.getString(key: "FILE_NAME")
                    }

                }
                
                
            }catch{
                customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription);
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
                
                objBroadcastErrorMail.requestAuthorization()
            }
        }
    }
    
    func getPath() -> String{
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let filePath = documentDirectory.appending("/CBO/")
        return filePath
    }
   
    
    @objc func pressedBack(){
           Custom_Variables_And_Method.closeCurrentPage(vc: self);
    }
    
    @objc func addTA(){
           
        if (fromtext.text == ("--Select--")) {
            customVariablesAndMethod1.msgBox(vc: self,msg: "Please Select the From Area...");
        } else if (totext.text == ("--Select--")) {
            customVariablesAndMethod1.msgBox(vc: self,msg: "Please Select the To Area...");
        } else if (totext.text == fromtext.text) {
            customVariablesAndMethod1.msgBox(vc: self,msg: "Please Select different Area...");
        } else if (exp_hed == ("")) {
            customVariablesAndMethod1.msgBox(vc: self,msg: "Please Select the Expense Type...");
        } else {
            
            if (exp_hed == ("As Per KM")) {
            
                if km_txt.getText().isEmpty {
                    customVariablesAndMethod1.msgBox(vc: self,msg: "Please enter KM");
                } else {
                    submitTA()
                }
            } else if (exp_hed == ("Fix")) {
            
                if fix_amt.getText().isEmpty {
                    customVariablesAndMethod1.msgBox(vc: self,msg: "Please enter Amount");
                } else  if (filename == "" ){
                    
                    customVariablesAndMethod1.msgBox(vc: self,msg: "Please add an attachment...");
                    
                } else  if (checkBox.isChecked() == false ){
                    
                    customVariablesAndMethod1.msgBox(vc: self,msg: "Please add an attachment...");
                    
                } else {
                    
                    if (filename != "" ){
                            
                        if serverfilname != filename {
                            objImagePicker.saveImageDocumentDirectory(fileName: filename, image: AttachmentImageView.image!, FOLDER_NAME: objImagePicker.albumName)
                            
                            
                              //                  AttachmentImageView.image! = objImagePicker.getPhotoFromCustomAlbum()
                            
                            let ftpUpload = Up_Down_Ftp()

                            ftpUpload.UploadDelegate = self
                                //2
                            progressHUD = ProgressHUD(vc: self)
                            if !(UIImage(contentsOfFile: objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: filename))!.convertImageToUploadableData().isEmpty){
                                                        
                                print(objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: filename))
                                // set Image name
                                ftpUpload.uploadFile(data: (AttachmentImageView.image?.convertImageToUploadableData())!, fileName: filename)

                            }
                            else {
                                // show alert
                            }
                            
                        } else {
                            submitTA()
                        }
                            
                          
                    }
                    
                    
                }
                
            }
            
           // Custom_Variables_And_Method.closeCurrentPage(vc: self);
        }
        
    }
    
    @IBAction func selectTAfrom(_ sender: UIButton) {
        areatype = "from"
        taDatafrom()
    }
    
    @IBAction func selectTAto(_ sender: UIButton) {
        areatype = "to"
        taDatafrom()
    }
    
    func taDatafrom(){
        
        if areatype == "from" {
            Call_Dialog(vc: self, title: "Select From Area....", dr_List: taList, callTyp: "1" == "1" ? "M": "D", responseCode: CALL_DILOG).show()
        } else {
            Call_Dialog(vc: self, title: "Select TO Area....", dr_List: taList, callTyp: "1" == "1" ? "M": "D", responseCode: CALL_DILOG).show()
        }
        
        
    }
    
    
    func submitTA(){
        
        progressHUD.show(text: "Please Wait...")
        
        var params = [String : String]()
        params["sCompanyFolder"] = cbohelp.getCompanyCode()
        params["iLOGIN_PA_ID"]  =  "\(Custom_Variables_And_Method.PA_ID)"
        params["sDCR_ID"] = "\(Custom_Variables_And_Method.DCR_ID)"
        
        params["sFROM_STATION"] = fromtext.text
        params["sTO_STATION"] = totext.text
        params["sEXP_TYPE"] = exp_hed
        
        if (exp_hed == ("As Per KM")) {
            params["iFARE"] = per_km_txt.getText()
            params["iKM"] = km_txt.getText()
            params["iAMOUNT"] = total_amt_txt.text
            params["sREMARK"] = remark_txt.text
            params["sFILE_NAME"] = ""
        } else {
            params["iFARE"] = "0"
            params["iKM"] = "0"
            params["iAMOUNT"] = fix_amt.text
            params["sREMARK"] = fix_remark.text
            params["sFILE_NAME"] = filename.replacingOccurrences(of: "http://test.cboinfotech.co.in/Upload/", with: "")
        }
        
        var tables = [Int]()
        tables.append(0)
        
        CboServices().customMethodForAllServices(params: params, methodName: "EXPTAMANUAL_COMMIT", tables: tables, response_code:MESSAGE_INTERNET_COMMIT, vc : self)
        
    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        
        switch response_code {
        case CALL_DILOG:
            
            let data = dataFromAPI["data"]!
                       let inderData = data[0] as! Dictionary<String , String>
            
            print(taList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0])
            
            if areatype == "from" {
                fromtext.text = taList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0]
            } else if areatype == "to" {
                totext.text = taList[Int(inderData["Selected_Index"]!)!].getName().components(separatedBy: "-")[0]
            }
            
            break
            
        case MESSAGE_INTERNET_POPULATE:
            
            progressHUD.dismiss()
            
            parser1(dataFromAPI : dataFromAPI);
            break
            
        case MESSAGE_INTERNET_COMMIT:
            
            if (exp_hed == ("As Per KM")) {
            
               customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self,key: "ACTUALFARE",value: total_amt_txt.getText());
                
            } else if (exp_hed == ("Fix")) {
                
                customVariablesAndMethod.setDataInTo_FMCG_PREFRENCE(vc: self,key: "ACTUALFARE",value: fix_amt.getText());
               
            }
            
            print("commit ",dataFromAPI)
            progressHUD.dismiss()
            parser2(dataFromAPI : dataFromAPI);
            
                       
            
            
            break
            
          default:
                print("Error")
                
          }
        
        
    }
    
    
    
    func parser2(dataFromAPI: [String : NSArray]) {
        if(!dataFromAPI.isEmpty){
            do {
            
                let jsonArray1 =   dataFromAPI["Tables0"]!
                
                    
                    for i in 0 ..< jsonArray1.count {
                                       
                        let jsonObject1 = jsonArray1[i] as! [String : AnyObject]
                        print("data ",try jsonObject1.getString(key: "STATUS"))
                                       
                        
                        if try jsonObject1.getString(key: "STATUS") == "OK" {
                            self.dismiss(animated: true, completion: nil)
                                           
                            var ReplyMsg = [String : String]()
                            ReplyMsg["result"]  = "ok"
                                           
                            vc.getDataFromApi(response_code: responseCode, dataFromAPI: ["data" : [ReplyMsg]])
                        } else {
                            customVariablesAndMethod1.msgBox(vc: self,msg: try jsonObject1.getString(key: "STATUS"));
                            
                        }
                                       
                    }
                   
               
            } catch {
                        
                customVariablesAndMethod1.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription);
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                        
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
                        
                objBroadcastErrorMail.requestAuthorization()
            }
        }
            
    }
            
    
    
    func upload_complete(IsCompleted: String) {
        
        
        switch IsCompleted {
            
        case "S":
            progressHUD.show(text: "Please Wait...\nUploading Image")
            break
            
        case "Y":
            progressHUD.dismiss()
            //customVariablesAndMethod.msgBox(vc: self, msg: "Photo Upload Completed")
             submitTA()
            break
        case "530":
            progressHUD.dismiss()
            customVariablesAndMethod.msgBox(vc: self, msg: "No Details found for upload\nPlease Download Data From Utilities Page....")
            break
        case "50":
            progressHUD.dismiss()
            break
            
        default:
            progressHUD.dismiss()
            customVariablesAndMethod.msgBox(vc: self,msg:"UPLOAD FAILED \n Please try again")
        }
        
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

extension TAmannualExpense : ImagePickerDelegate{
    
    func getImage(image: UIImage) {
        
        AttachmentOptionStackView.isHidden =  true
        AttachmentImageView.isHidden = false
        
        AttachmentImageView.image = image
        
        // filename
        filename = "\(Custom_Variables_And_Method.PA_ID)_\(Custom_Variables_And_Method.DCR_ID)_\(exp_id)_\(customVariablesAndMethod.get_currentTimeStamp().replacingOccurrences(of: ".", with: "_")).jpg"
    }
    

    
    @objc func openCamera(){
        objImagePicker = ImagePicker(imagePickerController: imagePickerController, vc: self , source : ImagePicker.camera)
        imagePickerController.delegate = objImagePicker
        objImagePicker.delegate = self
        objImagePicker.createFolderinApplicationDirectory(FOLDER_NAME: objImagePicker.albumName)
       //        objImagePicker.FetchCustomAlbumPhotos()
    }
           
    @objc func openGallery(){
        objImagePicker = ImagePicker(imagePickerController: imagePickerController, vc: self , source : ImagePicker.gallery)
        imagePickerController.delegate = objImagePicker
        objImagePicker.delegate = self
        
        objImagePicker.createFolderinApplicationDirectory(FOLDER_NAME: objImagePicker.albumName)
    }

}
