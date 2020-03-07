    //
    //  CBOFinalTask_New.swift
    //  CBO Mobile Reporting
    //
    //  Created by rahul sharma on 22/01/18.
    //  Copyright © 2018 rahul sharma. All rights reserved.
    //

    import Foundation
     class CBOFinalTask_New {
        
        
        
        private var  context : CustomUIViewController!
        private var  cbohelp : CBO_DB_Helper!
        var  customVariablesAndMethod : Custom_Variables_And_Method!
        
        private var dcr_id = "" ,AllItemQty = "" ,AllPob = "",  AllGiftId = "",AllGiftQty = ""
        private var doc_id : [String]!
        
        
        init(context : CustomUIViewController) {
            
            self.context = context
            customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        }
        
        
        
        func dcr_ChemReminder( updated : String? = nil) -> [String : String ]
           {
               var map_CheRemider = [String :String]()
               var sb_sDCRRC_CHEM_ID = ""
               var sb_sDCRRC_LOC_CHEM = ""
               var sb_sDCRRC_IN_TIME_CHEM = ""
               var sb_sDCRRC_KM_CHEM = ""
               var sb_sDCRRC_SRNO_CHEM = ""
               var sb_sDCRRC_BATTERY_PERCENT_CHEM = ""
               var sb_sDCRRC_REMARK_CHEM = ""
               var sb_sDCRRC_FILE_CHEM = ""
               var sb_sRC_REF_LAT_LONG_CHEM = ""

               cbohelp  = CBO_DB_Helper.shared
            
               let chem_remId : [String] = cbohelp.getChemRc(updated :  updated)
               var saprator = "^", file = "";
               var saprator_1 = "|";
            
            
                do{
                        if(chem_remId.count > 0) {
                            
                            for  i in 0 ..< chem_remId.count {
                                 
                                var che_latLong = "" , che_Address = "" , che_locExtra = ""
                                che_latLong = cbohelp.getLatLong_ChemRc(chem_id: chem_remId[i])
                                che_Address = ""//cbohelp.getDrCall_Location(drid: chem_remId[i])
                                che_locExtra = cbohelp.getLocExtra_ChemRc(chem_id: chem_remId[i])
                                
                                cbohelp.Chem_RCupdateAllItemAddress(chem_id: chem_remId[i], address: che_latLong + "@" + che_locExtra + "!^" + che_Address)
                                
                                    
                                if updated != nil {
                                    
                                    //che_Address = customVariablesAndMethod.getAddressByLatLong(mContext, loc);
                                    
                                    
                                                
                                    cbohelp.Chem_RCupdateAllItemAddress(chem_id: chem_remId[i], address: che_latLong + "@" + che_locExtra + "!^" + che_Address)
                                                                            
                                }
                                        
                                if (i==0) {
                                    saprator = "";
                                    saprator_1 = "";
                                } else {
                                    saprator = "^";
                                    saprator_1="|";
                                }
                                            
                                            
                                sb_sDCRRC_CHEM_ID = sb_sDCRRC_CHEM_ID + saprator + chem_remId[i]
                                sb_sDCRRC_LOC_CHEM  = sb_sDCRRC_LOC_CHEM + saprator_1  + cbohelp.getAddress_ChemRc(chem_id: chem_remId[i])
                                sb_sDCRRC_IN_TIME_CHEM = sb_sDCRRC_IN_TIME_CHEM  +  saprator + (cbohelp.getTime_ChemRc(chem_id: chem_remId[i]))
                                sb_sDCRRC_KM_CHEM = sb_sDCRRC_KM_CHEM + saprator + cbohelp.getKm_ChemRc(chem_id: chem_remId[i] )
                                sb_sDCRRC_SRNO_CHEM = sb_sDCRRC_SRNO_CHEM + saprator + cbohelp.getSRNO_ChemRc(chem_id: chem_remId[i])
                                sb_sDCRRC_BATTERY_PERCENT_CHEM = sb_sDCRRC_BATTERY_PERCENT_CHEM + saprator + (cbohelp.ChemRc_Battery(chem_id: chem_remId[i] ))
                                sb_sDCRRC_REMARK_CHEM = sb_sDCRRC_REMARK_CHEM + saprator + (cbohelp.ChemRc_remark(chem_id : chem_remId[i]))
                                sb_sRC_REF_LAT_LONG_CHEM = sb_sRC_REF_LAT_LONG_CHEM + saprator + (cbohelp.ChemRc_RefLatLong(chem_id : chem_remId[i]))
                                        
                                file = cbohelp.ChemRc_file(chem_id: chem_remId[i]);
                                //file = file.substring(file.lastIndexOf(char: "/")+1);
                                
                                sb_sDCRRC_FILE_CHEM = sb_sDCRRC_FILE_CHEM + saprator + file
                                        
                            }
                                    
                }
                    
                map_CheRemider["sb_sDCRRC_CHEM_ID"] = sb_sDCRRC_CHEM_ID
                map_CheRemider["sb_sDCRRC_LOC_CHEM"] = sb_sDCRRC_LOC_CHEM
                map_CheRemider["sb_sDCRRC_IN_TIME_CHEM"] = sb_sDCRRC_IN_TIME_CHEM
                map_CheRemider["sb_sDCRRC_KM_CHEM"] = sb_sDCRRC_KM_CHEM
                            
                map_CheRemider["sb_sDCRRC_SRNO_CHEM"] = sb_sDCRRC_SRNO_CHEM
                map_CheRemider["sb_sDCRRC_BATTERY_PERCENT_CHEM"] = sb_sDCRRC_BATTERY_PERCENT_CHEM
                map_CheRemider["sb_sDCRRC_REMARK_CHEM"] = sb_sDCRRC_REMARK_CHEM
                map_CheRemider["sb_sDCRRC_FILE_CHEM"] = sb_sDCRRC_FILE_CHEM
                map_CheRemider["sb_sRC_REF_LAT_LONG_CHEM"] = sb_sRC_REF_LAT_LONG_CHEM
                                
                }catch  {
                    print(error)
                }
            
             
               return map_CheRemider;
           }
        
        
        func dcr_doctorSave( updated : String? = nil) -> [String : String ]{
                var map_DcrDr_Save = [String :String]()
                var sb_sDCRDR_DR_ID = ""
                var sb_sDCRDR_WW1 = ""
                var sb_sDCRDR_WW2 = ""
                var sb_sDCRDR_WW3 = ""
                var sb_sDCRDR_LOC = ""
                var sb_sDCRDR_IN_TIME = ""
                var sb_sDCRDR_BATTERY_PERCENT = ""
                var sb_sDCRDR_Remark = ""
                var sb_sDCRDR_KM = ""
                var sb_sDCRDR_SRNO = ""
                var sb_sDCRDR_FILE = ""
                var sb_sDCRDR_CALLTYPE = ""
                var sb_sDR_REF_LAT_LONG = ""
            
            cbohelp  = CBO_DB_Helper.shared
        //ArrayList<String> mydrList=cbohelp.getDoctor();
            var mydrList : [String] = cbohelp.tempDrListForFinalSubmit(updated :  updated)
            var saprator = "^";
            var saprator_1 = "|";
        
        
            do{
                if(mydrList.count > 0) {
                for  i in 0 ..< mydrList.count {
             
                        var dr_latLong = "" , dr_Address = "" , dr_locExtra = ""
                        dr_latLong = cbohelp.getDrCall_latLong(drid: mydrList[i])
                        dr_Address = cbohelp.getDrCall_Location(drid: mydrList[i])
                        dr_locExtra = cbohelp.getDrCall_LocExtra(drid: mydrList[i])
                        cbohelp.updateDr_LocExtra(LOC_EXTRA: dr_latLong + "@" + dr_locExtra + "!^" + dr_Address , drId: mydrList[i])
                    
                    if updated != nil {
                                                    
                        if (dr_Address == "") {
                            dr_Address = dr_latLong
                            // customVariablesAndMethod.getAddressByLatLong(context, dr_latLong);
                                                                            
                            cbohelp.updateDrCall_Address(dr_Address: dr_Address, drId: mydrList[i])
                                                                            
                            cbohelp.updateDr_LocExtra(LOC_EXTRA: dr_latLong + "@" + dr_locExtra + "!^" + dr_Address , drId: mydrList[i])
                                                                    
                        } else {
                            dr_Address = dr_latLong
                            
//                                    customVariablesAndMethod.getAddressByLatLong(mContext, dr_latLong);
                            cbohelp.updateDrCall_Address(dr_Address: dr_Address, drId: mydrList[i])
                                                                            
                            cbohelp.updateDr_LocExtra(LOC_EXTRA: dr_latLong + "@" + dr_locExtra + "!^" + dr_Address , drId: mydrList[i] )
                        }
                                                    
                    }
                
                    if (i==0){
                        saprator = "";
                        saprator_1 = "";
                    }else {
                        saprator = "^";
                        saprator_1="|";
                    }
                    sb_sDCRDR_DR_ID = sb_sDCRDR_DR_ID + saprator + mydrList[i]
                    sb_sDCRDR_WW1  = sb_sDCRDR_WW1 + saprator  + cbohelp.getDoctorww1FromSqlite(drid: mydrList[i])
                    sb_sDCRDR_WW2 = sb_sDCRDR_WW2  +  saprator + (cbohelp.getDoctorww2FromSqlite(drid: mydrList[i]))
                    sb_sDCRDR_WW3 = sb_sDCRDR_WW3 + saprator + cbohelp.getDoctorww3FromSqlite(drid: mydrList[i] )
                    sb_sDCRDR_LOC = sb_sDCRDR_LOC + saprator_1 + cbohelp.getDoctorLocExtraFromSqlite(drid: mydrList[i])
                    sb_sDCRDR_IN_TIME = sb_sDCRDR_IN_TIME + saprator + (cbohelp.getDoctorTimeFromSqlite(drid: mydrList[i] ))
                    sb_sDCRDR_BATTERY_PERCENT = sb_sDCRDR_BATTERY_PERCENT + saprator + (cbohelp.getBattryLevel_RC(drid : mydrList[i]))
                    sb_sDCRDR_Remark = sb_sDCRDR_Remark + saprator + (cbohelp.getDr_Remark(drid : mydrList[i]))
                    sb_sDCRDR_KM = sb_sDCRDR_KM + saprator + (cbohelp.getKm_Doctor(drid: mydrList[i]))
                    sb_sDCRDR_SRNO = sb_sDCRDR_SRNO + saprator + (cbohelp.getSRNO_Doctor(drid : mydrList[i]));
                    sb_sDCRDR_FILE = sb_sDCRDR_FILE + saprator + (cbohelp.getFILE_Doctor(drid : mydrList[i]))
                    sb_sDCRDR_CALLTYPE = sb_sDCRDR_CALLTYPE + saprator + cbohelp.getCALL_TYPE_Doctor(drid : mydrList[i])
                    sb_sDR_REF_LAT_LONG = sb_sDR_REF_LAT_LONG + saprator + cbohelp.getRef_LatLong_Doctor(drid : mydrList[i])
                    }
                }
                
                map_DcrDr_Save["sb_sDCRDR_DR_ID"] = sb_sDCRDR_DR_ID
                map_DcrDr_Save["sb_sDCRDR_WW1"] = sb_sDCRDR_WW1
                map_DcrDr_Save["sb_sDCRDR_WW2"] = sb_sDCRDR_WW2
                map_DcrDr_Save["sb_sDCRDR_WW3"] = sb_sDCRDR_WW3
                map_DcrDr_Save["sb_sDCRDR_LOC"] = sb_sDCRDR_LOC
                map_DcrDr_Save["sb_sDCRDR_IN_TIME"] = sb_sDCRDR_IN_TIME
                map_DcrDr_Save["sb_sDCRDR_BATTERY_PERCENT"] = sb_sDCRDR_BATTERY_PERCENT
                map_DcrDr_Save["sb_sDCRDR_Remark"] = sb_sDCRDR_Remark
                map_DcrDr_Save["sb_sDCRDR_KM"] = sb_sDCRDR_KM
                
                map_DcrDr_Save["sb_sDCRDR_SRNO"] = sb_sDCRDR_SRNO
                map_DcrDr_Save["sb_sDCRDR_FILE"] = sb_sDCRDR_FILE
                map_DcrDr_Save["sb_sDCRDR_CALLTYPE"] = sb_sDCRDR_CALLTYPE
                map_DcrDr_Save["sb_sDR_REF_LAT_LONG"] = sb_sDR_REF_LAT_LONG
                
              
            }catch  {
                print(error)
            }
            
            return map_DcrDr_Save;
        }
        
        
        
        
        
        public func drItemSave(updated : String? = nil) -> [String: String]{
            var commitItemMobileMap = [String : String]()
                var sb_sDCRITEM_DR_ID = String()
                var sb_sDCRITEM_ITEMIDIN = String()
                var sb_sDCRITEM_ITEM_ID_ARR = String()
                var sb_sDCRITEM_QTY_ARR = String()
                var sb_sDCRITEM_ITEM_ID_GIFT_ARR = String()
                var sb_sDCRITEM_QTY_GIFT_ARR = String()
            
                var sb_sDCRITEM_POB_QTY = String()
                var sb_sDCRITEM_POB_VALUE = String()
                var sb_sDCRITEM_VISUAL_ARR = String()
                var sb_sDCRITEM_NOC_ARR = String()
                var sb_DCRDR_RATE = String()
        
                cbohelp = CBO_DB_Helper.shared
            
                //doc_id = cbohelp.getdoctormoreLit(updated: updated)
                doc_id=cbohelp.tempDrListForFinalSubmit(updated: updated);
                if(doc_id.count > 0) {
                        var visual_items = "0";
                        var noc_value = "0";
                        var rate = "";
                        var Pob_Value="";
                        var saperator="";
                        for i in 0 ..< doc_id.count{
                        var main_id = doc_id[i]
                            var doc_itemid = cbohelp.getDocItem( mdrid :doc_id[i])[0]
                        
                            AllItemQty = cbohelp.getDocItem(mdrid: doc_id[i])[1]
        
                            AllPob = cbohelp.getDocItem( mdrid : doc_id[i])[2]
        
                            AllGiftId = cbohelp.getDocItem( mdrid : doc_id[i])[0]
                            
                            AllGiftQty = cbohelp.getDocItem(mdrid :  doc_id[i])[1]
                            visual_items = cbohelp.getDocItem(mdrid : doc_id[i])[3]
                            noc_value = cbohelp.getDocItem(mdrid : doc_id[i])[4]
                            rate = cbohelp.getDocItem(mdrid : doc_id[i])[5]
                            if (i==0){
                                saperator = "";
                            }else {
                                saperator = "^";
                            }
        
                            sb_sDCRITEM_DR_ID = sb_sDCRITEM_DR_ID + saperator + main_id
                            sb_sDCRITEM_ITEMIDIN = sb_sDCRITEM_ITEMIDIN + saperator + ("0")
                            sb_sDCRITEM_ITEM_ID_ARR = sb_sDCRITEM_ITEM_ID_ARR + saperator + doc_itemid
                            sb_sDCRITEM_QTY_ARR =  sb_sDCRITEM_QTY_ARR + saperator + AllItemQty
                            sb_sDCRITEM_ITEM_ID_GIFT_ARR = sb_sDCRITEM_ITEM_ID_GIFT_ARR + saperator + AllGiftId
                            sb_sDCRITEM_QTY_GIFT_ARR = sb_sDCRITEM_QTY_GIFT_ARR + saperator + AllGiftQty
                            sb_sDCRITEM_POB_QTY = sb_sDCRITEM_POB_QTY + saperator + AllPob
                            sb_sDCRITEM_POB_VALUE = sb_sDCRITEM_POB_VALUE + (saperator) + "0"
                            sb_sDCRITEM_VISUAL_ARR = sb_sDCRITEM_VISUAL_ARR + saperator + visual_items
                            sb_sDCRITEM_NOC_ARR = sb_sDCRITEM_NOC_ARR + saperator + noc_value
                            sb_DCRDR_RATE = sb_DCRDR_RATE + saperator + rate
                    }
        
        
                    commitItemMobileMap["sb_sDCRITEM_DR_ID"]  = sb_sDCRITEM_DR_ID
                    commitItemMobileMap["sb_sDCRITEM_ITEMIDIN"] = sb_sDCRITEM_ITEMIDIN
                    commitItemMobileMap["sb_sDCRITEM_ITEM_ID_ARR"]  = sb_sDCRITEM_ITEM_ID_ARR
                    commitItemMobileMap["sb_sDCRITEM_QTY_ARR"] = sb_sDCRITEM_QTY_ARR
                    commitItemMobileMap["sb_sDCRITEM_ITEM_ID_GIFT_ARR"]  = sb_sDCRITEM_ITEM_ID_GIFT_ARR
                    commitItemMobileMap["sb_sDCRITEM_QTY_GIFT_ARR"]  = sb_sDCRITEM_QTY_GIFT_ARR
                    commitItemMobileMap["sb_sDCRITEM_POB_QTY"]  = sb_sDCRITEM_POB_QTY
                    commitItemMobileMap["sb_sDCRITEM_POB_VALUE"]  = sb_sDCRITEM_POB_VALUE
                    commitItemMobileMap["sb_sDCRITEM_VISUAL_ARR"]  = sb_sDCRITEM_VISUAL_ARR
                    commitItemMobileMap["sb_sDCRITEM_NOC_ARR"] = sb_sDCRITEM_NOC_ARR
                    commitItemMobileMap["sb_DCRDR_RATE"] = sb_DCRDR_RATE
        
        //cbohelp.deleteDoctor();
       
            }
        
            return commitItemMobileMap;
        
            }
        
        
        
        
        
        
        
        public func drRx_Save(updated : String? = nil ) -> [String : String]{
            
            var commitRxItemMobileMap = [String :String]()
            var sDCRRX_DR_ARR = String()
            var sDCRRX_ITEMID_ARR = String()
        
            cbohelp = CBO_DB_Helper.shared

            doc_id = cbohelp.getDr_Rx_id( updated:  updated);
        if(doc_id.count > 0) {
        
            var Pob_Value = "";
            var saperator = "";
            for i in  0 ..< doc_id.count {
        
                     var main_id = doc_id[i]
                    var doc_itemid = cbohelp.getDr_Rx_itemId(dr_id:  doc_id[i])
        
                    if (i==0){
                        saperator = "";
                    }else {
                        saperator = "^";
                    }
        
                  sDCRRX_DR_ARR =  sDCRRX_DR_ARR + saperator + main_id
                sDCRRX_ITEMID_ARR = sDCRRX_ITEMID_ARR + saperator + doc_itemid
        }
        
        
        commitRxItemMobileMap["sDCRRX_DR_ARR"] = sDCRRX_DR_ARR
        commitRxItemMobileMap["sDCRRX_ITEMID_ARR"] = sDCRRX_ITEMID_ARR
        
        
        }
        
        return commitRxItemMobileMap;
        
        }
        
        
        
        
        
        public func dcr_chemSave(updated : String? = nil) -> [String : String]
        {
            var sb_sDCRCHEM_CHEM_ID = String()
            var sb_sDCRCHEM_POB_QTY = String()
            var sb_sDCRCHEM_POB_AMT = String()
            var sb_sDCRCHEM_ITEM_ID_ARR = String()
            var sb_sDCRCHEM_QTY_ARR = String()
            var sb_sDCRCHEM_LOC = String()
            var sb_sDCRCHEM_IN_TIME = String()
            var sb_sDCRCHEM_SQTY_ARR = String()
            var sb_sDCRCHEM_ITEM_ID_GIFT_ARR = String()
            var sb_sDCRCHEM_QTY_GIFT_ARR = String()
            var sb_sDCRCHEM_BATTERY_PERCENT = String()
            var sb_sDCRCHEM_KM = String()
            var sb_sDCRCHEM_SRNO = String()
            var sb_sDCRCHEM_REMARK = String()
            var sb_sDCRCHEM_FILE = String()
            var sb_sCHEM_REF_LAT_LONG = String()
            var sb_DCRCHEM_RATE = String()
            
            var sCHEM_STATUS = String()
            var sCOMPETITOR_REMARK = String()
            
        
        
            var map_Dcr_ChemistSave = [String : String]()
        
        
            cbohelp = CBO_DB_Helper.shared
            var chem_id = [String]()
            chem_id = cbohelp.chemistListForFinalSubmit(updated : updated)
           
            do{
            
                if(chem_id.count > 0) {
                    var saprator = ""
                    var saprator_1 = "|"
        
                    for i in 0 ..< chem_id.count {
        
                        var chemLatLong = "" ,chemAddress = "" , chem_locExtra = ""
                        chemLatLong =  cbohelp.getChemistLatLong(  chem_id: chem_id [i])
                        chemAddress = cbohelp.getChemistAddress( chem_id:  chem_id[i])
                        chem_locExtra =  cbohelp.getChemistLocExtra(chem_id:  chem_id[i])
                    
                        cbohelp.upDateChemistLocExtra( chem_id : chem_id[i],   address :  chemLatLong + "@" + chem_locExtra + "!^" + chemAddress)
                    
                        if updated != nil  {
                        
                            if ((chemAddress == "")) {
                                chemAddress = chemLatLong
                            
                            
//                            customVariablesAndMethod.getAddressByLatLong(context, chemLatLong);
//
                            
                                cbohelp.getUpdateChemistAddress(chem_id : chem_id[i], chem_address : chemAddress)
                              
                                cbohelp.upDateChemistLocExtra(chem_id:  chem_id[i], address:  chemLatLong + "@" + chem_locExtra + "!^" + chemAddress);
                            } else {
                                chemAddress = chemLatLong
//                                customVariablesAndMethod.getAddressByLatLong(mContext, chemLatLong);
                                cbohelp.getUpdateChemistAddress(chem_id : chem_id[i], chem_address: chemAddress);
                                
                                cbohelp.upDateChemistLocExtra(chem_id:  chem_id[i], address: chemLatLong + "@" + chem_locExtra + "!^" + chemAddress);
        
                            }
                        }
                    
        
                        if (i==0){
                            saprator = "";
                            saprator_1 = "";
        
                        }
                        else {
                            saprator = "^";
                            saprator_1 = "|";
                        }
        
                        sb_sDCRCHEM_CHEM_ID = sb_sDCRCHEM_CHEM_ID + saprator + chem_id[i]
                        
                        sb_sDCRCHEM_POB_QTY = sb_sDCRCHEM_POB_QTY + (saprator) + (cbohelp.chemAllItemSample( chid : chem_id[i]))
        
                        sb_sDCRCHEM_POB_AMT = sb_sDCRCHEM_POB_AMT + (saprator) + (cbohelp.chemAllItemPob(chid: chem_id[i]));
        
                        sb_sDCRCHEM_ITEM_ID_ARR = sb_sDCRCHEM_ITEM_ID_ARR + (saprator) + (cbohelp.chemAllItem( chid :chem_id[i]))
                        
                        sb_sDCRCHEM_QTY_ARR = sb_sDCRCHEM_QTY_ARR + saprator  + (cbohelp.chemAllItemQty(chid: chem_id[i]))
                        
                        sb_sDCRCHEM_LOC = sb_sDCRCHEM_LOC + (saprator_1) + (cbohelp.chemAllItemLocExtra(chid: chem_id[i]))
                        
                        sb_sDCRCHEM_IN_TIME = sb_sDCRCHEM_IN_TIME + (saprator) + (cbohelp.chemAllTime(chid: chem_id[i]));
                       
                        sb_sDCRCHEM_SQTY_ARR = sb_sDCRCHEM_SQTY_ARR + (saprator) + (cbohelp.chemAllItemSample(chid: chem_id[i]));
                        sb_sDCRCHEM_ITEM_ID_GIFT_ARR = sb_sDCRCHEM_ITEM_ID_GIFT_ARR + (saprator) + ( cbohelp.chemAllItemGiftid(chid: chem_id[i]));
                        sb_sDCRCHEM_QTY_GIFT_ARR = sb_sDCRCHEM_QTY_GIFT_ARR + (saprator) + ( cbohelp.chemAllItemGiftQty(chid: chem_id[i]));
                        sb_sDCRCHEM_BATTERY_PERCENT = sb_sDCRCHEM_BATTERY_PERCENT + (saprator) + ( cbohelp.chemBatterLevel(chid: chem_id[i]));
                        sb_sDCRCHEM_KM = sb_sDCRCHEM_KM + (saprator) + ( cbohelp.getKm_Chemist(chem_id: chem_id[i]));
                        sb_sDCRCHEM_SRNO = sb_sDCRCHEM_SRNO + (saprator) + ( cbohelp.getSRNO_Chemist(chem_id: chem_id[i]));
                        sb_sDCRCHEM_REMARK = sb_sDCRCHEM_REMARK + (saprator) + ( cbohelp.getRemark_Chemist(chem_id: chem_id[i]));
                        sb_sDCRCHEM_FILE = sb_sDCRCHEM_FILE + (saprator) + ( cbohelp.getFileChemist(chem_id: chem_id[i]));
                        sb_sCHEM_REF_LAT_LONG = sb_sCHEM_REF_LAT_LONG + (saprator) + ( cbohelp.getRef_LotLong_Chemist(chem_id: chem_id[i]));
                        sb_DCRCHEM_RATE = sb_DCRCHEM_RATE + (saprator) + ( cbohelp.getRate_Chemist(chem_id: chem_id[i]));
                        
                        sCHEM_STATUS = sCHEM_STATUS + (saprator) + ( cbohelp.getStatus_Chemist(chem_id: chem_id[i]));
                        sCOMPETITOR_REMARK = sCOMPETITOR_REMARK + (saprator) + ( cbohelp.getCompProduct_Chemist(chem_id: chem_id[i]));
                        
                        
                    }
                }
            }catch  {
                print(error)
            }
        
        
            map_Dcr_ChemistSave["sb_sDCRCHEM_CHEM_ID"] = sb_sDCRCHEM_CHEM_ID
            map_Dcr_ChemistSave["sb_sDCRCHEM_POB_QTY"] = sb_sDCRCHEM_POB_QTY
            map_Dcr_ChemistSave["sb_sDCRCHEM_POB_AMT"] = sb_sDCRCHEM_POB_AMT
            map_Dcr_ChemistSave["sb_sDCRCHEM_ITEM_ID_ARR"] = sb_sDCRCHEM_ITEM_ID_ARR
            map_Dcr_ChemistSave["sb_sDCRCHEM_QTY_ARR"] = sb_sDCRCHEM_QTY_ARR
            map_Dcr_ChemistSave["sb_sDCRCHEM_LOC"] = sb_sDCRCHEM_LOC
            map_Dcr_ChemistSave["sb_sDCRCHEM_IN_TIME"] = sb_sDCRCHEM_IN_TIME
            map_Dcr_ChemistSave["sb_sDCRCHEM_SQTY_ARR"] = sb_sDCRCHEM_SQTY_ARR
            map_Dcr_ChemistSave["sb_sDCRCHEM_ITEM_ID_GIFT_ARR"] = sb_sDCRCHEM_ITEM_ID_GIFT_ARR
            map_Dcr_ChemistSave["sb_sDCRCHEM_QTY_GIFT_ARR"] = sb_sDCRCHEM_QTY_GIFT_ARR
            map_Dcr_ChemistSave["sb_sDCRCHEM_BATTERY_PERCENT"] = sb_sDCRCHEM_BATTERY_PERCENT
            map_Dcr_ChemistSave["sb_sDCRCHEM_KM"] = sb_sDCRCHEM_KM
            
            map_Dcr_ChemistSave["sb_sDCRCHEM_SRNO"] = sb_sDCRCHEM_SRNO
            map_Dcr_ChemistSave["sb_sDCRCHEM_REMARK"] = sb_sDCRCHEM_REMARK
            map_Dcr_ChemistSave["sb_sDCRCHEM_FILE"] = sb_sDCRCHEM_FILE
            map_Dcr_ChemistSave["sb_sCHEM_REF_LAT_LONG"] = sb_sCHEM_REF_LAT_LONG
            map_Dcr_ChemistSave["sb_DCRCHEM_RATE"] = sb_DCRCHEM_RATE

            map_Dcr_ChemistSave["sCHEM_STATUS"] = sCHEM_STATUS
            map_Dcr_ChemistSave["sCOMPETITOR_REMARK"] = sCOMPETITOR_REMARK
        
            return  map_Dcr_ChemistSave;
        }
        
        
        
        public func dcr_stkSave(updated : String? = nil) -> [String : String]
        {
        
            var map_StkSave = [String : String]()
            var sb_sDCRSTK_STK_ID = String()
            var sb_sDCRSTK_POB_QTY = String()
            var sb_sDCRSTK_POB_AMT = String()
            var sb_sDCRSTK_ITEM_ID_ARR = String()
            var sb_sDCRSTK_QTY_ARR = String()
            var sb_sDCRSTK_LOC = String()
            var sb_sDCRSTK_IN_TIME = String()
            var sb_sDCRSTK_SQTY_ARR = String()
            var sb_sDCRSTK_ITEM_ID_GIFT_ARR = String()
            var sb_sDCRSTK_QTY_GIFT_ARR = String()
            var sb_sDCRSTK_BATTERY_PERCENT = String()
            var sb_sDCRSTK_KM = String()
            var sb_sDCRSTK_SRNO = String()
            var sb_sDCRSTK_REMARK = String()
            var sb_sDCRSTK_FILE = String()
            var sb_sSTK_REF_LAT_LONG = String()
            var sb_DCRSTK_RATE = String()
        
            var stk_id = [String]()
        
            cbohelp = CBO_DB_Helper.shared
            do {
                stk_id = try cbohelp.stockistListForFinalSubmit(updated :updated)
                var saprator = "";
                var saprator_1 = "";
                if(stk_id.count > 0) {
                    for i in 0 ..< stk_id.count {
                        let loc = cbohelp.stockistAllItemLatLong(stk_id: stk_id[i])
                    
                        let locExtra = cbohelp.stockistAllItemLocExtra(stk_id: stk_id[i]);
                    
                        var address = "";
                    
                        cbohelp.stockistupdateAllItemAddress(stk_id: stk_id[i], address: loc + "@" + locExtra + "!^" + address);
        
                        if (updated != nil) {
                        
                            address = loc
                
                            cbohelp.stockistupdateAllItemAddress(stk_id: stk_id[i], address: loc + "@" + locExtra + "!^" + address);
                            }
        
                        if (i == 0) {
                            saprator = "";
                            saprator_1 = "";
                            
                        } else {
                            saprator="^";
                            saprator_1="|";
                        }
        
                        sb_sDCRSTK_STK_ID = sb_sDCRSTK_STK_ID + (saprator) + (stk_id[i])
                        
                        sb_sDCRSTK_POB_QTY = sb_sDCRSTK_POB_QTY + (saprator) + (cbohelp.stockistAllItemSample( stk_id :stk_id[i]));
                    
                        sb_sDCRSTK_POB_AMT = sb_sDCRSTK_POB_AMT + (saprator) + (cbohelp.stockistAllItemPOB(stk_id: stk_id[i]));
                    
                        sb_sDCRSTK_ITEM_ID_ARR = sb_sDCRSTK_ITEM_ID_ARR + (saprator) + (cbohelp.stockistAllItemId(stk_id: stk_id[i]));
       
                        sb_sDCRSTK_QTY_ARR = sb_sDCRSTK_QTY_ARR + (saprator) + (cbohelp.stockistAllItemQty(stk_id: stk_id[i]));
        
       
                        sb_sDCRSTK_LOC = sb_sDCRSTK_LOC + (saprator_1) + (cbohelp.stockistAllItemAddress(stk_id: stk_id[i]));
       
                        sb_sDCRSTK_IN_TIME  = sb_sDCRSTK_IN_TIME + (saprator) + (cbohelp.stockistAllTime(stk_id: stk_id[i]));
       
                        sb_sDCRSTK_SQTY_ARR = sb_sDCRSTK_SQTY_ARR + (saprator) + (cbohelp.stockistAllItemSample(stk_id: stk_id[i]));
       
                        sb_sDCRSTK_ITEM_ID_GIFT_ARR = sb_sDCRSTK_ITEM_ID_GIFT_ARR + (saprator) + ("0");
       
                        sb_sDCRSTK_QTY_GIFT_ARR = sb_sDCRSTK_QTY_GIFT_ARR + (saprator) + ("0");
       
                        sb_sDCRSTK_BATTERY_PERCENT = sb_sDCRSTK_BATTERY_PERCENT + (saprator) + (cbohelp.stockist_Battery(stk_id: stk_id[i]));
        
                        sb_sDCRSTK_KM = sb_sDCRSTK_KM + (saprator) + (cbohelp.getKm_Stockist(stk_id: stk_id[i]));
        
                        sb_sDCRSTK_SRNO =  sb_sDCRSTK_SRNO + (saprator) + (cbohelp.getSRNO_Stockist(stk_id: stk_id[i]));
        
                        sb_sDCRSTK_REMARK = sb_sDCRSTK_REMARK + (saprator) + (cbohelp.getRemark_Stockist(stk_id: stk_id[i]));
        
                        sb_sDCRSTK_FILE = sb_sDCRSTK_FILE + (saprator) + (cbohelp.getFile_Stockist(stk_id:  stk_id[i]));
                        sb_sSTK_REF_LAT_LONG = sb_sSTK_REF_LAT_LONG + (saprator) + (cbohelp.getRefLatLong_Stockist(stk_id:  stk_id[i]));
                        sb_DCRSTK_RATE = sb_DCRSTK_RATE + (saprator) + (cbohelp.getRate_Stockist(stk_id:  stk_id[i]));
                        
                    }
                }
            }catch  {
                print(error)
            }

            map_StkSave["sb_sDCRSTK_STK_ID"] = sb_sDCRSTK_STK_ID
            map_StkSave["sb_sDCRSTK_POB_QTY"] = sb_sDCRSTK_POB_QTY
            map_StkSave["sb_sDCRSTK_POB_AMT"] = sb_sDCRSTK_POB_AMT
            map_StkSave["sb_sDCRSTK_ITEM_ID_ARR"] = sb_sDCRSTK_ITEM_ID_ARR
            map_StkSave["sb_sDCRSTK_QTY_ARR"] = sb_sDCRSTK_QTY_ARR
            map_StkSave["sb_sDCRSTK_LOC"] = sb_sDCRSTK_LOC
            map_StkSave["sb_sDCRSTK_IN_TIME"] = sb_sDCRSTK_IN_TIME
            map_StkSave["sb_sDCRSTK_SQTY_ARR"] = sb_sDCRSTK_SQTY_ARR
            map_StkSave["sb_sDCRSTK_ITEM_ID_GIFT_ARR"] = sb_sDCRSTK_ITEM_ID_GIFT_ARR
            map_StkSave["sb_sDCRSTK_QTY_GIFT_ARR"] = sb_sDCRSTK_QTY_GIFT_ARR
            map_StkSave["sb_sDCRSTK_BATTERY_PERCENT"] = sb_sDCRSTK_BATTERY_PERCENT
            map_StkSave["sb_sDCRSTK_KM"] = sb_sDCRSTK_KM
            
            map_StkSave["sb_sDCRSTK_SRNO"] = sb_sDCRSTK_SRNO
            map_StkSave["sb_sDCRSTK_REMARK"] = sb_sDCRSTK_REMARK
            map_StkSave["sb_sDCRSTK_FILE"] = sb_sDCRSTK_FILE
            map_StkSave["sb_sSTK_REF_LAT_LONG"] = sb_sSTK_REF_LAT_LONG
            map_StkSave["sb_DCRSTK_RATE"] = sb_DCRSTK_RATE
        
        
      
        return map_StkSave;
        }
        
        
        public func dcr_DrReminder(updated : String? = nil) -> [String: String]
        {
            var map_DrRemider = [String: String]()
            
            var sb_sDCRRC_DR_ID =  String()
            var sb_sDCRRC_LOC =  String()
            var sb_sDCRRC_IN_TIME =  String()
            var sb_sDCRRC_KM =  String()
            var sb_sDCRRC_SRNO =  String()
            var sb_sDCRRC_BATTERY_PERCENT =  String()
            var sb_sDCRRC_REMARK =  String()
            var sb_sDCRRC_FILE =  String()
            var sb_sRC_REF_LAT_LONG =  String()
            
        
            cbohelp = CBO_DB_Helper.shared
            
            var dr_remId = [String]()
            do {
                dr_remId = cbohelp.getDrRc(updated: updated)
                if(dr_remId.count > 0) {
                    var saperator = "";
                    var saperator_1 = "";
                    for i in 0 ..< dr_remId.count {
                    
                        let loc = cbohelp.getLatLong_RC(drid: dr_remId[i]);
                        let locExtra = cbohelp.getLocExtra_RC(drid: dr_remId[i]);
                    var address =  "";
        
                        cbohelp.Dr_RCupdateAllItemAddress(drid: dr_remId[i], address: loc + "@" + locExtra + "!^" + address)
        
                        if (updated != nil) {
                            address =  loc
                            cbohelp.Dr_RCupdateAllItemAddress(drid: dr_remId[i], address: loc + "@" + locExtra + "!^" + address);
                        }
                    
                        if (i==0) {
                            saperator = "";
                            saperator_1 = "";
        
                        } else {
                            saperator = "^";
                            saperator_1="|";
                        }
        
        
                        sb_sDCRRC_DR_ID = sb_sDCRRC_DR_ID + (saperator) + (dr_remId[i]);
                     
                        sb_sDCRRC_LOC = sb_sDCRRC_LOC + (saperator_1) + ( cbohelp.getAddress_RC(drid: dr_remId[i]));
                        
                        sb_sDCRRC_IN_TIME = sb_sDCRRC_IN_TIME + (saperator) + (cbohelp.getTime_RC(drid: dr_remId[i]));
                        
                        sb_sDCRRC_KM = sb_sDCRRC_KM + (saperator) + (cbohelp.getKm_Rc(drid: dr_remId[i]));
       
                        sb_sDCRRC_SRNO = sb_sDCRRC_SRNO + (saperator) + (cbohelp.getSRNO_Rc(drid: dr_remId[i]));
        
                        sb_sDCRRC_BATTERY_PERCENT = sb_sDCRRC_BATTERY_PERCENT + (saperator) + (cbohelp.Rc_Battery(dr_id: dr_remId[i]));
       
                        sb_sDCRRC_REMARK = sb_sDCRRC_REMARK + (saperator) + (cbohelp.Rc_remark(dr_id: dr_remId[i]));
       
                        sb_sDCRRC_FILE = sb_sDCRRC_FILE + (saperator) + (cbohelp.Rc_file(dr_id: dr_remId[i]));
                        sb_sRC_REF_LAT_LONG = sb_sRC_REF_LAT_LONG + (saperator) + (cbohelp.Rc_RefLatLong(dr_id: dr_remId[i]));
        
                    }
                }
            }
            catch {
                print(error)
            }
        
            map_DrRemider["sb_sDCRRC_DR_ID"] = sb_sDCRRC_DR_ID
            map_DrRemider["sb_sDCRRC_LOC"] = sb_sDCRRC_LOC
            map_DrRemider["sb_sDCRRC_IN_TIME"] = sb_sDCRRC_IN_TIME
            map_DrRemider["sb_sDCRRC_KM"] = sb_sDCRRC_KM
            
            map_DrRemider["sb_sDCRRC_SRNO"] = sb_sDCRRC_SRNO
            map_DrRemider["sb_sDCRRC_BATTERY_PERCENT"] = sb_sDCRRC_BATTERY_PERCENT
            map_DrRemider["sb_sDCRRC_REMARK"] = sb_sDCRRC_REMARK
            map_DrRemider["sb_sDCRRC_FILE"] = sb_sDCRRC_FILE
            map_DrRemider["sb_sRC_REF_LAT_LONG"] = sb_sRC_REF_LAT_LONG
    
            
            return map_DrRemider;
        }
    
    
    
    
        
        public func get_Lat_Long_Reg(updated : String? = nil) -> [String: String] {
            var map_Lat_Long_Reg = [String : String]()
            var sb_DCS_ID_ARR =  String()
            var sb_LAT_LONG_ARR =  String()
            var sb_DCS_TYPE_ARR =  String()
            var sb_DCS_ADD_ARR =  String()
            var sb_DCS_INDES_ARR =  String()
        
        
                cbohelp = CBO_DB_Helper.shared
            var Lat_Long_Reg  : [[String : String]] = cbohelp.get_Lat_Long_Reg(updated  : updated!)
            do {
                
                if(Lat_Long_Reg.count > 0) {
                    var saperator = "";
                    var saperator_1 = "";
                    for i in 0 ..< Lat_Long_Reg.count{
    
        
                        if (i==0) {
                            saperator = "";
                            saperator_1 = "";
        
                        } else {
                            saperator = "^";
                            saperator_1="|";
                        }
        
        
                        sb_DCS_ID_ARR =  try sb_DCS_ID_ARR + (saperator) + (Lat_Long_Reg[i].getString(key: "DCS_ID"))
                            
                        sb_LAT_LONG_ARR = try sb_LAT_LONG_ARR + (saperator_1) + ( Lat_Long_Reg[i].getString(key:"LAT_LONG"))
                                
                        sb_DCS_TYPE_ARR = try  sb_DCS_TYPE_ARR + (saperator) + (Lat_Long_Reg[i].getString(key : "DCS_TYPE"))
                        
                        sb_DCS_ADD_ARR = try sb_DCS_ADD_ARR + (saperator) + (Lat_Long_Reg[i].getString( key :"DCS_ADD"))
                                        
                       sb_DCS_INDES_ARR = try sb_DCS_INDES_ARR + (saperator) + (Lat_Long_Reg[i].getString(key : "DCS_INDES"))
        
        
                    
                }
            }
        } catch{
            print(error)
        }
        
        map_Lat_Long_Reg["DCS_ID_ARR"] = sb_DCS_ID_ARR
        map_Lat_Long_Reg["LAT_LONG_ARR"] = sb_LAT_LONG_ARR
        map_Lat_Long_Reg["DCS_TYPE_ARR"] = sb_DCS_TYPE_ARR
        map_Lat_Long_Reg["DCS_ADD_ARR"] = sb_DCS_ADD_ARR
        map_Lat_Long_Reg["DCS_INDES_ARR"] = sb_DCS_INDES_ARR
        
        
      
        return map_Lat_Long_Reg;
        }
        
        
        public func get_phdairy_dcr( updated : String? = nil) -> [String: String]{
            
            var map_phdairy_dcr = [String: String]()
            
            var sb_sDAIRY_ID = String();
            var sb_sSTRDAIRY_CPID = String();
            var sb_sDCRDAIRY_LOC = String();
            var sb_sDCRDAIRY_IN_TIME = String();
            var sb_sDCRDAIRY_BATTERY_PERCENT = String();
            var sb_sDCRDAIRY_REMARK = String();
            var sb_sDCRDAIRY_KM = String();
            var sb_sDCRDAIRY_SRNO = String();
            var sb_sDCRDAIRYITEM_DAIRY_ID = String();
            var sb_sDCRDAIRYITEM_ITEM_ID_ARR = String();
            var sb_sDCRDAIRYITEM_QTY_ARR = String();
            var sb_sDCRDAIRYITEM_ITEM_ID_GIFT_ARR = String();
            var sb_sDCRDAIRYITEM_QTY_GIFT_ARR = String();
            var sb_sDCRDAIRYITEM_POB_QTY = String();
            var sb_sDAIRY_FILE = String();
            var sb_sDCRDAIRY_INTERSETEDYN = String();
            var sb_sDAIRY_REF_LAT_LONG = String();
        
            cbohelp = CBO_DB_Helper.shared
        
            let  phdairy_dcr : [[String : String]] = cbohelp.get_phdairy_dcr(updated: updated);
            do {
                
                if(phdairy_dcr.count > 0) {
                    var saperator = "";
                    var saperator_1 = "";
                    for i in 0 ..< phdairy_dcr.count{
                        
                        
                        if (i==0) {
                            saperator = "";
                            saperator_1 = "";
                            
                        } else {
                            saperator = "^";
                            saperator_1="|";
                        }
                        
                        //loc +"@"+locExtra+ "!^" + address
                        sb_sDAIRY_ID = try sb_sDAIRY_ID + (saperator) + (phdairy_dcr[i].getString(key: "DAIRY_ID"))
                        sb_sSTRDAIRY_CPID = try sb_sSTRDAIRY_CPID + (saperator) + (phdairy_dcr[i].getString(key: "person_id"))
                        sb_sDCRDAIRY_LOC = try sb_sDCRDAIRY_LOC + (saperator_1) + (phdairy_dcr[i].getString(key: "dr_latLong")) + "@" + (phdairy_dcr[i].getString(key: "LOC_EXTRA")) + "!^" + (phdairy_dcr[i].getString(key: "dr_address"))
                        sb_sDCRDAIRY_IN_TIME = try sb_sDCRDAIRY_IN_TIME + (saperator) + (phdairy_dcr[i].getString(key: "visit_time"))
                        sb_sDCRDAIRY_BATTERY_PERCENT = try sb_sDCRDAIRY_BATTERY_PERCENT + (saperator) + (phdairy_dcr[i].getString(key: "batteryLevel"))
                        sb_sDCRDAIRY_REMARK = try sb_sDCRDAIRY_REMARK + (saperator) + (phdairy_dcr[i].getString(key: "dr_remark"))
                        
                        sb_sDCRDAIRY_KM = try sb_sDCRDAIRY_KM + (saperator) + (phdairy_dcr[i].getString(key: "dr_km"))
                        sb_sDCRDAIRY_SRNO = try sb_sDCRDAIRY_SRNO + (saperator) + (phdairy_dcr[i].getString(key: "srno"))
                        sb_sDCRDAIRYITEM_DAIRY_ID = try sb_sDCRDAIRYITEM_DAIRY_ID + (saperator) + (phdairy_dcr[i].getString(key: "DAIRY_ID"))
                        sb_sDCRDAIRYITEM_ITEM_ID_ARR = try sb_sDCRDAIRYITEM_ITEM_ID_ARR + (saperator) + (phdairy_dcr[i].getString(key: "allitemid"))
                        
                        sb_sDCRDAIRYITEM_QTY_ARR = try sb_sDCRDAIRYITEM_QTY_ARR + (saperator) + (phdairy_dcr[i].getString(key: "sample"))
                        sb_sDCRDAIRYITEM_ITEM_ID_GIFT_ARR = try sb_sDCRDAIRYITEM_ITEM_ID_GIFT_ARR + (saperator) + (phdairy_dcr[i].getString(key: "allgiftid"))
                        sb_sDCRDAIRYITEM_QTY_GIFT_ARR = try sb_sDCRDAIRYITEM_QTY_GIFT_ARR + (saperator) + (phdairy_dcr[i].getString(key: "allgiftqty"))
                        
                        sb_sDCRDAIRYITEM_POB_QTY = try sb_sDCRDAIRYITEM_POB_QTY + (saperator) + (phdairy_dcr[i].getString(key: "allitemqty"))
                        sb_sDAIRY_FILE = try sb_sDAIRY_FILE + (saperator) + (phdairy_dcr[i].getString(key: "file"))
                        sb_sDCRDAIRY_INTERSETEDYN = try sb_sDCRDAIRY_INTERSETEDYN + (saperator) + (phdairy_dcr[i].getString(key: "IS_INTRESTED"))
                        sb_sDAIRY_REF_LAT_LONG = try sb_sDAIRY_REF_LAT_LONG + (saperator) + (phdairy_dcr[i].getString(key: "Ref_latlong"))
                
                
                    }
             
                }
            
            } catch{
                print(error)
            }
            
            
            map_phdairy_dcr["sDAIRY_ID"] = sb_sDAIRY_ID
            map_phdairy_dcr["sSTRDAIRY_CPID"] = sb_sSTRDAIRY_CPID
            map_phdairy_dcr["sDCRDAIRY_LOC"] = sb_sDCRDAIRY_LOC
            map_phdairy_dcr["sDCRDAIRY_IN_TIME"] = sb_sDCRDAIRY_IN_TIME
            map_phdairy_dcr["sDCRDAIRY_BATTERY_PERCENT"] = sb_sDCRDAIRY_BATTERY_PERCENT
            map_phdairy_dcr["sDCRDAIRY_REMARK"] = sb_sDCRDAIRY_REMARK
            map_phdairy_dcr["sDCRDAIRY_KM"] = sb_sDCRDAIRY_KM
            map_phdairy_dcr["sDCRDAIRY_SRNO"] = sb_sDCRDAIRY_SRNO
            map_phdairy_dcr["sDCRDAIRYITEM_DAIRY_ID"] = sb_sDCRDAIRYITEM_DAIRY_ID
            map_phdairy_dcr["sDCRDAIRYITEM_ITEM_ID_ARR"] = sb_sDCRDAIRYITEM_ITEM_ID_ARR
            map_phdairy_dcr["sDCRDAIRYITEM_ITEM_ID_GIFT_ARR"] = sb_sDCRDAIRYITEM_ITEM_ID_GIFT_ARR
            map_phdairy_dcr["sDCRDAIRYITEM_QTY_GIFT_ARR"] = sb_sDCRDAIRYITEM_QTY_GIFT_ARR
            map_phdairy_dcr["sDCRDAIRYITEM_POB_QTY"] = sb_sDCRDAIRYITEM_POB_QTY
            map_phdairy_dcr["sDAIRY_FILE"] = sb_sDAIRY_FILE
            map_phdairy_dcr["sDCRDAIRYITEM_QTY_ARR"] = sb_sDCRDAIRYITEM_QTY_ARR
            map_phdairy_dcr["sDCRDAIRY_INTERSETEDYN"] = sb_sDCRDAIRY_INTERSETEDYN
            map_phdairy_dcr["sDAIRY_REF_LAT_LONG"] = sb_sDAIRY_REF_LAT_LONG
            return map_phdairy_dcr;
        }

        
}
