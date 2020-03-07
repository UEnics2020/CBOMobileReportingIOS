//
//  mDCR.swift
//  CBO Mobile Reporting
//
//  Created by CBO IOS on 21/02/19.
//  Copyright © 2019 Javed Hussain. All rights reserved.
//

import Foundation
public class mDCR {
    private var Id : String!; //DCR_ID
    private var Date : String!; //DCR_DATE
    private var DisplayDate : String!; //DATE_NAME
    private var Planed_Date : String!; //Dcr_Planed_Date  i.e Date
    private var DateOnMobile : String!; //dcr_date_real
    private var WorkTypeId : String!; //working_code
    private var WorkType : String!; //working_head
    
    
    private var WorkWithTitle : String!; //WW_TITLE
    private var ShowWorkWithAsPerTP : String!; //DCR_LOCKWW
    private var DiverWorkWith : String!; //DIVERTWWYN
    private var WorkWithArr : String!; //route_Ww_Name
    private var WorkWithIdArr : String!; //route_Ww_ID
    private var WorkWithIndividualId : String!;
    private var WorkWithIndividual : String!; //work_with_individual_name
    
    private var DivertRoute : String!; //ROUTEDIVERTYN
    private var DivertRemark : String!; //sDivert_Remark
    private var RouteTitle : String!; //ROUTE_TITLE
    private var ShowRouteAsPerTP : String!; //DCR_TP_AREA_AUTOYN
    private var RouteArr : String!; //route_Route_Name
    private var RouteIdArr : String!;
    
    private var AreaReq : String!; //DCR_ADDAREANA
    private var NoOfAddAreaAlowed : String! ; //DCR_NOADDAREA
    private var AreaTitle : String!; //AREA_TITLE
    private var AreaArr : String!; //area_name
    private var AreaIdArr : String!;
    
    private var ApprovalMsg : String!; //APPROVAL_MSG
    private var PlanTimeDiffererence_Server  : String!; //DcrPlanTime_server
    
    private var Backdate : String!;  //IsBackDate
    private var BackDateReason : String!; //BackDateReason
    
    private var AdditionalAreaApprovalReqd : String!; //ADDAREA_APPYN
    
  
    ///getter
    public func getId() -> String{
    if (Id == nil){
        Id = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DCR_ID",defaultValue: "0");
    }
    return Id;
    }
    
    public func getDate()  -> String{
    if (Date == nil){
        Date = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DCR_DATE",defaultValue: "0");
    }
    return Date;
    }
    
    public func getDisplayDate() -> String {
    if (DisplayDate == nil){
        DisplayDate = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DATE_NAME",defaultValue: "0");
    }
    return DisplayDate;
    }
    
    public func getWorkTypeId() -> String {
    return WorkTypeId;
    }
    
    public func getWorkType()  -> String{
    return WorkType;
    }
    
    public func getDiverWorkWith() -> String {
    return DiverWorkWith;
    }
    
