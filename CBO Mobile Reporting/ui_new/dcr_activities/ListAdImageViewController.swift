//
//  ListAdImageViewController.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 10/12/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

class ListAdImageViewController: CustomUIViewController  , UIScrollViewDelegate , UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var play: UIButton!
    @IBOutlet weak var webpage: UIButton!
    
    var image_index = 0
    var responseCode : Int! = 0
    var vc : CustomUIViewController!
        
    @IBOutlet weak var myImageConterController: UIPageControl!
    @IBOutlet weak var collectionview: UICollectionView!
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var allControllerIsHidden : Bool = false
    var customVariablesAndMethod : Custom_Variables_And_Method!
    
    @IBOutlet weak var bottomView: UIView!
    
    var InnerIndex = 0
    var indexId = 0
    
    var imageArrayc = [String]()
    var group_item_ids = [String]()
    var group_item_names = [String]()
    var selected_group_item_ids = [String]()
    var selected_group_item_names = [String]()
    
    var tempIndex = 0
       
    var sample_id = [String]()
    var sample_name = [String]()
    var sample_id_top = [String]()
    var sample_name_top = [String]()
    
    var selected = Set<String>()
       
    var imageArraya = [[String]]()
    var InnerInmageArray = [String]()
    var imageArray = [UIImage]()
       
    var myImagesDic = [[String : [String]]]()
       
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollImg: UIScrollView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var head_title: UILabel!

    //@IBOutlet weak var saveNextButton: CustomeUIButton!
    //@IBOutlet weak var myTopView: TopViewOfApplication!
    //@IBOutlet weak var nextButton: CustomeUIButton!
    
    var selectedIndex: Int = -1
    var swipeRight = UISwipeGestureRecognizer()
    var swipeLeft = UISwipeGestureRecognizer()
    
    let cellIdentifier = "VisualAdsCell"
    
    var zipName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        
        if customVariablesAndMethod.getDataFrom_FMCG_PREFRENCE(key: "VISUALAID_SAVE_SHOW", defaultValue: "N") == "Y" {
            saveButton.isHidden = false
        } else {
            saveButton.isHidden = true
        }
        
        print(selected)
        //myTopView.view.layer.shadowRadius = 0
        //myTopView.view.layer.shadowOpacity = 0
                saveButton.backgroundColor = AppColorClass.colorPrimary
               // saveButton.setTitleColor(AppColorClass.colorPrimaryDark, for: .normal)
                saveButton.layer.cornerRadius = 5
                saveButton.layer.borderWidth = 2
                saveButton.layer.borderColor = UIColor.white.cgColor
                saveButton.clipsToBounds = false
        
                cancelButton.backgroundColor = AppColorClass.colorPrimary
                // saveButton.setTitleColor(AppColorClass.colorPrimaryDark, for: .normal)
                cancelButton.layer.cornerRadius = 5
                cancelButton.layer.borderWidth = 2
                cancelButton.layer.borderColor = UIColor.white.cgColor
                cancelButton.clipsToBounds = false
        
                
               // myTopView.backButton.setImage(nil, for: .normal)
                //cancelButton.setTitle("Cancel", for: .normal)
                
                play.addTarget(self, action: #selector(playvideo), for: .touchUpInside)
                webpage.addTarget(self, action: #selector(openweb), for: .touchUpInside)
               cancelButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
               //saveNextButton.isHidden = true
               // self.collectionview.register(UINib(nibName:"VisualAdsCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
                //self.collectionview.register(VisualAdsCell.self, forCellWithReuseIdentifier: cellIdentifier)
                collectionview.delegate = self
                collectionview.dataSource = self
                
                // swipe images
                swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
                swipeRight.direction = UISwipeGestureRecognizerDirection.right
                self.view.addGestureRecognizer(swipeRight)

                swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))

                swipeLeft.direction = UISwipeGestureRecognizerDirection.left
                self.view.addGestureRecognizer(swipeLeft)

                swipeLeft.isEnabled = true
                swipeRight.isEnabled = true
             
                // scrolling
                
                scrollImg.delegate = self
                scrollImg.alwaysBounceVertical = false
                scrollImg.alwaysBounceHorizontal = false
                scrollImg.showsVerticalScrollIndicator = true
                scrollImg.flashScrollIndicators()

                scrollImg.minimumZoomScale = 1.0
                scrollImg.maximumZoomScale = 10.0

              
                
                //nextButton.isHidden = true
                ///backButton.isHidden = true
        
        
        
               
        
                
        
        
                do{
                    
                    var  statement3 = try cbohelp.getAllVisualAddByBrand(itemidnotin: "0", SHOW_ON_TOP: "Y");
                               
                    if  statement3.next() != nil {
                        
                        statement3 = try cbohelp.getAllVisualAddByBrand(itemidnotin: "0", SHOW_ON_TOP: "Y");
                        while let c = statement3.next() {
                                       
                                sample_id_top.append(try c[cbohelp.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_ID")] as! String);
                                       
                                sample_name_top.append(try c[cbohelp.getColumnIndex(statement: statement3, Coloumn_Name: "BRAND_NAME")] as! String);
                                      
                        }
                    }
                       
                }catch{
                    print("error")
                }
                     
                
                
                if selected.count > 0{
                    
                    let id = VCIntentArray["sample_id"]! as! [String]
                    let name = VCIntentArray["sample_name"]! as! [String]
                    
                    var anotherid = [String]()
                    var anothername = [String]()
                    
                    for (index, item) in id.enumerated() {
                      
                        if selected.contains(item) {
                            
                            if !sample_id.contains(item) {
                                sample_id.append(item)
                                sample_name.append(name[index])
                            }
                            
                            
                        } else {
                            anotherid.append(item)
                            anothername.append(name[index])
                        }
                        
                    }
                    
                    for (index, item) in anotherid.enumerated() {
                        
                        sample_id.append(item)
                        sample_name.append(anothername[index])
                    }
                    
                    
                } else {
                    sample_id = VCIntentArray["sample_id"]! as! [String]
                    sample_name = VCIntentArray["sample_name"]! as! [String]
                    
                }
                
               
                //collectionview.reloadData()
                
                
//                print(sample_id[indexId] , sample_name[indexId])
//
//                let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//                let myFilesPath = documentDirectoryPath.appending("/Cbo/Product/")
//                let fileManager = FileManager.default
//
//                let files = fileManager.enumerator(atPath: myFilesPath)
//
//
//                while let file = files?.nextObject() {
//
//                    let file1 = file as! String
//                    print(file1)
//
//                    if file1.contains(".") && file1.contains(String(sample_id[indexId])){
//                        print(file1)
//                        //imageView.image = UIImage(contentsOfFile: myFilesPath.appending("\(file1)"))
//                    }
//                }
                
                
                let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
                doubleTapGest.numberOfTapsRequired = 2
                
                scrollImg.addGestureRecognizer(doubleTapGest)
                

                
                //myTopView.isHidden = false
                
                let singleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleSingleTapScrollView(recognizer:)))
                singleTapGest.numberOfTapsRequired = 1
                
                //scrollImg.addGestureRecognizer(singleTapGest)

                if indexId == 0 {
                    //backButton.isHidden = true
                } else if indexId == sample_id.count - 1{
                   // nextButton.isHidden = true
                }

        //        changeImageGroup(IndexIdVar: indexId)
                
                imageView!.layer.cornerRadius = 11.0
                imageView!.clipsToBounds = false
                imageArrayc.removeAll()
                
                bottomView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        
                let db = cbohelp
                do {
                
                    var list = try cbohelp.getListVisualByBrand();
                    
                    while let c2 = list.next(){
                        
                        print(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "downLoadVersion")] as! String)
                        zipName.append(try c2[db.getColumnIndex(statement: list, Coloumn_Name: "itemName")] as! String)
                    }
                    
                    //print("list ",list)
                    
                }catch{
                    print(error)
                }
        
            
                setImageIntroduction()
        // Do any additional setup after loading the view.
    }
    


        
        func changeImageGroup(IndexIdVar : Int){
            let innerDic = myImagesDic[indexId] as Dictionary<String , [String]>
            
            for innerArray in innerDic{
                print(innerArray.key)
                imageView.image = UIImage(contentsOfFile: getPath().appending("/\(innerArray.key)"))
                
                head_title.text = innerArray.key  //setText(title: innerArray.key )
            }
        }
        
        
        @objc func closeVC(){
            
            //myTopView.CloseCurruntVC(vc: self)
            
            let alert = UIAlertController(title: "Alert", message: "Do you want to cancel?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                  
                self.vc.dismiss(animated: true, completion: nil)
                
            }))
            
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
        func getPath() -> String{
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            
            
            let filePath = documentDirectory.appending("/Cbo/Product/")
            return filePath
        }
        
        
        @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.left:
                        nextImage()
                    print("swiperight")
                    break
                case UISwipeGestureRecognizerDirection.right:
                        previousImage()
                    
                    print("Swiped left")
                    break
                default:
                    break
                }
            }
        }
    
    
    @objc func openweb(){
           
        let documentDirectoryPath1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as! String
        //let myFilesPath1 = documentDirectoryPath1.appending("/Cbo/Product/\(group_item_ids[0])/index.html")
        
        for i in 0 ..< zipName.count{
        
            let myFilesPath1 = documentDirectoryPath1.appending("/Cbo/Product/\(group_item_ids[0])/index.html")
         
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VisualWebView") as! VisualWebView
               
               vc.fileExtention = ".html"
               vc.path = myFilesPath1
               vc.VCIntent["title"] = head_title.text
            
             if FileManager.default.fileExists(atPath: myFilesPath1){
                
                self.present(vc, animated: true, completion: nil)
             }
            
        }
        
        
           
    }

    @objc func playvideo(){
        
        openWithWebView()
        
    }
    
    func openWithWebView(){
        
        let documentDirectoryPath1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as! String
        let myFilesPath1 = documentDirectoryPath1.appending("/Cbo/Product/\(group_item_ids[0]).mp4")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VisualWebView") as! VisualWebView
           
           vc.fileExtention = ".mp4"
           vc.path = myFilesPath1
           vc.VCIntent["title"] = head_title.text
        
         if FileManager.default.fileExists(atPath: myFilesPath1){
            
            self.present(vc, animated: true, completion: nil)
         }
           
           
    }
    
        @IBAction func save(_ sender: Any) {
            
            
            if self.selected_group_item_ids.count > 0 {
                
                self.dismiss(animated: true) {
                        var ReplyMsg = [String : [String]]()
                    
                        ReplyMsg["ITEM_ID"]  = self.selected_group_item_ids
                        ReplyMsg["ITEM_NAME"]  = self.selected_group_item_names
                        self.vc.getDataFromApi(response_code: self.responseCode, dataFromAPI: ["data" : [ReplyMsg]])
                }
                
            } else {
                
                customVariablesAndMethod.msgBox(vc: self,msg: "Please Select Atleast one visual ads.");
                
            }
            
                
                
        }
    

        override func viewDidAppear(_ animated: Bool) {
         
           // nextButton.addTarget(self, action: #selector(pressedNextButton), for: .touchUpInside)

            //backButton.addTarget(self, action: #selector(pressedBackButton), for: .touchUpInside)

        }

        

        @objc func handleSingleTapScrollView(recognizer: UITapGestureRecognizer) {
           
           
            if allControllerIsHidden == true{
                
              
               // myTopView.isHidden = allControllerIsHidden
                bottomView.isHidden = allControllerIsHidden

          
               // backButton.isHidden = allControllerIsHidden
               // nextButton.isHidden =  allControllerIsHidden
               
                
                
            
                 print(allControllerIsHidden)

            } else if allControllerIsHidden == false{
                print(allControllerIsHidden)
                    // myTopView.isHidden = allControllerIsHidden
                    bottomView.isHidden = allControllerIsHidden

               
               // backButton.isHidden = (indexId  == 0)
                //nextButton.isHidden = (indexId == sample_id.count - 1 )
                
            }
        
            allControllerIsHidden = !allControllerIsHidden
            
        }
        

        @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {

                if scrollImg.zoomScale == 1 {
                    scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
                } else {
                    scrollImg.setZoomScale(1, animated: true)
            }
        }

        func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
            var zoomRect = CGRect.zero
            zoomRect.size.height = imageView.frame.size.height / scale
            zoomRect.size.width  = imageView.frame.size.width  / scale
            let newCenter = imageView.convert(center, from: scrollImg)
            zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
            zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
            return zoomRect
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return self.imageView
        }

        @objc func pressedNextButton(){
            nextGroup()
        }

        @objc func pressedBackButton(){
            previousGroup()
        }
        
    public func prepareImageArray(id : String,name : String){
            
//            if !sample_name[index].isEmpty{
//                 myTopView.setText(title: sample_name[index])
//            }
//            imageArrayc.removeAll()
            
            let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            
            
            let path = ("\(documentDirectoryPath)/Cbo/Product/\(id).jpg")
    //        print(path)
            
            let path1 =  ("\(documentDirectoryPath)/Cbo/Product/\(id)_\(Custom_Variables_And_Method.pub_doctor_spl_code!).jpg");
            //print(path1)
            
            let fileManager = FileManager.default
            
            //print(fileManager.fileExists(atPath: path))
            
            if fileManager.fileExists(atPath: path1){
                imageArrayc.append(path1)
                group_item_ids.append(id)
                group_item_names.append(name)
                bind_imageArray(id: id, name: name,path: ("\(documentDirectoryPath)/Cbo/Product/\(id)_\(Custom_Variables_And_Method.pub_doctor_spl_code)"))
            } else if  fileManager.fileExists(atPath: path){
                imageArrayc.append(path)
                group_item_ids.append(id)
                group_item_names.append(name)
                bind_imageArray(id: id, name: name,path: "\(documentDirectoryPath)/Cbo/Product/\(id)")
                
            }
            
//            else{
//                imageArrayc.append("no_image")
//            }
            
        }
        
        
     public func prepareImageArrayForGroup(GroupId : String,index : Int){
            
            if !sample_name[index].isEmpty{
                // myTopView.setText(title: sample_name[index])
                head_title.text = sample_name[index]
                //indexId = index
                
            }
            imageArrayc.removeAll()
        
            group_item_ids.removeAll()
            group_item_names.removeAll()
         
            do {
                let  statement  = try  cbohelp.getAllItemsForGroup(GroupId: GroupId);

                while let c1 = statement.next(){
                    
                    let id = "\(try c1[cbohelp.getColumnIndex(statement: statement, Coloumn_Name: "item_id")]!)"
                    let name = "\(try c1[cbohelp.getColumnIndex(statement: statement, Coloumn_Name: "item_name")]!)"
                  
                    print("id",id)
                    
                    prepareImageArray(id: id, name: name)
                    
                }
            
            }catch{
                print(error)
            }
        
            if (imageArrayc.count == 0){
                imageArrayc.append("no_image")
            }
            
        }
        
        public func bind_imageArray(id : String,name : String, path : String){
              image_index += 1
           // print(path)
            let path1 =  ("\(path)_\(image_index).jpg")
            
            let fileManager = FileManager.default
            
            if  fileManager.fileExists(atPath: path1){
                imageArrayc.append(path1)
                group_item_ids.append(id)
                group_item_names.append(name)
                bind_imageArray(id: id, name: name, path: path)
              
            } else {
                image_index = 0
            }
        }

        
        
        func setImageIntroduction(){
            
            webpage.isHidden = true
            play.isHidden = true
            
            if (sample_id_top.count == 0) {
                
                setImage()
                
            } else {
                
                var imageArrayc_top = [String]()
                
                var group_item_ids_top = [String]()
                var group_item_names_top = [String]()
                
                for i in 0..<sample_id_top.count{
                    
                    prepareImageArrayForGroup(GroupId: sample_id_top[i], index: 0)
                    
                    imageArrayc_top.append(contentsOf: imageArrayc)
                    group_item_ids_top.append(contentsOf: group_item_ids)
                    group_item_names_top.append(contentsOf: group_item_names)
                    
                }
                
                
                print(imageArrayc)
                tempIndex = 0
                myImageConterController.numberOfPages = imageArrayc.count
                myImageConterController.currentPage = tempIndex
                                  
                image_index = 0
                if imageArrayc[0] == "no_image"{
                   imageView.image =  UIImage(named : "no_image.png")
                    
                }else{
                   imageView.image =  UIImage(contentsOfFile: imageArrayc[tempIndex])
                }
                
                if group_item_ids.count > 0 {
                    
                    head_title.text = group_item_names[0]
                    
                    let documentDirectoryPath1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as! String
                    let myFilesPath1 = documentDirectoryPath1.appending("\(group_item_ids[0])/index.html")
                    
                    let video_path = documentDirectoryPath1.appending("/Cbo/Product/\(group_item_ids[0]).mp4")
                    
                    if FileManager.default.fileExists(atPath: myFilesPath1){
                        webpage.isHidden = false
                       
                    } else {
                        webpage.isHidden = true
                    }
                    
                    if FileManager.default.fileExists(atPath: video_path){
                        play.isHidden = false
                       
                    } else {
                        play.isHidden = true
                    }
                    
                }
                
                
                
                
                
            }
            
        }
        
        func setImage(){
            
            prepareImageArrayForGroup(GroupId: sample_id[indexId], index: indexId)
            print(imageArrayc)
            tempIndex = 0
            myImageConterController.numberOfPages = imageArrayc.count
            myImageConterController.currentPage = tempIndex
            
            image_index = 0
            if imageArrayc[0] == "no_image"{
                imageView.image =  UIImage(named : "no_image.png")
                webpage.isHidden = true
                play.isHidden = true
                
            }else{
                imageView.image =  UIImage(contentsOfFile: imageArrayc[tempIndex])
                 setSelectedImage(imageIndex: tempIndex)
                
                
                
            }
           
        }
        
    //
        
        
        
        
        
        
        
      
        func nextImage(){
            
            if imageArrayc.count - 1 > tempIndex {
                tempIndex += 1
                imageView.image = UIImage(contentsOfFile: imageArrayc[tempIndex])
                 myImageConterController.currentPage = tempIndex
                print(tempIndex)
                setSelectedImage(imageIndex: tempIndex)
            }
        }
        
        
        
        func previousImage(){
            if 0 < tempIndex {
                tempIndex -= 1
                imageView.image = UIImage(contentsOfFile: imageArrayc[tempIndex])
                myImageConterController.currentPage = tempIndex
                print(tempIndex)
                setSelectedImage(imageIndex: tempIndex)
            }
        }
        
    
    func setSelectedImage(imageIndex : Int){
        
        let id = group_item_ids[imageIndex]
        let name = group_item_names[imageIndex]
        if(!selected_group_item_ids.contains(id)){
            selected_group_item_ids.append(id)
            selected_group_item_names.append(name)
        }
        
        let documentDirectoryPath1 = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let video_path = documentDirectoryPath1.appending("/Cbo/Product/\(group_item_ids[0]).mp4")
        
        if FileManager.default.fileExists(atPath: video_path){
            play.isHidden = false
           
        } else {
            play.isHidden = true
        }
        
        for i in 0 ..< zipName.count{
        
            let myFilesPath1 = documentDirectoryPath1.appending("/Cbo/Product/\(group_item_ids[0])/index.html")
            
            if FileManager.default.fileExists(atPath: myFilesPath1){
                webpage.isHidden = false
               break
            } else {
                webpage.isHidden = true
            }
            
        
        }
        
        
        
    }
        
        func nextGroup(){
            if sample_id.count - 1 > indexId {
                indexId += 1
                setImage()
                //nextButton.isHidden = (indexId == sample_id.count - 1)
            }
            // backButton.isHidden = (indexId == 0)
        }
        
        
        func previousGroup(){
            
            if 0 < indexId {
                
                indexId -= 1
                setImage()
                
               // backButton.isHidden = (indexId == 0)
            }
            // nextButton.isHidden = (indexId == sample_id.count - 1)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return sample_name.count
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell : VisualAdsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VisualAdsCell", for: indexPath) as! VisualAdsCell
            
            if selectedIndex == indexPath.row {
                cell.contentView.backgroundColor = AppColorClass.textColorPrimary
                cell.name.textColor = UIColor.black
            } else {
                if selected.contains(sample_id[indexPath.row]){
                    cell.contentView.backgroundColor = UIColor.green
                } else {
                    cell.contentView.backgroundColor = AppColorClass.colorPrimaryDark
                    
                }
                cell.name.textColor = UIColor.white
            }
            
            
            
            cell.name.text = sample_name[indexPath.row]
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView,
                                    layout collectionViewLayout: UICollectionViewLayout,
                                    sizeForItemAt indexPath: IndexPath) -> CGSize {
                    let kWhateverHeightYouWant = 120
                    //return CGSize(width: CGFloat(kWhateverHeightYouWant), height: collectionView.bounds.size.height)
            
            return CGSize(width: 120, height: 20)
        }
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
            selectedIndex = indexPath.row

            self.collectionview.reloadData()
            
            indexId = indexPath.row
            //print(Custom_Variables_And_Method.DR_ID!)
            //cbohelp.updateDr_item(id: Custom_Variables_And_Method.DR_ID, item_id: sample_id[indexPath.row])
            //cbohelp.updatedata(drid: Custom_Variables_And_Method.DR_ID!, item: sample_id[indexPath.row], item_name: sample_name[indexPath.row], qty: "0", pob: "0", stk_rate: "0", visual: "1", noc: "0")
            setImage()
                
            
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
