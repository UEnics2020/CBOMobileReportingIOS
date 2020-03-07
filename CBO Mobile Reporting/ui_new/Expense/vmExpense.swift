//
//  vmExpense.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 30/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
class vmExpense : CBOViewModel{
    var count: Int = 0
    
    typealias T = IExpense
    
    var view: IExpense?
    
    var cbohelp  : CBO_DB_Helper = CBO_DB_Helper.shared
    var customVariablesAndMethod : Custom_Variables_And_Method!
    private var expense : mExpense!;
    private var IsFinalSubmit = false;
    private var FinalRemark = "";
    
    var MESSAGE_INTERNET_ROOT=1;
    
    
    func onUpdateView(context: UIViewController, view: IExpense) {
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        customVariablesAndMethod.betteryCalculator()
        expense = mExpense();
        
        if (view != nil){
            view.getReferencesById();
            view.setTitle(title: view.getActivityTitle());
            getExpDLL(context: context as! CustomUIViewController);
        }
    }
    
    
    public func setExpense( expense : mExpense){
        if (view != nil){
            view?.setRouteStatus(Status: expense.getROUTE_CLASS());
            view?.setDA(DA: "\( expense.getDA_Amt())");
            //view?.setDAType(expense.getDA_TYPE_Display());
            view?.setManualDA(da: getExpense().getSelectedDA());
            if (getExpense().getSelectedDA().getCode() == ("L")) {
                view?.setTADetail(detail: "Not Applicable");
            }else {
                view?.setTADetail(detail: "\(getExpense().getKm())  Kms *  \( getExpense().getRate().toCurrency(2) )/km");
            }
            //view?.setDistance(expense.getFARE());
            //view?.enableDA(othExpenseDB.get_DA_ACTION_exp_head().size() == 0);
            //view?.ActualDAReqd(expense.getACTUALDA_FAREYN().equalsIgnoreCase("Y"));
            view?.ManualDA_TypeReqd(required: expense.getDA_TYPE_MANUALYN() == ("Y"));
            if (getExpense().getDA_TYPE_MANUALYN() == ("Y")){
                setSelectedDA(da: getExpense().getSelectedDA());
            }
            view?.ManualDAReqd(required: expense.getMANUAL_DAYN() == ("1"));
            view?.ManualTAReqd(required: expense.getTA_TYPE_MANUALYN() == ("1"));
            view?.ManualTAMandetory(required: expense.getMANUAL_TAYN_MANDATORY() == ("1"));
            view?.ManualDistanceReqd(required: expense.getDISTANCE_TYPE_MANUALYN() == ("1"));
            view?.ManualStationReqd(required: expense.getMANUAL_TAYN_STATION() == ("1"));
           // view?.ActualFareReqd(expense.getACTUALFAREYN().equalsIgnoreCase("Y"));
            view?.OnOtherExpenseUpdated(othExpenses: getExpense().getOthExpenses());
            view?.OnTAExpenseUpdated(othExpenses: getExpense().getTA_Expenses());
            view?.OnDAExpenseUpdated(DAExpenses: getExpense().getDA_Expenses());
            view?.OnFinalRemarkReqd(required: IsFormForFinalSubmit());
            view?.updateDAView();

        }
    }
    
    public func setForFinalSubmit( FinalSubmitYN : String){
        IsFinalSubmit = FinalSubmitYN == "exp";
    }
    
    public func IsFormForFinalSubmit() -> Bool{
        return IsFinalSubmit;
    }
    
    
    public func getFinalRemark() -> String{
        return FinalRemark;
    }

    public func setFinalRemark( finalRemark : String) {
        self.FinalRemark = finalRemark;
    }

    public func getExpense() -> mExpense{
        return expense;
    }

