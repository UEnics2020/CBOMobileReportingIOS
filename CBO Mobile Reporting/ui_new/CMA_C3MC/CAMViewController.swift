//
//  CAMViewController.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 25/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

class CAMViewController: CustomUIViewController, FTPUploadDelegate {
    func upload_complete(IsCompleted: String) {
        switch IsCompleted {
            
        case "S":
            progressHUD.show(text: "Please Wait...\nUploading Image")
            break
            
        case "Y":
            progressHUD.dismiss()
            submit()
            // expense_commit()
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
    
    
    func submit(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let date = dateFormatter.date(from: chooseDate.getDateInString())

        dateFormatter.dateFormat = "MM-dd-yyyy"
        let goodDate = dateFormatter.string(from: date!)
        
        var request = [String:String]()
        request["sCompanyFolder"] = cbohelp.getCompanyCode()
        request["PA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
        request["DCR_ID"] = Custom_Variables_And_Method.DCR_ID
        request["MONTH"] = goodDate
        request["OWN_NAMEMMC"] = ownernmae.text
        request["MOBILE"] = mobile.text
        request["FARMER_NAME"] = farmerattendance.text
        request["MEETING_PALCE"] = address.text
        request["PRODUCT_DETAILS"] = productdetails.text
        
        request["IHSTAFF_ATTENDMMC"] = hostaff.text
        request["DIRECT_SALESFARMER"] = directsales.text
        request["ORDER_BOOKEDMMC"] = orderbook.text
        request["ID"] = "0"
        request["REMARK"] = remark.text
        request["FILE_NAME"] = filename
        request["LATLONG"] = Custom_Variables_And_Method.GLOBAL_LATLON
        request["LOC"] = ""
        
        request["sCALL_TYPE"] = docType_name
        request["iEXPENCE_AMT"] = expense.text
        request["iTOTAL_SAMPLE_QTY"] = toatalscreening.text
        request["iPOSSITIVE_SAMPLE_QTY"] = positivescreening.text
        request["iNEGATIVE_SAMPLE_QTY"] = negativescreening.text
        
        request["iITEM_ID"] = sample_id
        request["iSQTY"] = sample_pob
        request["iPOB_QTY"] = sample_sample
        request["sATTACH_1"] = attachement_file
        request["sATTACH_2"] = attachement_file
        request["iDR_GROUP_ID"] = docType_id
        
        var tables = [Int]();
        tables.append(0);
        
        progressHUD = ProgressHUD(vc: self)
        progressHUD.show(text: "Please Wait...")
        print("check ",request)
        CboServices().customMethodForAllServices(params: request, methodName: "DcrFarmerCommit_3", tables: tables, response_code: MESSAGE_INTERNET_SAVE_CMA, vc: self)
        
        
        
    }
    
    
    @IBOutlet weak var category: DPDropDownMenu!
    @IBOutlet weak var submitBtn: CustomeUIButton!
    @IBOutlet weak var productBtn: CustomeUIButton!
    @IBOutlet weak var attachmenttBtn: CustomeUIButton!
    @IBOutlet weak var clickpictureBtn: CustomeUIButton!
    @IBOutlet weak var remark: CustomTextView!
    @IBOutlet weak var chooseDate: CustomDatePicker!
    @IBOutlet weak var mobile: CustomFieldWithborader!
    @IBOutlet weak var address: CustomFieldWithborader!
    
    @IBOutlet weak var ownernmae: CustomFieldWithborader!
    @IBOutlet weak var farmerattendance: CustomFieldWithborader!
    @IBOutlet weak var hostaff: CustomFieldWithborader!
    @IBOutlet weak var directsales: CustomFieldWithborader!
    @IBOutlet weak var orderbook: CustomFieldWithborader!
    
    @IBOutlet weak var productdetails: CustomFieldWithborader!
    @IBOutlet weak var expense: CustomFieldWithborader!
    @IBOutlet weak var toatalscreening: CustomFieldWithborader!
    @IBOutlet weak var positivescreening: CustomFieldWithborader!
    @IBOutlet weak var negativescreening: CustomFieldWithborader!
    
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var uploadimageView: UIImageView!
    @IBOutlet weak var ProductView: UIView!
    
    @IBOutlet weak var attachmentview: UIStackView!
    @IBOutlet weak var attachmentimage: UIImageView!
    
    @IBOutlet weak var categoryview: UIStackView!
    @IBOutlet weak var addproductdetailsview: UIStackView!
    @IBOutlet weak var addattachmentview: UIStackView!
    
    @IBOutlet weak var ownerview: UIStackView!
    @IBOutlet weak var mobview: UIStackView!
    @IBOutlet weak var farmerview: UIStackView!
    @IBOutlet weak var addressview: UIStackView!
    @IBOutlet weak var hostaffview: UIStackView!
    @IBOutlet weak var directsalesview: UIStackView!
    @IBOutlet weak var orderview: UIStackView!
    
    @IBOutlet weak var productview: UIStackView!
    @IBOutlet weak var expenseview: UIStackView!
    @IBOutlet weak var totalscreenview: UIStackView!
    @IBOutlet weak var positiveview: UIStackView!
    @IBOutlet weak var negativeview: UIStackView!
    
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    let  PRODUCT_DILOG = 5, REQUEST_ATTACHMENT = 6, MESSAGE_INTERNET_CAMPDRGROUPDDL = 7;
    
    var dropDownList =  [DPItem]()
    var docList = [SpinnerModel]();
    
    var imagePickerController = UIImagePickerController()
    var objImagePicker : ImagePicker!
    var imagePicker = UIImagePickerController()
    var filename = "", attachement_file = ""
    var docType_name = "" , docType_id = ""
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var progressHUD : ProgressHUD!
    
    var sample_name = "",sample_pob = "",sample_sample = "",sample_noc = "",sample_id = "";
    var sample_name_previous="",sample_pob_previous="",sample_sample_previous="";
    var doctor_list = [String : [String]]()
    var dr_id = ""
    var name = "", name2 = "", MyDoctor = "",resultList="";
    var result = 0.0
    var image_type = ""
    
    var ExtraFieldYN:String  = "",RETAILERCHAINYN:String = "";
    
    var MESSAGE_INTERNET_SAVE_CMA = 2
   

    override func viewDidLoad() {
        super.viewDidLoad()

        attachmentview.isHidden = true
        chooseDate.setVC(vc: self)
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        progressHUD  =  ProgressHUD(vc : self)
        
        chooseDate.headerTitle = customVariablesAndMethod1.currentDate(dateFormat: CustomDatePicker.ShowFormat)
        
        mobile.setKeyBoardType(keyBoardType: .numberPad)
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        clickpictureBtn.addTarget(self, action: #selector(clickpicture), for: .touchUpInside )
        productBtn.addTarget(self, action: #selector(getProduct), for: .touchUpInside )
        attachmenttBtn.addTarget(self, action: #selector(attachment), for: .touchUpInside )
        submitBtn.addTarget(self, action: #selector(submitData), for: .touchUpInside )
  
        /*category.layer.borderWidth = CGFloat(2.0)
        category.layer.cornerRadius = 8
        category.layer.borderColor = AppColorClass.colorPrimaryDark?.cgColor
        category.headerTextColor = AppColorClass.colorPrimaryDark!
        category.menuTextColor = AppColorClass.colorPrimaryDark!
        category.selectedMenuTextColor = AppColorClass.colorPrimaryDark!*/
        
        
        dropDownList = [DPItem(title: "CMA", code: "0")]
        dropDownList = [DPItem(title: "C3MC", code: "0")]
        category.items = dropDownList
        category.selectedIndex = 0
        //category.layer.borderColor = UIColor.white.cgColor
        
        //OnClickChemLoad()
        
        category.didSelectedItemIndex = { index in
            
            self.docType_id = self.dropDownList[index].code!
            self.docType_name = self.dropDownList[index].title
            
        }
        
        
        ExtraFieldYN = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "FARMERADDFIELDYN", defaultValue: "N");
        
        RETAILERCHAINYN = customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(vc: self,key: "RETAILERCHAINYN", defaultValue: "N");
        
        
        
        if ExtraFieldYN == "N" {
            expenseview.isHidden = true
            totalscreenview.isHidden = true
            positiveview.isHidden = true
            negativeview.isHidden = true
            
            categoryview.isHidden = true //category
            
            addproductdetailsview.isHidden = true // product details
            addattachmentview.isHidden = true // attachment
            attachmentview.isHidden = true // attacment image
            
        } else {
            productview.isHidden = true
        }
        
        if RETAILERCHAINYN == "Y" {
            
            farmerview.isHidden = true
            ownerview.isHidden = true
            
            productview.isHidden = true
            hostaffview.isHidden = true
            directsalesview.isHidden = true
            orderview.isHidden = true
            expenseview.isHidden = true
            totalscreenview.isHidden = true
            positiveview.isHidden = true
            negativeview.isHidden = true
            
            getCat()
            
        }
        
        /*if VCIntent["dr_id"] != nil{
            dr_id = VCIntent["dr_id"]!
        }*/
        
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]!)
            
            //showProductGift(IsDrSelected: true)
        }
        // Do any additional setup after loading the view.
    }
    
    func getCat() {
        //Start of call to service
        
        
        var params = [String : String]()
        params["sCompanyFolder"] = self.cbohelp.getCompanyCode()
        params["iPA_ID" ]  =  "\(Custom_Variables_And_Method.PA_ID)"
        var tables = [Int]()
        tables.append(0)

        
        progressHUD.show(text: "Please Wait..." )
       // new CboServices(context, mHandler).customMethodForAllServices(request, "CAMPDRGROUPDDL", MESSAGE_INTERNET_CAMPDRGROUPDDL, tables);
        
        CboServices().customMethodForAllServices(params: params, methodName: "CAMPDRGROUPDDL", tables: tables, response_code: self.MESSAGE_INTERNET_CAMPDRGROUPDDL, vc : self)

        //End of call to service
    }
    
    @objc func pressedBack(){
         
        myTopView.CloseCurruntVC(vc: self)
           
    }
    
    
    func OnClickChemLoad(){
        do{
            let statement = try cbohelp.getChemistListLocal();
            // chemist.add(new SpinnerModel("--Select--",""));
            let db = cbohelp
            docList.removeAll()
            while let c = statement.next() {
                docList.append(
                    
                    try SpinnerModel(name: c[db.getColumnIndex(statement: statement, Coloumn_Name: "chem_name")]! as! String,
                                     id: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "chem_id")]!)",
                                     last_visited: c[db.getColumnIndex(statement: statement, Coloumn_Name: "LAST_VISIT_DATE")]! as! String,
                                     DR_LAT_LONG: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG")]! as! String,
                                     DR_LAT_LONG2: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG2")]! as! String,
                                     DR_LAT_LONG3: c[db.getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG3")]! as! String,
                                     CALLYN: "\(c[db.getColumnIndex(statement: statement, Coloumn_Name: "CALLYN")]!)"
                    )
                );
                
            }
            
            
            
            
        }catch {
            print(error)
        }
    }
    
    
    @objc func getProduct(){
         
       //Custom_Variables_And_Method.DR_ID = "8532"
      // dr_sample_Dialog(vc: self, responseCode: PRODUCT_DILOG, sample_name: sample_name, sample_pob: sample_pob, sample_sample: sample_sample,sample_noc: sample_noc).setPrevious(sample_name_previous: sample_name_previous, sample_pob_previous: sample_pob_previous, sample_sample_previous: sample_sample_previous).show()
        
    Chm_sample_Dialog(vc: self, dr_List: docList, responseCode: PRODUCT_DILOG, sample_name: sample_name, sample_pob: sample_pob, sample_sample: sample_sample).setPrevious(sample_name_previous: sample_name_previous, sample_pob_previous: sample_pob_previous, sample_sample_previous: sample_sample_previous).show()
           
    }
    
    @objc func attachment(){
        
        image_type = "attachement"
        selectPhoto()
    }
    
    @objc func clickpicture(){
        
        image_type = "picture"
        selectPhoto()
    }
    
    @objc func selectPhoto(){
        
        var alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            alertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
        }

        let defaultAction = UIAlertAction(title: "Camera", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.openCamera()
        })
        
