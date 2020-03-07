//
//  IExpense.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 30/11/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import UIKit
public protocol IExpense : class {
    func showProgess(msg : String);
    func hideProgess();
    func getCompanyCode() -> String;
    func getDCRId() -> String;
    func getUserId() -> String;
    func getReferencesById();
    func getActivityTitle() -> String;
    func setTitle(title: String)
    func IsRouteWise() ->Bool;
    func setRouteStatus(Status: String);
    func setDA(DA: String);
    func setManualDA(da: mDA);
    func setManualTA(distance: mDistance);
    func setDAType(type: String);
    func setTADetail(detail: String);
    func updateDAView();
    func setDistance(Distance: String);
    func enableDA(enable: Bool);
    func ActualDAReqd(required: Bool);
    func ManualDA_TypeReqd(required: Bool);
    func ManualDAReqd(required: Bool);
    func ManualTAReqd(required: Bool);
    func ManualTAMandetory(required: Bool);
    func ManualStationReqd(required: Bool);
    func ManualDistanceReqd(required: Bool);
    func ActualFareReqd(required: Bool);
    func OnAddExpense(expense: mExpense, othExpense: mOthExpense, eExpense: eExpanse);
    func OnOtherExpenseAdded(othExpense: mOthExpense);
    func OnOtherExpenseUpdated(othExpenses: [mOthExpense]);
    func OnTAExpenseAdded(othExpense: mOthExpense);
    func OnTAExpenseUpdated(othExpenses: [mOthExpense]);
    func OnDAExpenseAdded(DAExpense: mOthExpense);
    func OnDAExpenseUpdated(DAExpenses: [mOthExpense]);
    func OnFinalRemarkReqd(required: Bool);
    func OnExpenseCommit();
    func OnExpenseCommited();
}