    public func UpdateExpense( othExpense : mOthExpense){
        //expense.getOthExpenses().add(othExpense);
        expense.setOthExpenses(othExpenses: cbohelp.get_Expense(For_DA_TA: eExpanse.None));
        expense.setTA_Expenses(TA_Expenses: cbohelp.get_Expense(For_DA_TA: eExpanse.TA));
        expense.setDA_Expenses(DA_Expenses: cbohelp.get_Expense(For_DA_TA: eExpanse.DA));
        view?.enableDA(enable: cbohelp.get_DA_ACTION_exp_head().count == 0);
        view?.OnOtherExpenseUpdated(othExpenses: getExpense().getOthExpenses());
        view?.OnTAExpenseUpdated(othExpenses: getExpense().getTA_Expenses());
        view?.OnDAExpenseUpdated(DAExpenses: getExpense().getDA_Expenses());
        view?.updateDAView();
    }
    
    public func setSelectedDA( da : mDA){
        getExpense().setDA(da: da);

        getExpense().setDistance( distance: mDistance());
        getExpense().setDA_TYPE(DA_TYPE: da.getCode());
        getExpense().setTA_Amt(TA_Amt: da.getTAAmount());
        getExpense().setDA_Amt(DA_Amt: da.getDAAmount());

        getExpense().setDISTANCE_TYPE_MANUALYN(DISTANCE_TYPE_MANUALYN: da.getMANUAL_DISTANCEYN());
        getExpense().setTA_TYPE_MANUALYN(TA_TYPE_MANUALYN: da.getMANUAL_TAYN());
        getExpense().setMANUAL_TAYN_MANDATORY(MANUAL_TAYN_MANDATORY: da.getMANUAL_TAYN_MANDATORY());

        //if (view != nil){
            view?.setManualDA(da: da);
            if (da.getCode() == ("L")) {
                view?.setTADetail(detail: "Not Applicable");
            }

            view?.ManualTAReqd(required: expense.getTA_TYPE_MANUALYN() == ("1"));
            view?.ManualDistanceReqd(required: expense.getDISTANCE_TYPE_MANUALYN() == ("1"));
            view?.updateDAView();
        //}

        setSelectedDistance(distance: getExpense().getSelectedDistance());

        //updateDAView();

    }
    
    
    public func setSelectedDistance( distance : mDistance){
        getExpense().setDistance(distance: distance);
        getExpense().getSelectedDA().setTA_Km(TA_Km: distance.getKm());
        getExpense().getSelectedDA().setTA_Rate(TA_Rate: getExpense().getRateFor(km: getExpense().getSelectedDA().getTA_Km()).getRate());
        getExpense().setTA_Amt( TA_Amt: getExpense().getSelectedDA().getTAAmount());

        if (getExpense().getTA_TYPE_MANUALYN() != "1") {
            getExpense().setTA_TYPE_MANUALYN(TA_TYPE_MANUALYN: distance.getMANUAL_TAYN());
            getExpense().setMANUAL_TAYN_MANDATORY(MANUAL_TAYN_MANDATORY: distance.getMANUAL_TAYN_MANDATORY());
        }

        if (view != nil){
            view?.setTADetail(detail: "\(getExpense().getSelectedDA().getTA_Km())  Kms *  \( getExpense().getSelectedDA().getTA_Rate().toCurrency(2) )/km");
            
            view?.setManualTA(distance: distance);
            view?.ManualTAReqd(required: expense.getTA_TYPE_MANUALYN() == ("1"));
            view?.ManualDistanceReqd(required: expense.getDISTANCE_TYPE_MANUALYN() == ("1"));
            view?.updateDAView();
        }
    }
    
