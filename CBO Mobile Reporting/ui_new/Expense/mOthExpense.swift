//
//  mOthExpense.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 12/09/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit

public class mOthExpense {

    private var Id : Int = 0;
    private var expHead : mExpHead = mExpHead(id: 0,name: "");
    private var km : Double = 0;
    private var amount : Double = 0;
    private var Remark = "";
    private var Attachment = "";
    private var time = "";
    private var editable : Bool = true
    
    // getter
    
    public func IsEditable() -> Bool {
        return editable;
    }
    
    public func getId() -> Int {
        return Id;
    }
    
    public func getExpHead() -> mExpHead {
        return expHead;
    }
    
    public func getKm() -> Double{ return km;}
    
    public func getAmount() -> Double{
        return amount;
    }
    
    public func getRemark() -> String {
        return Remark;
    }
    
    public func getAttachment()-> String  {
        return Attachment;
    }
    
    
    
//    public func getAttachmentName() -> String {
//        var sb = "";
//        var count = 0;
//
//        for( path : String in  getAttachmentArr()) {
//            File file = new File(path);
//            if (count != 0) {
//                sb += ("|^");
//            }
//            ++count;
//            sb.append(file.getName());
//        }
//        return sb.toString();
//    }
//
//    public func getAttachmentArr() -> [String] {
//        return this.getAttachment().isEmpty() ? new ArrayList() : new ArrayList(Arrays.asList(this.Attachment.split("\\|\\^")));
//    }
    
    
    public func getTime() -> String {
        return time;
    }
    
    ///setter
    
    public func setId( id : Int) -> mOthExpense {
        Id = id;
        return self;
    }
    
    public func setExpHead( expHead : mExpHead) -> mOthExpense{
        self.expHead = expHead;
        return self;
    }
    
    public func setKm( km : Double) -> mOthExpense {
        self.km = km;
        return self;
    }
    
    public func setAmount(amount : Double)-> mOthExpense {
        self.amount = amount;
        return self;
    }
    
    public func setRemark( remark : String) -> mOthExpense {
        Remark = remark;
        return self;
    }
    
    public func setAttachment( attachment : String) -> mOthExpense{
        Attachment = attachment;
        return self;
    }
    
    public func setAttachment( attachment : [String]) -> mOthExpense{
        var sb : String = "";
        var count = 0;
        attachment.forEach { file in
        //for (var file in attachment) {
            if (count != 0) {
                sb += ("|^");
            }
            count += 1;
            sb += (file);
        }
        self.Attachment = sb;
        return self;
    }
    
    public func setTime( time : String) -> mOthExpense{
        self.time = time;
        return self;
    }
    
    public func setEditable( edit : Bool) -> mOthExpense{
        self.editable = edit;
        return self;
    }

}
