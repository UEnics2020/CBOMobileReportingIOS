//
//  Check.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 18/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

class Check: UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    //@IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var firstheight: NSLayoutConstraint!
    //@IBOutlet weak var secondheight: NSLayoutConstraint!
    @IBOutlet weak var scrollheight: NSLayoutConstraint!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var edittext: CustomeUITextField!
    var data = [String]()
    var data1 = [String]()
    var totalheight1 = 0 , totalheight2 = 0 , check = 0 , check1 = 0
    
    var someDict = [Int: Int]()
    //var dict : NSDictionary = [Int: String]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //edittext.delegate = self
         
        for i in 1...15 {
            
            if i%3 == 0 {
                data.append("Data \(i) giwuriueyuirybet gre t retuiretre t uretr ethg uhrethjkhr")
            } else if i%5 == 0{
                data.append("Data \(i) giwuriueyuirybet gre t retuiretre t uretr ethg uhrethjkhr wg riuh uwehrhe rie riyytrret")
            } else {
                data.append("Data \(i) giwuriueyuirybet ")
            }
            
            if i == 15 {
                print("yes")
                    firstheight.constant = CGFloat(data.count * 40)
                      // secondheight.constant = CGFloat(data1.count * 40)
                       
                       tableview.reloadData()
                      // tableview1.reloadData()
            }
            
        }
        
        /*for i in 11...20 {
            data1.append("Data \(i)")
        }*/
        
//        DispatchQueue.main.async {
//                   var frame = self.tableview.frame
//                   frame.size.height = self.tableview.contentSize.height
//                    self.tableview.frame = frame
//        }
        
       
        
        
    }
    
     @IBAction func addtext(_ sender: UIButton) {
        
        //data.append(edittext.text!)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  UITableViewAutomaticDimension
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // if tableView == tableview {
            return data.count
        //}/* else {
           // return data1.count
       // }*/
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      //  if tableView == tableview {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Checkcell", for: indexPath) as! Checkcell
            cell.showtext.text = data[indexPath.row]
            
            //print("countss",lines(label: cell.showtext))
            cell.showtext.numberOfLines = 0
            cell.showtext.lineBreakMode = .byWordWrapping
            cell.showtext.sizeToFit()
            let numLines = Int(cell.showtext.frame.size.height/cell.showtext.font.ascender)
            
            print("line \(indexPath.row)",numLines)
            someDict[indexPath.row] = numLines
            
            if check == 0 {
                 //totalheight1 = totalheight1 + (numLines*20+20)
            }
            
            if data.count == indexPath.row+1 && check == 0{
                
                check = 1
                print("dict",someDict)
                
                let dictValues = [Int](someDict.values)
                
                for (value) in dictValues {
                   print("\(value)")
                    totalheight1 = totalheight1 + (value*20+20)
                    
                }
                
                print("\(totalheight1)")
                firstheight.constant = CGFloat(totalheight1)
                scrollheight.constant = CGFloat(totalheight1)
                viewheight.constant = CGFloat(totalheight1)
            }
            
            //dict.setValue(numLines, forKey: String(indexPath.row))
            
           
            //print("totalheight1 \(indexPath.row)",totalheight1)
            //firstheight.constant = CGFloat(totalheight1)
            return cell
            
        /*} else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Checkcell1", for: indexPath) as! Checkcell
            
            cell.showtext.text = data1[indexPath.row]
            
           
            cell.showtext.numberOfLines = 0
      
            cell.showtext.lineBreakMode = .byWordWrapping
            cell.showtext.sizeToFit()
            let numLines = Int(cell.showtext.frame.size.height/cell.showtext.font.ascender)
            
            if check1 == 0 {
                 totalheight2 = totalheight2 + (numLines*20+20)
            }
            
            if data1.count == indexPath.row+1 {
                
                check1 = 1
                
            }
            
            secondheight.constant = CGFloat(totalheight2)
           // scrollheight.constant = CGFloat(totalheight1 + totalheight2 + 50)
           
            return cell
            
        }*/
        
        
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