    private func getExpDLL(context : CustomUIViewController){
        //Start of call to service
        
        var params = [String:String]()
        params["sCompanyFolder"] = view?.getCompanyCode() //cbohelp.getCompanyCode()
        params["iPaId"] =  view?.getUserId()
        params["iDcrId"] =  view?.getDCRId()
        
        var tables = [Int]();
        tables.append(0);
        tables.append(1);
        tables.append(2);
        tables.append(3);
        tables.append(4);
        tables.append(5);
        
        view?.showProgess(msg: "Please Wait...")
        
        
        
        CboServices().customMethodForAllServices(params: params, methodName: "DCREXPDDLALLROUTE_MOBILE", tables: tables, response_code: MESSAGE_INTERNET_ROOT, vc : context )
        
        
        
        //End of call to service
    }
    
    
    func parserExpDDl(context : CustomUIViewController ,dataFromAPI : [String : NSArray]) {
           if(!dataFromAPI.isEmpty){
               do {
                   
                   
                   
                   cbohelp.delete_EXP_Head();
                   var expHeadArray = [mExpHead]()
               
                   
                   let jsonArray1 =   dataFromAPI["Tables0"]!
                   
                   for i in 0 ..< jsonArray1.count {
                       
                       let jsonObject1 = jsonArray1[i] as! [String : AnyObject]
                       
                      
                       
                       var expHead = mExpHead(id: try jsonObject1.getInt(key: "ID"),
                                          name: try jsonObject1.getString(key: "FIELD_NAME"))
                       .setEXP_TYPE(EXP_TYPE: eExpanse.getExp(at: try jsonObject1.getInt(key: "CHECKDUPLICATE_HEADTYPE"))!)
                       .setSHOW_IN_TA_DA(SHOW_IN_TA_DA: eExpanse.valueOf(String(try jsonObject1.getInt(key: "SHOWIN_TA_OTHER"))))
                       .setATTACHYN(ATTACHYN: try jsonObject1.getInt(key: "ATTACHYN"))
                       .setDA_ACTION(DA_ACTION: try jsonObject1.getInt(key: "DA_ACTION"))
                       .setMANDATORY(MANDATORY: try jsonObject1.getInt(key: "MANDATORYYN_NEW"))
                       .setMAX_AMT(MAX_AMT: try jsonObject1.getDouble(key: "MAX_AMT"))
                       .setKMYN(KMYN: try jsonObject1.getString(key: "KMYN"))
                       .setHEADTYPE_GROUP(HEADTYPE_GROUP: try jsonObject1.getString(key: "CHECKDUPLICATE_HEADTYPE"))
                       .setMasterValidate(masterValidate: try jsonObject1.getInt(key: "TAMST_VALIDATEYN"))
                       
                       
                       
                       cbohelp.Insert_EXP_Head(expHead: expHead)
                       expHeadArray.append(expHead)
                      
                   }
                   expense.setExpHeads(expHeads: expHeadArray)
//                   if (expense.getExpHeads().count == 0) {
//                       customVariablesAndMethod.msgBox(vc: context,msg: "No ExpHead found...");
//                   }
                   
                   
                   
                     let jsonArray3 =   dataFromAPI["Tables2"]!
                     var object = [String : AnyObject]()
                    for i in 0 ..< jsonArray3.count {
                       
                       object = jsonArray3[i] as! [String : AnyObject]


                       try expense.setDA_TYPE(DA_TYPE: object.getString(key: "DA_TYPE_NEW"))
                           .setDA_TYPE_Display(DA_TYPE_Display: object.getString(key: "DA_TYPE"))
                           .setDA_TYPE_MANUALYN(DA_TYPE_MANUALYN: object.getString(key: "DA_TYPE_MANUALYN"))
                           .setFARE(FARE: object.getString(key: "FARE"))
                           .setTA_TYPE_MANUALYN(TA_TYPE_MANUALYN: object.getString(key: "MANUAL_TAYN"))
                           .setKm(km: object.getDouble(key: "KM_NEW"))
                           .setRate(rate: object.getDouble(key: "FARE_RATE_NEW"))
                           .setMANUAL_DAYN(MANUAL_DAYN: object.getString(key: "MANUAL_DAYN"))
                           .setMANUAL_TAYN_KM(MANUAL_TAYN_KM: object.getString(key: "MANUAL_TAYN_KM"))
                           .setMANUAL_TAYN_STATION(MANUAL_TAYN_STATION: object.getString(key: "MANUAL_TAYN_STATION"))
                           .setMANUAL_TAYN_MANDATORY(MANUAL_TAYN_MANDATORY: object.getString(key: "MANUAL_TAYN_MANDATORY"))
                           .setDA_Amt(DA_Amt: object.getDouble(key: "DA_RATE_NEW"))
                           .setTA_Amt(TA_Amt: object.getDouble(key: "TA_AMT_NEW"))
                           .setACTUALDA_FAREYN(ACTUALDA_FAREYN: object.getString(key: "ACTUALDA_FAREYN"))
                           .setACTUALFAREYN(ACTUALFAREYN: object.getString(key: "ACTUALFAREYN"))
                           .setROUTE_CLASS(ROUTE_CLASS: object.getString(key: "ROUTE_CLASS"))
                           .setACTUALFARE_MAXAMT(ACTUALFARE_MAXAMT: object.getDouble(key: "ACTUALFARE_MAXAMT"))
                           .setACTUALFAREYN_MANDATORY(ACTUALFAREYN_MANDATORY: object.getString(key: "ACTUALFAREYN_MANDATORY"));
                   }

                   
                   if object != nil {
                       //expense.getRates().removeAll()
                       
                       //
                       var rates = [mRate]()
                       
                       rates.append(mRate().setRate(rate: try object.getDouble(key: "FARE_RATE")))
                       
                       if (try object.getDouble(key: "FARE_RATE_KM") != 0 && object.getDouble(key: "FARE_RATE1_KM") != 0){
                           rates[0].setTKm(TKm: try object.getDouble(key: "FARE_RATE_KM"));
                       }
                       
                       rates.append(mRate().setRate(rate: try object.getDouble(key: "FARE_RATE1")))
                       
                       if (try object.getDouble(key: "FARE_RATE1_KM") != 0 && object.getDouble(key: "FARE_RATE2_KM") != 0){
                           rates[1].setFKm(FKm: try object.getDouble(key: "FARE_RATE1_KM"));
                           rates[1].setTKm(TKm: try object.getDouble(key: "FARE_RATE2_KM"));
                       }
                       
                       rates.append(mRate().setRate(rate: try object.getDouble(key: "FARE_RATE2")))
                       
                       if (try object.getDouble(key: "FARE_RATE2_KM") != 0 && object.getDouble(key: "FARE_RATE3_KM") != 0){
                           rates[2].setFKm(FKm: try object.getDouble(key: "FARE_RATE1_KM"));
                           rates[2].setTKm(TKm: try object.getDouble(key: "FARE_RATE2_KM"));
                       }
                       
                       rates.append(mRate().setRate(rate: try object.getDouble(key: "FARE_RATE3")))
                       
                       expense.setRates(rates: rates)
                       
                      
                   }

                   
                   
                   
                   
                   //expense.getDAs().removeAll()
                   
                   let jsonArray4 =   dataFromAPI["Tables3"]!
                   var object1 = [String : AnyObject]()
                   var das = [mDA]()
                   for i in 0 ..< jsonArray4.count {
                                      
                       object1 = jsonArray4[i] as! [String : AnyObject]
                   
                       var da = mDA()
                       da.setCode(code: try object1.getString(key: "FIELD_CODE"));
                       da.setName(name: try object1.getString(key: "FIELD_NAME"));
                       da.setMultipleFactor(multipleFactor: try object1.getDouble(key: "FARE_MULT_BY"));
                       da.setMANUAL_DISTANCEYN(MANUAL_DISTANCEYN: try object1.getString(key: "MANUAL_DISTANCEYN"));
                       da.setMANUAL_TAYN(MANUAL_TAYN: try object1.getString(key: "MANUAL_TAYN"));
                       da.setMANUAL_TAYN_MANDATORY(MANUAL_TAYN_MANDATORY: try object1.getString(key: "MANUAL_TAYN_MANDATORY"));

                       if (object != nil) {
                           da.setTA_Km(TA_Km: try object.getDouble(key: "KM_SINGLE_SIDE"));
                           da.setTA_Rate(TA_Rate: try object.getDouble(key: "FARE_RATE"));
                           switch (da.getCode()) {
                               case "L":
                                   da.setDAAmount(DAAmount: try object.getDouble(key: "DA_L_RATE"));
                                   break;
                               case "EX": break
                               case "EXS":
                                   da.setDAAmount(DAAmount: try object.getDouble(key: "DA_EX_RATE"));
                                   break;
                               case "NS": break
                               case "NSD":
                                   da.setDAAmount(DAAmount: try object.getDouble(key: "DA_NS_RATE"));
                                   break;
                           
                           default:
                               break
                           }
                       }
                       
                       if (expense.getDA_TYPE().elementsEqual(da.getCode())){
                           //view?.setManualDA(da);
                           expense.setDA(da: da);
                           
                       }

                       das.append(da);
                       
                   }
                   expense.setDAs(DAs: das)
                   
                   
                   //expense.getDistances().removeAll()
                   let jsonArray5 =   dataFromAPI["Tables4"]!
                   var mdis = [mDistance]()
                   for i in 0 ..< jsonArray5.count {
                                      
                       var object1 = jsonArray5[i] as! [String : AnyObject]
                       var distance = mDistance();
                       distance.setId(id: try object1.getString(key: "DISTANCE_ID"));
                       distance.setName(name: try object1.getString(key: "STATION_NAME"));
                       distance.setKm(km: try object1.getDouble(key: "KM"));
                       distance.setMANUAL_TAYN(MANUAL_TAYN: try object1.getString(key: "MANUAL_TAYN"));
                       distance.setMANUAL_TAYN_MANDATORY(MANUAL_TAYN_MANDATORY: try object1.getString(key: "MANUAL_TAYN_MANDATORY"));

                       
                       mdis.append(distance)
                   }
                   expense.setDistances(distances: mdis)
                   
                   
                   let jsonArray6 =   dataFromAPI["Tables5"]!
                    var mOther = [mOthExpense]()
                   for i in 0 ..< jsonArray6.count {
                                                     
                       var object1 = jsonArray6[i] as! [String : AnyObject]

                       var othExpense = mOthExpense()
                       othExpense.setId(id: try object1.getInt(key: "ID"))
                       
                       othExpense.setExpHead(expHead: mExpHead(id: try object1.getInt(key: "EXP_HEAD_ID"), name: try object1.getString(key: "HEAD_NAME")).setSHOW_IN_TA_DA(SHOW_IN_TA_DA: eExpanse.getExp(at: try object1.getInt(key: "TA_DA"))!))
                       
                      
                       othExpense.setAmount(amount: try object1.getDouble(key: "AMOUNT"))
                       .setAttachment(attachment: try object1.getString(key: "FILE_NAME"))
                       .setEditable(edit: try object1.getInt(key: "EDITDELETEYN")==1);
    
                       mOther.append(othExpense)

                       cbohelp.Insert_EXP_Head(expHead: othExpense.getExpHead())
                       
                       cbohelp.insert_Expense(othExpense: othExpense);
                   }
                   
                   
                   expense.setOthExpenses( othExpenses: cbohelp.get_Expense(For_DA_TA: eExpanse.None));
                   expense.setTA_Expenses( TA_Expenses: cbohelp.get_Expense(For_DA_TA: eExpanse.TA));
                   expense.setDA_Expenses( DA_Expenses: cbohelp.get_Expense(For_DA_TA: eExpanse.DA));
                   
                   setExpense(expense: expense );
                   //                sm = new Expenses_Adapter(NonWorking_DCR.this, data);
                   //                show_exp.setAdapter(sm);
                   //init_DA_type();
                   //progressHUD.dismiss();
               } catch  {
                   //Log.d("MYAPP", "objects are: " + e.toString());
                   customVariablesAndMethod.getAlert(vc: context,title: "Missing field error", msg: error.localizedDescription)   //getResources().getString(R.string.service_unavilable) +e.toString());
                   
                   
                   let dataDict = ["Error Alert : ":"Missing field error \n \(error.localizedDescription )"]
                   
                   let objBroadcastErrorMail = BroadcastErrorMail(dataDict: dataDict, mailSubject: "\(error.localizedDescription )", vc: context)
                   
                   objBroadcastErrorMail.requestAuthorization()
               }
           }
           //Log.d("MYAPP", "objects are1: " + result);
           //progressHUD.dismiss()
       }
    
}
