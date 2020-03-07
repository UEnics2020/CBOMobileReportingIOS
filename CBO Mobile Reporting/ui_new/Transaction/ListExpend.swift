
//
//  ListExpend.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 07/01/20.
//  Copyright © 2020 Javed Hussain. All rights reserved.
//

import UIKit

class ListExpend: CustomUIViewController {
    
    @IBOutlet weak var myTopView: TopViewOfApplication!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continuebtn: UIButton!
   
    var progress : ProgressHUD!
    var che_id="",doc_id="";
    let cbohelp = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    
    var name = [String]()
    var itemId = [String]()
    
    var MESSAGE_INTERNET = 1
    
    //demo data
    var sections = [
        Section(section: "section", rows: ["row","row","row","row"],quan: ["1"],remark: ["test"],itemId: "test", expanded: false),
           Section(section: "section", rows: ["row","row"],quan: ["1"],remark: ["test"],itemId: "test", expanded: false),
           Section(section: "section", rows: ["row","row"],quan: ["1"],remark: ["test"],itemId: "test", expanded: false),
           Section(section: "section", rows: ["row","row"],quan: ["1"],remark: ["test"],itemId: "test", expanded: false)
    ]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        myTopView.backButton.addTarget(self, action: #selector(pressedBack), for: .touchUpInside )
        continuebtn.addTarget(self, action: #selector(save), for: .touchUpInside )
        if VCIntent["title"] != nil{
            myTopView.setText(title: VCIntent["title"]!)
        }
        
        getChemistlist()
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("hello")
        
        let userdefaults = UserDefaults.standard
        if let savedValue = userdefaults.string(forKey: "product"){
            
            let index = UserDefaults.standard.integer(forKey: "section")
            let qty = UserDefaults.standard.string(forKey: "qty")
            let remark = UserDefaults.standard.string(forKey: "remark")
            
            sections[index].rows = sections[index].rows + [savedValue]
            sections[index].quan = sections[index].quan + [qty!]
            sections[index].remark = sections[index].remark + [remark!]
            sections[index].expanded = true
            
            UserDefaults.standard.removeObject(forKey: "product")
            UserDefaults.standard.removeObject(forKey: "section")
            UserDefaults.standard.removeObject(forKey: "qty")
            UserDefaults.standard.removeObject(forKey: "remark")
            
        } else {
           print("No value in Userdefault,Either you can save value here or perform other operation")
           
        }
        
         
        
       
        tableView.reloadData()
    }
    
    
    @objc func pressedBack(){
        
       myTopView.CloseCurruntVC(vc: self)
        
    }
    
    
    func getChemistlist() {
        
        do{
            
            var statement = try cbohelp.getDoctorListLocal()
            
            // chemist.add(new SpinnerModel("--Select--",""));
            
            sections.removeAll()
            statement = try cbohelp.getAllProducts(itemidnotin: "0")
           
            let db = cbohelp
            while let c = statement.next() {
                    
                name.append(c[try db.getColumnIndex(statement: statement, Coloumn_Name: "item_name")]! as! String)
                itemId.append(c[try db.getColumnIndex(statement: statement, Coloumn_Name: "item_id")]! as! String)
                    
            }
            
            if name.count > 0 {
                
                for (index, element) in name.enumerated() {
                   // sections =
                      //  [Section(section: element, rows: ["row"], expanded: false)]
                    sections.append(Section(section: element, rows: [], quan: [], remark: [],itemId: itemId[index], expanded: false))
                }
                
            }
                
            
        } catch {
            print(error)
        }
        
        
    }
    
    
    @objc func save() {
        
        var sbItemId: String = ""
        var sbQty: String = ""
        var sbProduct: String = ""
        var sbRemark: String = ""
        
                   
        var j: Int = 0

        for (index, element) in sections.enumerated() {
            
            if sections[index].expanded {
                
                if sbItemId.characters.count > 0 {
                    sbItemId = "\(sbItemId)^\(sections[index].itemId ?? "")"
                } else {
                    sbItemId = sections[index].itemId ?? ""
                }
                
                
                
                if j == 0 {
                    
                    
                    for (indexs, element) in sections[index].quan.enumerated() {
                        
                        if indexs == 0 {
                            
                            if sbQty.characters.count > 0 {
                                sbQty = "\(sbQty)^\(element)"
                                sbProduct = "\(sbProduct)^\(sections[index].rows[indexs])"
                                sbRemark = "\(sbRemark)^\(sections[index].remark[indexs])"
                            } else {
                                sbQty = element;
                                sbProduct = sections[index].rows[indexs];
                                sbRemark = sections[index].remark[indexs];
                            }
                            
                            
                        } else {
                            sbQty = "\(sbQty)|\(element)"
                            sbProduct = "\(sbProduct)|\(sections[index].rows[indexs])"
                            sbRemark = "\(sbRemark)|\(sections[index].remark[indexs])"
                        }
                        
                    }
                    
                    
                    
                } else {
                    
                }
                
                
            } else {
                
                
            }
            
        }
        
        print("sbQty ", sbQty)
        print("sbProduct ", sbProduct)
        print("sbRemark ", sbRemark)
        print("sbItemId ",sbItemId)
        
        

        var request = [String:String]()
        request["sCompanyFolder"] = cbohelp.getCompanyCode()
        request["iPA_ID"] = "\(Custom_Variables_And_Method.PA_ID)"
        request["iDCR_ID"] = Custom_Variables_And_Method.DCR_ID
        request["iDR_ID"] = doc_id
        request["iCHEM_ID"] = che_id
        
        request["sMONTH"] = ""
        request["iITEM_ID"] = sbItemId
        request["sITEM_NAME"] = sbProduct
        request["sQTY"] = sbQty
        request["sREMARK"] = sbRemark
        
        var tables = [Int]();
        tables.append(0);
                   
        progress = ProgressHUD(vc: self)
        progress.show(text: "Please Wait...")
        
        CboServices().customMethodForAllServices(params: request, methodName: "RCPA_COMMIT", tables: tables, response_code: MESSAGE_INTERNET, vc: self)

    }
    
    override func getDataFromApi(response_code: Int, dataFromAPI: [String : NSArray]){
        switch response_code {
        case MESSAGE_INTERNET:
            progress.dismiss()
           // parser2(dataFromAPI : dataFromAPI);
            self.dismiss(animated: false, completion: nil)
            break;
       
       
        default:
           
            print("Error")
        }
    }
    
    
    
}


extension ListExpend: AddPrescriptionDelegate {
    func pass(data: String) {
        print("hiii")
    }
    
    
    
}

extension ListExpend: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
       if sections[section].expanded && sections[section].rows.count > 0{
            return 110
       }else if sections[section].expanded {
             return 80
        }else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sections[indexPath.section].expanded {
            return 60
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        /*let header = ExpandableHeaderView()
        header.customInit(title: sections[section].section, section: section, delegate: self)
        return header*/
        
        //print("sections[sender.tag].expanded ",sections[section].expanded)
        
        let frame = tableView.frame
        
        let button = UIButton(frame: CGRect(x: frame.size.width - 40, y: 5, width: 30, height: 30))
        button.tag = section
        //button.backgroundColor = UIColor.black
        //button.setTitle("\(section)", for: .normal)
        
        button.setImage(UIImage(named: "unchecked"), for: UIControl.State.normal)
        button.addTarget(self,action:#selector(buttonClicked),for:.touchUpInside)
        
        
        let title = UILabel(frame: CGRect(x: 5, y: 5, width: frame.size.width - 45, height: 30))
        title.tag = section
        title.text = sections[section].section
        title.textColor = UIColor.black
        title.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let addbutton = UIButton(frame: CGRect(x: 10, y: 45, width: 30, height: 30))
        addbutton.tag = section
        addbutton.backgroundColor = AppColorClass.colorPrimaryDark
        addbutton.setTitle("+", for: .normal)
        addbutton.titleLabel?.textColor = UIColor.white
        addbutton.layer.cornerRadius = 4
        addbutton.addTarget(self,action:#selector(addClicked),for:.touchUpInside)
        
        let title2 = UILabel(frame: CGRect(x: 45, y: 45, width: frame.size.width - 45, height: 30))
        title2.tag = section
        title2.text = "Prescription"
        title2.textColor = AppColorClass.colorPrimaryDark
        title2.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let innerView = UIView(frame: CGRect(x: 10, y: 80, width: frame.size.width - 20, height: 30))
        innerView.backgroundColor = AppColorClass.colorPrimaryDark
        
        let text1 = UILabel(frame: CGRect(x: 12, y: 80, width: 150, height: 30))
        text1.text = "Product"
        text1.textColor = UIColor.white
        text1.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        let text2 = UILabel(frame: CGRect(x: frame.size.width - 50, y: 80, width: 50, height: 30))
        text2.text = "Qty."
        text2.textColor = UIColor.white
        text2.font = UIFont.boldSystemFont(ofSize: 16.0)

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        if sections[section].expanded {
            button.setImage(UIImage(named: "checked"), for: UIControl.State.normal)
            headerView.addSubview(addbutton)
            headerView.addSubview(title2)
            
            if sections[section].rows.count > 0 {
                headerView.addSubview(innerView)
                headerView.addSubview(text1)
                headerView.addSubview(text2)
            }
            
        }
        
        headerView.addSubview(title)
        headerView.addSubview(button)
        
        return headerView
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")!
        let cell:RCPACell = self.tableView.dequeueReusableCell(withIdentifier: "tableCell") as! RCPACell

        let rowIndex = indexPath.row
        
        cell.productname?.text = sections[indexPath.section].rows[rowIndex]
        cell.qty?.text = sections[indexPath.section].quan[rowIndex]
        cell.remark?.text = sections[indexPath.section].remark[rowIndex]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("table section \(indexPath.section)")
        print("table item \(sections[indexPath.section].rows!)")
        //tableView.sele
        
        //sections[sender.tag].rows
        
//        sections[indexPath.section].rows = sections[indexPath.section].rows + ["row"]
//        sections[indexPath.section].expanded = true
//
//        tableView.reloadData()
        
    }
    
    @objc func addClicked(sender:UIButton){
        
//        sections[sender.tag].rows = sections[sender.tag].rows + ["row"]
//        sections[sender.tag].expanded = true
//
//        tableView.reloadData()
        
//        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPrescription") as! AddPrescription
//        self.addChildViewController(popOverVC)
//        popOverVC.view.frame = self.view.frame
//        self.view.addSubview(popOverVC.view)
//        popOverVC.didMove(toParentViewController: self)
        
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddPrescription") as! AddPrescription
        vc.section = sender.tag
        self.present(vc, animated: false, completion: nil)
        
        
        
    }
    
    
    @objc func buttonClicked(sender:UIButton){
        print(sections[sender.tag].expanded)
        
//
//        if sections[sender.tag].expanded {
//            sender.setImage(UIImage(named: "unchecked"), for: UIControl.State.normal)
//        } else {
//            sender.setImage(UIImage(named: "checked"), for: UIControl.State.normal)
//        }
//
       
        sections[sender.tag].expanded = !sections[sender.tag].expanded
        
        tableView.beginUpdates()
        for i in 0 ..< sections[sender.tag].rows.count {
            tableView.reloadRows(at: [IndexPath(row: i, section: sender.tag)], with: .none)
        }
        tableView.endUpdates()
        
        tableView.reloadData()
        
    }
    
}