    public func getWorkWithTitle()  -> String{
    if (WorkWithTitle == nil){
        WorkWithTitle = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "WW_TITLE",defaultValue: "Work-With");
    }
    return WorkWithTitle;
    }
    
    public func getWorkWithArr() -> String {
    return WorkWithArr;
    }
    
    public func getWorkWithIdArr()  -> String{
    return WorkWithIdArr;
    }
    
    public func getDivertRoute()  -> String{
    return DivertRoute;
    }
    
    public func getRouteTitle()  -> String{
    if (RouteTitle == nil){
        RouteTitle = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "ROUTE_TITLE",defaultValue: "Route List");
    }
    return RouteTitle;
    }
    
    public func getRouteArr()  -> String{
    return RouteArr;
    }
    
    public func getRouteIdArr()  -> String{
    return RouteIdArr;
    }
    
    public func getAreaReq() -> String {
    return AreaReq;
    }
    
    public func getAreaTitle()  -> String{
    if (AreaTitle == nil){
        AreaTitle = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "AREA_TITLE",defaultValue: "Area List");
    }
    return AreaTitle;
    }
    
    public func getAreaArr()  -> String{
    return AreaArr;
    }
    
    public func getAreaIdArr()  -> String{
    return AreaIdArr;
    }
    
    public func getPlaned_Date() -> String {
    return Planed_Date;
    }
    
    public func getDateOnMobile()  -> String{
    return DateOnMobile;
    }
    
    public func getShowWorkWithAsPerTP() -> String {
    if (ShowWorkWithAsPerTP == nil){
        ShowWorkWithAsPerTP = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DCR_LOCKWW",defaultValue: "");
    }
    return ShowWorkWithAsPerTP;
    }
    
    public func getShowRouteAsPerTP()  -> String{
    if (ShowRouteAsPerTP == nil){
        ShowRouteAsPerTP = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DCR_TP_AREA_AUTOYN",defaultValue: "");
    }
    return ShowRouteAsPerTP;
    }
    
    public func getNoOfAddAreaAlowed() -> String {
    if (NoOfAddAreaAlowed == nil){
        NoOfAddAreaAlowed = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "DCR_NOADDAREA",defaultValue: "");
    }
    return NoOfAddAreaAlowed;
    }
    
    public func getAdditionalAreaApprovalReqd()  -> String{
    if (AdditionalAreaApprovalReqd == nil){
        AdditionalAreaApprovalReqd = Custom_Variables_And_Method.getInstance().getDataFrom_FMCG_PREFRENCE(key: "ADDAREA_APPYN",defaultValue: "");
    }
    return AdditionalAreaApprovalReqd;
    }
    ///setter
    
    
    public func setId( id  : String) -> mDCR{
        Id = id.isEmpty ?"0":id.trimmingCharacters(in: .whitespacesAndNewlines);
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DCR_ID",value: Id);
        return self;
    }
    
    public func setDate( date : String)-> mDCR {
        Date = date;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DCR_DATE",value: date);
        return self;
    }
    
    public func setDisplayDate( displayDate : String) -> mDCR{
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DATE_NAME",value: displayDate);
        DisplayDate = displayDate;
        return self;
    }
    
    public func setWorkTypeId( workTypeId : String) -> mDCR{
        WorkTypeId = workTypeId;
        return self;
    }
    
    public func setWorkType( workType : String) -> mDCR{
        WorkType = workType;
        return self;
    }
    
    public func setDiverWorkWith( diverWorkWith : String) -> mDCR{
        DiverWorkWith = diverWorkWith;
        return self;
    }
    
    public func setWorkWithTitle( workWithTitle : String) -> mDCR{
        WorkWithTitle = workWithTitle;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "WW_TITLE",value: workWithTitle);
        return self;
    }
    
    public func setWorkWithArr( workWithArr : String)-> mDCR {
        WorkWithArr = workWithArr;
        return self;
    }
    
    public func setWorkWithIdArr( workWithIdArr : String)-> mDCR {
        WorkWithIdArr = workWithIdArr;
        return self;
    }
    
    public func setDivertRoute( divertRoute : String) -> mDCR{
        DivertRoute = divertRoute;
        return self;
    }
    
    public func setRouteTitle( routeTitle  : String)-> mDCR {
        RouteTitle = routeTitle;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "ROUTE_TITLE",value: RouteTitle);
        return self;
    }
    
    public func setRouteArr( routeArr  : String)-> mDCR {
        RouteArr = routeArr;
        return self;
    }
    
    public func setRouteIdArr( routeIdArr : String) -> mDCR{
        RouteIdArr = routeIdArr;
        return self;
    }
    
    public func setAreaReq( areaReq : String) -> mDCR{
        AreaReq = areaReq;
        return self;
    }
    
    public func setAreaTitle( areaTitle  : String)-> mDCR {
        AreaTitle = areaTitle;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "AREA_TITLE",value: areaTitle);
        return self;
    }
    
    public func setAreaArr( areaArr : String)-> mDCR {
        AreaArr = areaArr;
        return self;
    }
    
    public func setAreaIdArr( areaIdArr : String)-> mDCR {
        AreaIdArr = areaIdArr;
        return self;
    }
    
    public func setPlaned_Date( planed_Date : String)-> mDCR {
        Planed_Date = planed_Date;
        return self;
    }
    
    public func setDateOnMobile( dateOnMobile  : String)-> mDCR {
        DateOnMobile = dateOnMobile;
        return self;
    }
    
    public func setShowWorkWithAsPerTP( showWorkWithAsPerTP : String)-> mDCR {
        ShowWorkWithAsPerTP = showWorkWithAsPerTP;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DCR_LOCKWW",value: ShowWorkWithAsPerTP);
        return self;
    }
    
    public func setShowRouteAsPerTP( showRouteAsPerTP : String)-> mDCR {
        ShowRouteAsPerTP = showRouteAsPerTP;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DCR_TP_AREA_AUTOYN",value: ShowRouteAsPerTP);
        return self;
    }
    
    public func setNoOfAddAreaAlowed( noOfAddAreaAlowed : String) -> mDCR{
        NoOfAddAreaAlowed = noOfAddAreaAlowed.trimmingCharacters(in: .whitespacesAndNewlines) == ("") ? "0":noOfAddAreaAlowed.trimmingCharacters(in: .whitespacesAndNewlines);
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "DCR_NOADDAREA",value: NoOfAddAreaAlowed);
        return self;
    }
    
    public func setAdditionalAreaApprovalReqd( additionalAreaApprovalReqd : String) -> mDCR{
        AdditionalAreaApprovalReqd = additionalAreaApprovalReqd;
        Custom_Variables_And_Method.getInstance().setDataInTo_FMCG_PREFRENCE(key: "ADDAREA_APPYN",value: additionalAreaApprovalReqd);
        return self;
    }
}