        let deleteAction = UIAlertAction(title: "Gallary", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.openGallery()
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
          //  Do something here upon cancellation.
        })

        alertController.addAction(defaultAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)

         
        /*let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
         {
            UIAlertAction in
            
         }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
         {
            UIAlertAction in
            
         }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
         {
            UIAlertAction in
         }

        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)*/
           
    }
    
    @objc func submitData(){
        
        print("chooseDate.getDate() ",chooseDate.getDateInString())
        print("attachement ", attachement_file)
        
        let string_date = chooseDate.getDateInString()
        let string_owner_name = ownernmae.text!
        let string_owner_mob = mobile.text!
        let string_farmer_attendence = farmerattendance.text!
        let string_group_meeting_place = address.text!
        let string_product_detail = productdetails.text!
        let string_IH_attendence_mcc = hostaff.text!
        let string_directr_sale_to_farmer = directsales.text!
        let string_order_book_for_mcc = orderbook.text!
        let fRemark = remark.text
        
        
        if RETAILERCHAINYN == "N" {
            
            if (string_date == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "please Input Date");
            } else if (string_owner_name == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Owner name");
            } else if (string_owner_mob == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Mobile number");
            } else if (string_farmer_attendence == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Farmer attendence ");
            } else if (string_group_meeting_place == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Group meeting place");
            } else if (string_product_detail == "" && productview.isHidden == false) {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Product details");
            } else if (sample_id == "" && productview.isHidden == false) {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Product details");
            } else if (string_IH_attendence_mcc == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter HO staff attendence");
            } else if (string_directr_sale_to_farmer == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Farmer sale");
            } else if (string_order_book_for_mcc == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Order book for MCC ");
            }
            
            else if (ExtraFieldYN == "Y" && expenseview.isHidden == false && expense.text == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Exp. Amt.");
            } else if (ExtraFieldYN == "Y" && docType_name == "C3MC" && toatalscreening.text == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Total Screening");
            } else if (ExtraFieldYN == "Y" && docType_name == "C3MC" && positivescreening.text == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter No. Of Positive Screenig ");
            } else if (ExtraFieldYN == "Y" && docType_name == "C3MC" && negativescreening.text == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter No. Of Negative Screenig ");
            } else if (filename == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please Capture Picture First then Submit ");
            } else if (ExtraFieldYN == "Y" && attachement_file == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please Add attachment.....");
            } else if (fRemark.isEmpty) {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please Enter Remark.... ");
            } else {
              
                objImagePicker.saveImageDocumentDirectory(fileName: filename, image: uploadimageView.image!, FOLDER_NAME: objImagePicker.albumName)
                
                objImagePicker.saveImageDocumentDirectory(fileName: attachement_file, image: attachmentimage.image!, FOLDER_NAME: objImagePicker.albumName)
                
                let ftpUpload = Up_Down_Ftp()

                ftpUpload.UploadDelegate = self
                progressHUD = ProgressHUD(vc: self)
                
                if !(UIImage(contentsOfFile: objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: attachement_file))!.convertImageToUploadableData().isEmpty){
                    
                    print(objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: filename))
                    
                    //print(objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: attachement_file))
                    
                    var datas = Data()
                    datas.append((uploadimageView.image?.convertImageToUploadableData())!)
                    //datas.append((attachmentimage.image?.convertImageToUploadableData())!)
                    
                     ftpUpload.uploadFile(data: datas, fileName: filename)
                    
                    //ftpUpload.uploadFile(data: (attachmentimage.image?.convertImageToUploadableData())!, fileName: attachement_file)
                    
                   
                }
                

            }
            
        } else {
            
            
            if (string_date == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "please Input Date");
            } else if (string_owner_mob == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Mobile number");
            } else if (string_group_meeting_place == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Address");
            } else if (sample_id == "" && productview.isHidden == false) {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please enter Product details");
            } else if (filename == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please Capture Picture First then Submmit ");
            } else if (attachement_file == "") {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please Add attachment.....");
            } else if (fRemark.isEmpty) {
                customVariablesAndMethod.msgBox(vc: self, msg: "Please Enter Remark.... ");
            } else {
                         
                objImagePicker.saveImageDocumentDirectory(fileName: filename, image: uploadimageView.image!, FOLDER_NAME: objImagePicker.albumName)
                                          
                objImagePicker.saveImageDocumentDirectory(fileName: attachement_file, image: attachmentimage.image!, FOLDER_NAME: objImagePicker.albumName)
                                        
                let ftpUpload = Up_Down_Ftp()

                ftpUpload.UploadDelegate = self
                progressHUD = ProgressHUD(vc: self)
                                          
                if !(UIImage(contentsOfFile: objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: attachement_file))!.convertImageToUploadableData().isEmpty){
                            
                    print(objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: filename))
                                              
                    //print(objImagePicker.getImageFromApplicationFolder(FOLDER_NAME: objImagePicker.albumName, filename: attachement_file))
                                              
                     ftpUpload.uploadFile(data: (uploadimageView.image?.convertImageToUploadableData())!, fileName: filename)
                                              
                    //ftpUpload.uploadFile(data: (attachmentimage.image?.convertImageToUploadableData())!, fileName: attachement_file)
                                              
                                             
                }
                           

            }
            
            
        }
        
        
       
        
        
        
    }
    
    func showProductGift(IsDrSelected : Bool){
        
        // for summery use getCallDetails
        doctor_list=cbohelp.getCallDetail(table: "tempdr",look_for_id: Custom_Variables_And_Method.DR_ID,show_edit_delete: "0");
        
        if (doctor_list["sample_name"]![0] != "") {
            
            sample_name = doctor_list["sample_name"]![0]
            sample_sample = doctor_list["sample_qty"]![0]
            sample_pob = doctor_list["sample_pob"]![0]
            sample_noc = doctor_list["sample_noc"]![0]
            
            let sample_name1 = sample_name.components(separatedBy: ",");
            let sample_qty1 = sample_sample.components(separatedBy: ",");
            let sample_pob1 = sample_pob.components(separatedBy: ",");
            let sample_noc1 = sample_noc.components(separatedBy: ",");
            
            ShowDrSampleProduct(sample_name: sample_name1, sample_qty: sample_qty1, sample_pob: sample_pob1);
       
        } else {
            
            sample_name = ""
            sample_sample = ""
            sample_pob = ""
            sample_noc = ""
            RemoveAllviewsinProduct(myStackView: ProductView)
            
        }
       
        sample_name_previous=sample_name;
        sample_pob_previous=sample_pob;
        sample_sample_previous=sample_sample;
        
    }
    
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
            switch response_code {
                
            case PRODUCT_DILOG :
                
               let data = dataFromAPI["data"]!
               let inderData = data[0] as! Dictionary<String , String>
               name = inderData["val"]!   //id
               name2 = inderData["val2"]!   //qty pob
               result = Double(inderData["resultpob"]!)! //pob value
               let sample = inderData["sampleQty"]!
                
               resultList = inderData["resultList"]!
                
               //showProductGift(IsDrSelected: false)
               sample_id = name
               sample_name=resultList;
               sample_sample=sample;
               sample_pob=name2;
               
               let sample_name1 = resultList.components(separatedBy: ",");
               let sample_qty1 = sample.components(separatedBy: ",");
               let sample_pob1 = name2.components(separatedBy: ",");
               
               ShowDrSampleProduct(sample_name: sample_name1, sample_qty: sample_qty1, sample_pob: sample_pob1);
                break
                
            case MESSAGE_INTERNET_SAVE_CMA:
                progressHUD.dismiss()
                
                cbohelp.Save(date: chooseDate.getDateInString(), owner_name: ownernmae.text!, owner_no: mobile.text!, farmer_attendence: farmerattendance.text!, group_meeting_place: address.text!, product_detail: productdetails.text!, IH_staff_attendence: hostaff.text!, farmer_sale: directsales.text!, order_book: orderbook.text!, mRemark: remark.text)
                
                //customVariablesAndMethod.msgBox(context,"Registration Successfully ....");
                self.dismiss(animated: true, completion: nil)
                
                break
                
            case REQUEST_ATTACHMENT:
                
                break
                
            case MESSAGE_INTERNET_CAMPDRGROUPDDL:
                progressHUD.dismiss()
                parser(dataFromAPI: dataFromAPI)
                break
                
            case 99:
                customVariablesAndMethod.getAlert(vc: self, title: "Error", msg: (dataFromAPI["Error"]![0] as! String))
                break
            default:
                print("Error")
                
            }
        
    }
    
    
    
    
    func parser(dataFromAPI : [String : NSArray]) {
        
        if(!dataFromAPI.isEmpty){
            do {
                
                dropDownList.removeAll()
                cbohelp.delete_EXP_Head();
                
                let jsonArray1 =   dataFromAPI["Tables0"]!
                
                for i in 0 ..< jsonArray1.count {
                    
                    let jsonObject1 = jsonArray1[i] as! [String : AnyObject]
                    
                    try dropDownList.append( DPItem(title: jsonObject1.getString(key: "PA_NAME") , code: jsonObject1.getString(key: "PA_ID")));
                    
                    category.items = dropDownList
                    
                }
                if (dropDownList.count == 0) {
                    customVariablesAndMethod.msgBox(vc: self,msg: "No ExpHead found...");
                }
                
               
            }catch{
                customVariablesAndMethod.getAlert(vc: self, title: "Missing field error", msg: error.localizedDescription)
                
                let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                
                let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: self)
                
                objBroadcastErrorMail.requestAuthorization()
            }
        }
        progressHUD.dismiss()
        
    }
    
    func RemoveAllviewsinProduct(myStackView : UIView){
        while( myStackView.subviews.count > 0 ) {
            myStackView.subviews[0].removeFromSuperview()
        }
    }
    
    
    
    
    func ShowDrSampleProduct( sample_name : [String],  sample_qty : [String], sample_pob : [String]){

        let myStackView = ProductView!
        RemoveAllviewsinProduct(myStackView: myStackView)

        var heightConstraint : NSLayoutConstraint!
        // var stackViewHeightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!

        var previousStackView : UIStackView!


        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myStackView.addSubview(myLabel)
        myLabel.text =  "Product"
        myLabel.numberOfLines = 0
        myLabel.font = myLabel.font.withSize(13)
        myLabel.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel.textColor = .white


        let myLabel2 = UILabel()
        myStackView.addSubview(myLabel2)
        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        myLabel2.numberOfLines = 0
        myLabel2.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel2.font = myLabel2.font.withSize(13)
        myLabel2.textAlignment = .center
        myLabel2.textColor = .white
        myLabel2.text =  "Sample"

        let myLabel3 = UILabel()
        myStackView.addSubview(myLabel3)
        myLabel3.translatesAutoresizingMaskIntoConstraints = false
        myLabel3.numberOfLines = 0
        myLabel3.backgroundColor = AppColorClass.colorPrimaryDark
        myLabel3.font = myLabel3.font.withSize(13)

        myLabel3.textAlignment = .center
        myLabel3.textColor = .white
        myLabel3.text =  "POB"

        let myinnerStackView = UIStackView()
        myinnerStackView.axis =  .horizontal
        myStackView.addSubview(myinnerStackView)
        myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false




        myLabel3.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel3.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor).isActive =  true
        myLabel3.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true

        myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel2.rightAnchor.constraint(equalTo: myLabel3.leftAnchor ).isActive =  true
        myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true

        myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
        myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
        myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
        myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true



        //if i == 0{

        myinnerStackView.topAnchor.constraint(equalTo: myStackView.topAnchor).isActive = true
        myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
        myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true

        //        }else{
        //
        //            myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
        //            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
        //            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
        //
        //        }


        heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
        heightConstraint.isActive =  true


        widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
        widthConstraint.isActive =  true

        heightConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
        heightConstraint.isActive =  true


        widthConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
        widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
        widthConstraint.isActive =  true

        previousStackView = myinnerStackView

        for i in 0 ..< sample_name.count{

            let myLabel = UILabel()
            myLabel.translatesAutoresizingMaskIntoConstraints = false
            myStackView.addSubview(myLabel)
            myLabel.text =  sample_name[i]
            myLabel.numberOfLines = 0
            myLabel.textColor = AppColorClass.colorPrimaryDark
            //myLabel.backgroundColor = .gray


            let myLabel2 = UILabel()
            myStackView.addSubview(myLabel2)
            myLabel2.translatesAutoresizingMaskIntoConstraints = false
            myLabel2.numberOfLines = 0
            //myLabel2.backgroundColor = .lightGray
            myLabel2.textAlignment = .center
            myLabel2.textColor = AppColorClass.colorPrimaryDark
            myLabel2.text =  sample_qty[i]

            let myLabel3 = UILabel()
            myStackView.addSubview(myLabel3)
            myLabel3.translatesAutoresizingMaskIntoConstraints = false
            myLabel3.numberOfLines = 0
            //myLabel3.backgroundColor = .red
            myLabel3.textAlignment = .center
            myLabel3.textColor = AppColorClass.colorPrimaryDark
            myLabel3.text =  sample_pob[i]

            let myinnerStackView = UIStackView()
            myinnerStackView.axis =  .horizontal
            myStackView.addSubview(myinnerStackView)
            myinnerStackView.translatesAutoresizingMaskIntoConstraints =  false




            myLabel3.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel3.rightAnchor.constraint(equalTo: myinnerStackView.rightAnchor).isActive =  true
            myLabel3.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true

            myLabel2.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel2.rightAnchor.constraint(equalTo: myLabel3.leftAnchor ).isActive =  true
            myLabel2.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true

            myLabel.topAnchor.constraint(equalTo: myinnerStackView.topAnchor).isActive =  true
            myLabel.rightAnchor.constraint(equalTo: myLabel2.leftAnchor ).isActive =  true
            myLabel.leftAnchor.constraint(equalTo: myinnerStackView.leftAnchor).isActive =  true
            myLabel.bottomAnchor.constraint(equalTo: myinnerStackView.bottomAnchor).isActive = true



            //            if i == 0{
            //
            //                myinnerStackView.topAnchor.constraint(equalTo: myStackView.topAnchor).isActive = true
            //                myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
            //                myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true
            //
            //            }else{

            myinnerStackView.topAnchor.constraint(equalTo: previousStackView.bottomAnchor).isActive = true
            myinnerStackView.leftAnchor.constraint(equalTo: myStackView.leftAnchor).isActive = true
            myinnerStackView .rightAnchor.constraint(equalTo: myStackView.rightAnchor).isActive =  true

            //}


            heightConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true


            widthConstraint = NSLayoutConstraint(item: myLabel2, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
            widthConstraint.isActive =  true

            heightConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            heightConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(250)))
            heightConstraint.isActive =  true


            widthConstraint = NSLayoutConstraint(item: myLabel3, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 50)
            widthConstraint.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(CGFloat(1000)))
            widthConstraint.isActive =  true

            previousStackView = myinnerStackView


        }


        previousStackView.bottomAnchor.constraint(equalTo: myStackView.bottomAnchor).isActive =  true



    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupUI(value : Bool){
           
           clickpictureBtn.isHidden = value
    }

}

extension CAMViewController : ImagePickerDelegate{
    
    func getImage(image: UIImage) {
        
        if image_type == "attachement" {
            
            attachmentview.isHidden = false
            attachmentimage.image = image
            
            attachement_file = "\(Custom_Variables_And_Method.PA_ID)_\(Custom_Variables_And_Method.DCR_ID)_Farmer_\(customVariablesAndMethod.get_currentTimeStamp().replacingOccurrences(of: ".", with: "_")).jpg"
            
        } else {
            
            setupUI(value: true)
            uploadimageView.image = image
            filename = "\(Custom_Variables_And_Method.PA_ID)_\(Custom_Variables_And_Method.DCR_ID)_Farmer_\(customVariablesAndMethod.get_currentTimeStamp().replacingOccurrences(of: ".", with: "_")).jpg"
        
        }
        
        
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
