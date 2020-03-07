////
////  CBO_DB_Helper.swift
////  CBOMobileReporting
////
////  Created by rahul sharma on 09/12/17.
////  Copyright © 2017 rahul sharma. All rights reserved.
////
//
import SQLiteMigrationManager
import SQLite
import SQLite3
class CBO_DB_Helper {
    
    static var shared : (CBO_DB_Helper) {
        if Instance == nil{
            Instance = CBO_DB_Helper()
        }
        return Instance!
    }
    
    static private var Instance : CBO_DB_Helper?
    //    static func getInstance() -> CBO_DB_Helper{
    //        if Instance == nil{
    //            Instance = CBO_DB_Helper()
    //        }
    //        return Instance!
    //    }
    public var connection : Connection?
    var customVariablesAndMethod : Custom_Variables_And_Method! = nil
    
    let dbVersion = 48
    var old_dbVersion : Int = 0
    
    
    //tables
    
    
    private static let DATABASE_NAME = "cbodb0017";
    private static let LOGIN_TABLE = "cbo_login";
    private static let LOGIN_DETAILS = "logindetail";
    private static let DOCTOR_ITEM_TABLE = "phdcritem";
    private static let PH_ITEM_TABLE = "phitem";
    private static let PH_DOCTOR_TABLE = "phdoctor";
    private static let PH_CHEMIST_TABLE = "phchemist";
    private static let PH_DOCTOR_ITEM_TABLE = "phdoctoritem";
    private static let Dr_PRESCRIBE = "drprescribe";
    private static let PH_LAT_LONG = "phlatlong";
    private static let PH_Farmer = "PHFarmer";
    private static let PH_RCPA = "ph_rcpa";
    public static  let myTable = "lat_lon_details";
    public static let myTable1MinuteLatLong = "lat_lon_oneminute";
    public static let DR_RX_TABLE = "dr_rx_table";
    public static let MenuControl = "menu_contorl";
    
    public static let Expenses = "Expenses";
    public static let Notification = "Notification";
    public static let Approval_count = "Approval_count";
    public static let NonListed_call = "NonListed_call";
    
    public static let latLong10Minute = "lat_lon_TenMinute";
    public static let Mail = "mail";
    public static let Appraisal = "Appraisal";
    public static let dob_doa = "dob_doa";
    public static let Expenses_head = "Expenses_head";
    public static let Tenivia_traker = "Tenivia_traker";
    public static let Doctor_Call_Remark = "Doctor_Call_Remark";
    public static let Lat_Long_Reg = "Lat_Long_Reg";
    
    public static let UserDetails = "userdetail"
    public static let UserDetails2 = "userdetail2"
    public static let DCRRetail = "dcrdetail"
    public static let MYDCR = "mydcr"
    public static let Resigned = "resigned"
    public static let Final_DCR_check = "finaldcrcheck"
    public static let Chemist_Temp = "chemisttemp"
    public static let Chemist_Sample = "chemistsample"
    public static let PH_Dcr_chem = "phdcrchem"
    public static let PH_Dcr_stk = "phdcrstk"
    public static let Temp_Stockist = "tempstockist"
    public static let PH_Dcr_Dr_rc = "phdcrdr_rc"
    public static let Temp_Dr = "tempdr"
    public static let PH_Dcr_Dr = "phdcrdr"
    public static let PH_Dcr_Dr_more = "phdcrdr_more"
    public static let PH_All_Mst = "phallmst"
    public static let PH_item_spl = "phitemspl"
    public static let PH_Relation = "phrelation"
    public static let FTP_Detail = "ftpdetail"
    public static let PH_Party = "phparty"
    public static let Utils = "utils"
    public static let Version = "version"
    public static let Dr_WorkWith = "dr_workwith"
    
    // MARK:- db v 25
    public static let PH_DAIRY = "PHDAIRY"
    public static let PH_DAIRY_PERSON = "PHDAIRY_PERSON"
    public static let PH_DAIRY_REASON = "PHDAIRY_REASON"
    public static let PH_DAIRY_DCR = "PHDAIRY_DCR"
    
    
    public static let PH_ITEM_STOCK_DCR = "PHITEM_STOCK_DCR";
    public static let PH_DCR_ITEM = "PH_DCR_ITEM";
    public static let VSTOCK = "VSTOCK";
    public static let PH_STK_ITEM_RATE = "PH_STK_ITEM_RATE";
    public static let VISUAL_ADD_DOWNLOAD = "VADownload";
    
    
    
    // table create querys
    
    
    let CREATE_LOGIN = "CREATE TABLE " + LOGIN_TABLE + " ( myid INTEGER PRIMARY KEY,code TEXT, username TEXT,password TEXT,pin TEXT)"
    
    let CREATE_LOGIN_DETAIL = "CREATE TABLE " + LOGIN_DETAILS + " ( myid INTEGER PRIMARY KEY,company_code text,ols_ip TEXT, ols_db_name TEXT,ols_db_user TEXT,ols_db_password TEXT,ver text,domain text)"
    
    let CREATE_USER_DETAIL = "CREATE TABLE " + UserDetails + " ( id integer primary key,pa_id integer,pa_name text,head_qtr text,desid text,pub_desig_id text,compny_name text,web_url text)"
    
    let CREATE_USER_DETAIL2 = "CREATE TABLE " + UserDetails2 + " ( id integer primary key,location_required text,visual_required text)";
    
    let DCR_TABLE = "CREATE TABLE " + DCRRetail + " ( id integer primary key,dcr_id text,pub_area text)";
    
    let CREATE_DOCTOR_SAMPLE = "CREATE TABLE " + DOCTOR_ITEM_TABLE + " (id integer primary key,dr_id text,item_id text,item_name text,qty text,pob text,stk_rate text,visual text, updated text, noc  text DEFAULT '0')";
    
    let CREATE_DR_RX_TABLE = "CREATE TABLE " + DR_RX_TABLE + " (id integer primary key, dr_id text,item_id text)";
    
    let CREATE_DOCTOR_PRESCRIBE = "CREATE TABLE " + Dr_PRESCRIBE + "(id integer primary key,dr_id text,item_id text,item_name text,qty text,pob text,stk_rate text,visual text)";
    
    let PH_ITEM = "CREATE TABLE " + PH_ITEM_TABLE + " ( id integer primary key,item_id text,item_name text,stk_rate double,gift_type text,SHOW_ON_TOP text,SHOW_YN text,SPL_ID integer,GENERIC_NAME text,BRAND_NAME text,BRAND_ID text)";
    
    let PH_DOCTOR_IETM = "CREATE TABLE " + PH_DOCTOR_ITEM_TABLE + " ( id integer primary key,dr_id integer,item_id integer,item_name text)";
    
    let ALLMST = "CREATE TABLE " + PH_All_Mst + " ( id integer primary key,allmst_id integer,table_name text,field_name text,remark text )";
    
    let PARTY = "CREATE TABLE " + PH_Party + " ( id integer primary key,pa_id integer,pa_name text,desig_id integer,category text,hq_id integer,PA_LAT_LONG text,PA_LAT_LONG2 text,PA_LAT_LONG3 text,SHOWYN text)";
    
    let RELATION = "CREATE TABLE " + PH_Relation + " (id integer primary key,pa_id integer,under_id integer,rank integer)";
    
    let ITEM_SPL = "CREATE TABLE " + PH_item_spl + " (id integer primary key,item_id text,dr_spl_id text,srno integer)";
    
    let DCR_CHK = "CREATE TABLE finaldcrcheck ( id integer primary key,chemist text,stockist text,exp text)";
    
    let FTP_TABLE = "CREATE TABLE " + FTP_Detail + " ( id integer primary key,ftpip text,username text,password text,port text,path text,ftpip_download text,username_download text,password_download text,port_download text)";
    
    let STOCKIST_ADD_TABLE = "CREATE TABLE " + Temp_Stockist + " ( id integer primary key,stk_id integer,stk_name text,visit_time text,stk_latLong text)";
    
    let CHEMIST_SAMPLE_TABLE = "CREATE TABLE " + Chemist_Sample + " ( id integer primary key,chem_id text,item_id text,item_name text,qty text,sample text)";
    
    let STOCKIST_SAMPLE_TABLE = "CREATE TABLE stksample ( id integer primary key,stk_id text,item_id text,item_name text,qty text)";
    
    let Util_TABLE = "CREATE TABLE " + Utils + " ( id integer primary key,pub_area text)";
    
    let VERSION_TABLE = "CREATE TABLE " + Version + " ( id integer primary key,ver text)";
    
    let WORK_WITH_TABLE = "CREATE TABLE " + Dr_WorkWith + " ( id integer primary key,workwith text,wwid text)";
    
    let FMCG_STATUS = "CREATE TABLE fmcg_status ( id integer primary key,fmcg text)";
    
    let DCR_ID = "CREATE TABLE mydcr ( id integer primary key,dcr_id text)";
    
    let RESIGNED = "CREATE TABLE " + Resigned + " ( id integer primary key,user_name text,password text,doryn text,dosyn text)";
    
    let LOCATION_TABLE = "CREATE TABLE location ( id integer primary key,pa_id text,latitude text,longitude text,time text,date text)";
    
    let Apprisal_TABLE = "CREATE TABLE apprisal ( id integer primary key,graid_id text,grade_name text)";
    
    let Apprisal_VALUE_TABLE = "CREATE TABLE apprisal_val ( id integer primary key,dr_id text,dr_name text)";
    
    let Lat_Long_Data = "CREATE TABLE " + PH_LAT_LONG + " (id integer primary key autoincrement,latitude double,longitude double,time text)";
    
    let PH_Farmar = "CREATE TABLE " + PH_Farmer + " (id integer primary key autoincrement,date text,mcc_owner_name text,Mcc_owner_no text,farmer_attendence text,group_meeting_place text,product_detail text,IH_staff_attendence text,sale_to_farmer text,order_book_for_mcc text,remark text)";
    
    let myRepa = "CREATE TABLE " + PH_RCPA + " (id integer primary key autoincrement,dcr_id text,paid text,drid text,chemid text,month text,itemid text,qty text)";
    
    let CREATE_TABLE_LAT_LON = "CREATE TABLE " + myTable + " (id Integer PRIMARY KEY AUTOINCREMENT,lat text,lon text,time text )";
    
    let CREATE_TABLE_LAT_LON_ONEMINUTE = "CREATE TABLE " + myTable1MinuteLatLong + " (id Integer PRIMARY KEY AUTOINCREMENT,lat text,lon text,time text )";
    
    let CREATE_TABLE_MENU_CONTROL = "CREATE TABLE " + MenuControl + " (id Integer PRIMARY KEY AUTOINCREMENT,menu text,menu_code text,menu_name text,menu_url text,main_menu_srno text)";
    
    let CREATE_TABLE_Notification = "CREATE TABLE " + Notification + " (id Integer PRIMARY KEY AUTOINCREMENT,Title text,msg text,logo_url text,content_url text,read_status text,date text,time text)";
    
    let CREATE_TABLE_Approval_count = "CREATE TABLE " + Approval_count + " (id Integer PRIMARY KEY AUTOINCREMENT,approval_menu_code text,approval_count text)";
    
    let CHEMIST_TABLE = "CREATE TABLE \(PH_CHEMIST_TABLE) ( id integer primary key,chem_id integer,chem_name text,area text,chem_code text,LAST_VISIT_DATE text,DR_LAT_LONG text,DR_LAT_LONG2 text,DR_LAT_LONG3 text,SHOWYN text)";
    
    let CREATE_TABLE_Expenses = "CREATE TABLE " + Expenses + " (id Integer PRIMARY KEY AUTOINCREMENT,exp_head_id text,exp_head text,amount text,remark text,FILE_NAME text,exp_ID text,time text,km text,editable Integer)";
    
    let CREATE_TABLE_NonListed_call = "CREATE TABLE " + NonListed_call + " (id Integer PRIMARY KEY AUTOINCREMENT,sDocType text,sDrName text,sAdd1 text,sMobileNo text,sRemark text,iSplId text,iSpl text,iQflId text,iQfl text,iSrno text,loc text,time text,CLASS text,POTENCY_AMT text,AREA text)";
    
    let MASTER_DOCTOR = "CREATE TABLE \(PH_DOCTOR_TABLE) ( id integer primary key,dr_id integer,dr_name text,dr_code text,area text,spl_id integer,LAST_VISIT_DATE text" +
    ",CLASS text,PANE_TYPE text,POTENCY_AMT text,ITEM_NAME text,ITEM_POB text,ITEM_SALE text,DR_AREA text,DR_LAT_LONG text,FREQ text,NO_VISITED text,DR_LAT_LONG2 text,DR_LAT_LONG3 text,COLORYN text,CRM_COUNT text,DRCAPM_GROUP text,SHOWYN text,RXGENYN text,APP_PENDING_YN text )";
    
    let DOCTOR_IN_LOCAL = "CREATE TABLE " + PH_Dcr_Dr_more + " ( id integer primary key,dr_id text,dr_name text,ww1 text,ww2 text,ww3 text,loc text,time text)";
    
    let CREATE_TABLE_LAT_LON_TEN = "CREATE TABLE " + latLong10Minute + " (id Integer PRIMARY KEY AUTOINCREMENT,lat text,lon text,time text,km text,updated text ,LOC_EXTRA text)";
    
    let CHEMIST_ADD_TABLE = "CREATE TABLE " + Chemist_Temp + " ( id integer primary key,chem_id integer,chem_name text,visit_time text,chem_latLong text,chem_address text,updated text,chem_km text,srno text,LOC_EXTRA text)";
    
    let RC_CHEM = "CREATE TABLE phdcrchem_rc ( id integer primary key,dcr_id text,chem_id text,address text,time text,latLong text,updated text,rc_km text,srno text,battery_level text,remark text,file text,LOC_EXTRA text,Ref_latlong text)";

    
    let CREATE_DOCTOR = "CREATE TABLE " + PH_Dcr_Dr + " ( myid2 INTEGER PRIMARY KEY,dr_id TEXT,dr_name TEXT,work_with1 TEXT,work_with2 TEXT,work_with3 TEXT,location TEXT,time TEXT,flag TEXT,LOC_EXTRA text)";
    
    let tempdr = "CREATE TABLE " + Temp_Dr +  " ( id integer primary key,dr_id text,dr_name text,visit_time text,batteryLevel text,dr_latLong text,dr_address text,dr_remark text,updated text,dr_km text,srno text,work_with_name text,DR_AREA text,file text,call_type text,LOC_EXTRA text,Ref_latlong text)";
    
    let RC_DOCTOR = "CREATE TABLE " + PH_Dcr_Dr_rc + " ( id integer primary key,dcr_id text,dr_id text,address text,time text,latLong text,updated text,rc_km text,srno text,batteryLevel text,remark text,file text,LOC_EXTRA text,Ref_latlong text)";
    
    let CHEMIST_SUBMIT_TABLE = "CREATE TABLE " + PH_Dcr_chem + " ( id integer primary key,dcr_id text,chem_id text,pob_amt text,allitemid text,allitemqty text,address text,allgiftid text,allgiftqty text,time text,battery_level text,sample text,remark text,file text,LOC_EXTRA text,Ref_latlong text,rate text,status text,Competitor_Product text)";
    
    let STOCKIST_SUBMIT_TABLE = "CREATE TABLE " + PH_Dcr_stk + " ( id integer primary key,dcr_id integer,stk_id text,pob_amt text,allitemid text,allitemqty text,address text,time text,battery_level text,latLong text,updated text,stk_km text,srno text,sample text,remark text,file text,LOC_EXTRA text,allgiftqty text,allgiftid text,Ref_latlong text,rate text)";
    
    
    
    //    String STOCKIST_SUBMIT_TABLE = "CREATE TABLE phdcrstk ( id integer primary key,dcr_id integer,stk_id text,pob_amt text,allitemid text,allitemqty text,address text,time text,battery_level text,latLong text,updated text,stk_km text,srno text,sample text,remark text,file text,LOC_EXTRA text,allgiftid text,allgiftqty text)";
    
    
    let MAIL_TABLE = "CREATE TABLE " + Mail + " ( id integer primary key,mail_id integer,who_id text,who_name text,date text,time text," + "is_read text,category text,type text,subject text,remark text,file_name text,file_path text)";
    
    let Dcr_Appraisal = "CREATE TABLE "+Appraisal+" ( id integer primary key,PA_ID text,PA_NAME text,DR_CALL text,DR_AVG text,CHEM_CALL text,CHEM_AVG text,FLAG text,sAPPRAISAL_ID_STR text,sAPPRAISAL_NAME_STR text,sGRADE_STR text,sGRADE_NAME_STR text,sOBSERVATION text,sACTION_TAKEN text)";
    
    let CREATE_TABLE_dob_doa = "CREATE TABLE " + dob_doa + " (id Integer PRIMARY KEY AUTOINCREMENT,PA_NAME text,DOB text,DOA text,MOBILE text,TYPE text)";
    
    let CREATE_TABLE_Expenses_head = "CREATE TABLE " + Expenses_head + " (id Integer PRIMARY KEY AUTOINCREMENT,FIELD_NAME text,FIELD_ID text,MANDATORY text,DA_ACTION text,EXP_TYPE text,ATTACHYN text,MAX_AMT float,TAMST_VALIDATEYN text,SHOW_IN_TA_DA text,KMYN text,HEADTYPE_GROUP text)";
    
    let CREATE_TABLE_Tenivia_traker = "CREATE TABLE " + Tenivia_traker + " (id Integer PRIMARY KEY AUTOINCREMENT,DR_ID text,DR_NAME text,QTY text,AMOUNT text,QTY_CAPTION text,ITEM_ID text,AMOUN_CAPTION text,TIME text,REMARK text)";
    let CREATE_TABLE_Doctor_Call_Remark = "CREATE TABLE " + Doctor_Call_Remark + "(id Integer PRIMARY KEY AUTOINCREMENT,FIELD_ID text,FIELD_NAME text,type text)";
    
    let CREATE_TABLE_Lat_Long_Reg = "CREATE TABLE " + Lat_Long_Reg + " (id Integer PRIMARY KEY ,DCS_ID text,LAT_LONG text,DCS_TYPE text,DCS_ADD text,DCS_INDES text,UPDATED text)";
    
    
    
    let DAIRY_TABLE = "CREATE TABLE " + PH_DAIRY + " ( id integer primary key,DAIRY_ID integer,DAIRY_NAME text,DOC_TYPE text,LAST_VISIT_DATE text,DR_LAT_LONG text,DR_LAT_LONG2 text,DR_LAT_LONG3 text)"
    
    let DAIRY_PERSON_TABLE = "CREATE TABLE " + PH_DAIRY_PERSON + " ( id integer primary key,DAIRY_ID integer,PERSON_ID integer,PERSON_NAME text)";
    let DAIRY_REASON_TABLE = "CREATE TABLE " + PH_DAIRY_REASON + " ( id integer primary key,PA_ID integer,PA_NAME text)";
    let DAIRY_DCR_TABLE = "CREATE TABLE " + PH_DAIRY_DCR + " ( id integer primary key,DAIRY_ID text,DOC_TYPE text,DAIRY_NAME text,visit_time text,batteryLevel text,dr_latLong text,dr_address text,dr_remark text,updated text,dr_km text,srno text,person_name text,person_id text,pob_amt text,allitemid text,allitemqty text,sample text,allgiftid text,allgiftqty text,file text,LOC_EXTRA text,IS_INTRESTED text,Ref_latlong text)";
    
    
    let ITEM_STOCK_DCR_TABLE = "CREATE TABLE " + PH_ITEM_STOCK_DCR + " ( id integer primary key,ITEM_ID text,STOCK_QTY integer )";
    
    
    let CREATE_VSTOCK = "create view " + VSTOCK + "  as \n" +
        "select PHITEM_STOCK_DCR.ITEM_ID,ifnull( PHITEM_STOCK_DCR.STOCK_QTY ,0) as STOCK_QTY,ifnull( T.QTY ,0) as QTY,\n" +
        "(ifnull( PHITEM_STOCK_DCR.STOCK_QTY ,0) - ifnull( T.QTY ,0)) as BALANCE from PHITEM_STOCK_DCR\n" +
        " left join \n" +
    " (select ITEM_ID, SUM(QTY) as QTY from PH_DCR_ITEM GROUP BY ITEM_ID)T on T.ITEM_ID = PHITEM_STOCK_DCR.ITEM_ID";
    
    let DCR_ITEM_TABLE = "CREATE TABLE "+PH_DCR_ITEM + " ( id integer primary key,CategoryID text,Category text,ITEM_ID text,QTY integer,ItemType text  )";
    
    let DROP_VSTOCK = "drop view " + VSTOCK;
    
    let PH_STK_ITEM_RATE_TABLE = "CREATE TABLE " + PH_STK_ITEM_RATE + " ( id integer primary key,STK_ID text,ITEM_ID text,RATE text )";
    
    let VA_Download = "CREATE TABLE " + VISUAL_ADD_DOWNLOAD + "(id integer primary key autoincrement,itemId text,itemName text,fileName text,downLoadVersion text,brandId text,submitYN text,downloadDateTime text)";
    
    private init(){
        customVariablesAndMethod = Custom_Variables_And_Method.getInstance()
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
        do{
            connection = try Connection("\(dbPath!)/\(CBO_DB_Helper.DATABASE_NAME).sqite3")
            
            //let manager = SQLiteMigrationManager(db: connection!  , migrations: [ SwiftMigration() ], bundle: Bundle.main)
            
            if UserDefaults.standard.object(forKey: "db_Version") != nil{
                old_dbVersion = UserDefaults.standard.object(forKey: "db_Version") as! Int
                print(old_dbVersion , dbVersion)
            }
            
            
            if dbVersion > old_dbVersion {
                try  updatedb(old_dbVersion: old_dbVersion)
            }
            
            getDetailsForOffline()
            
        }
        catch{
            connection = nil
            let nserror = error as NSError
            print("Unable to open Database . Error is  : \(nserror), \(nserror.userInfo)")
        }
    }
    
    
    //"INSERT INTO RL_Species (user_common_name, user_common_name_fr, user_common_name_es, user_common_name_de, user_notes) VALUES ('\(specieDetail.commonName)', '\(specieDetail.commonNameFR)', '\(specieDetail.commonNameES)', '\(specieDetail.commonNameDE)', '\(specieDetail.userNotes)') WHERE RL_Species.id = '\(specieId)';
    
    
    public  func  getDetailsForOffline() {
        if (Custom_Variables_And_Method.PA_ID==0 || Custom_Variables_And_Method.COMPANY_CODE==nil) {
            Custom_Variables_And_Method.PA_ID =  Custom_Variables_And_Method.getIntValue(value: getPaid())
            Custom_Variables_And_Method.PA_NAME = getPaName();
            Custom_Variables_And_Method.HEAD_QTR = getHeadQtr();
            Custom_Variables_And_Method.DESIG = getDESIG();
            Custom_Variables_And_Method.pub_desig_id = getPUB_DESIG();
            Custom_Variables_And_Method.COMPANY_NAME = getCOMP_NAME();
            Custom_Variables_And_Method.WEB_URL = getWEB_URL();
            Custom_Variables_And_Method.location_required = getLocationDetail();
            Custom_Variables_And_Method.VISUAL_REQUIRED = getVisualDetail();
            Custom_Variables_And_Method.DCR_ID = getDCR_ID_FromLocal();
            Custom_Variables_And_Method.COMPANY_CODE = getCompanyCode();
            Custom_Variables_And_Method.pub_area = getPUB_AREA();
        }
    }
    
    // insert data in any table in database
    func insertQry(Table_name : String,values :[String:Any])  {
        //      var Query="INSERT INTO \(Table_name) ("
        
        var col_val = ""
        var coloums=""
        for i in values {
            col_val += "\"\(i.value)\","
            coloums += "\(i.key),"
            //                if type(of: i.value) == String.self{
            //                    col_val += "\"\(i.value)\","
            //                    coloums += "\(i.key),"
            //                }else if type(of: i.value) == Int.self{
            //                    col_val += "\(i.value),"
            //                    coloums += "\(i.key),"
            //                }else{
            //                    let a = i.value as! [String : String]
            //                    for b in a {
            //                        if( b.value == "Int"){
            //                            col_val += "\(b.key),"
            //                            coloums += "\(i.key),"
            //                        }else{
            //                            col_val += "\"\(b.key)\","
            //                            coloums += "\(i.key),"
            //                        }
            //                    }
            //                }
        }
        coloums = String(coloums.dropLast())
        col_val = String(col_val.dropLast())
        
        let Query = "INSERT INTO \(Table_name) (\(coloums)) VALUES (\(col_val));"
        print(Query)
        do{
            try executeQry(query: Query)
        }
        catch{
            print(error)
        }
    }
    
    
    // update any table in database
    func updateQry(Table_name : String,values :[String:Any] , WhereClause : String )  {
        //      var Query="INSERT INTO \(Table_name) ("
        
        var col_val = ""
        var Query = ""
        for i in values {
            col_val += "\(i.key) = \"\(i.value)\","
            //            if type(of: i.value) == String.self{
            //                col_val += "\(i.key) = \"\(i.value)\","
            //            }else if type(of: i.value) == Int.self{
            //                 col_val += "\(i.key) = \(i.value),"
            //            }else{
            //                let a = i.value as! [String : String]
            //                for b in a {
            //                    if( b.value == "Int"){
            //                        col_val += "\(i.key) = \(i.value),"
            //                    }else{
            //                        col_val += "\(i.key) = \"\(i.value)\","
            //                    }
            //                }
            //            }
        }
        
        
        col_val = String(col_val.dropLast())
        
        if( WhereClause.isEmpty){
            Query  = "UPDATE \(Table_name) SET \(col_val);"
        }else{
            Query  = "UPDATE \(Table_name) SET \(col_val) WHERE \(WhereClause);"
        }
        
        print(Query)
        
        do{
            try executeQry(query: Query)
        }
        catch{
            print(error)
        }
    }
    
    
    // delete data from any table in database
    
    func DeleteQry(Table_name : String,WhereClause : String)  {
        //      var Query="INSERT INTO \(Table_name) ("
        var Query = ""
        if WhereClause.isEmpty{
            Query = "DELETE FROM \(Table_name);"
        }
        else {
            Query = "DELETE FROM \(Table_name) WHERE \(WhereClause);"
        }
        
        
        print(Query)
        do{
            try executeQry(query: Query)
        }
        catch{
            print(error)
        }
    }
    
    
    func getColumnIndex (statement : Statement , Coloumn_Name: String) throws -> Int {
        let coloumname = statement.columnNames
        for i in 0 ..< coloumname.count{
            if coloumname[i] == Coloumn_Name{
                return i
            }
        }
        let error = CustomError(title: "Invalid Column ", description: "Column not found \(Coloumn_Name) ", code: 10000)
        throw   error
    }
    
    
    func  getColValue(row : Row , dataDict : [String]) -> [String : String]{
        var result=[String : String]()
        for i in dataDict{
            result[i] = row[Expression<String>(i)]
            print(result[i]!)
        }
        return result
    }
    
    func  getColValueInArray(row : Row , dataDict : [String : String]) -> String{
        var result = ""
        for i in dataDict{
            if (i.value != "String"){
                result = row[Expression<String>(i.key)]
            }else{
                result = "\(row[Expression<Int>(i.key)])"
            }
            
        }
        return result
    }
    
    func  getColValueInArray(row : Row , dataDict : String) -> String{
        var result = ""
        result = row[Expression<String>(dataDict)]
        return result
    }
    
    func  getColValue(row : Row , dataDict : [String : String ]) -> [String : String]{
        var result=[String : String]()
        for i in dataDict{
            if (i.value == "String"){
                result[i.key] = row[Expression<String>(i.key)]
            }else{
                result[i.key] = "\(row[Expression<Int>(i.key)])"
            }
            print(result[i.key]!)
        }
        return result
    }
    
    
    func executeQry(query :  String) throws {
        print(query)
        do {
            try connection?.execute(query)
        }catch{
            let myError : String = String(describing: error)
            if (!myError.contains("already exists")){
                throw error
            }
        }
    }
    
    //
    func updatedb(old_dbVersion : Int) throws {
        do{
            
            switch old_dbVersion {
            case 0:
                try executeQry(query: CREATE_TABLE_LAT_LON)
                try executeQry(query: CREATE_LOGIN);
                try executeQry(query: CREATE_DOCTOR);
                try executeQry(query: CREATE_DOCTOR_SAMPLE);
                try executeQry(query: CREATE_DR_RX_TABLE);
                try executeQry(query: DOCTOR_IN_LOCAL);
                try executeQry(query: PH_ITEM);
                try executeQry(query: DCR_ID);
                try executeQry(query: RESIGNED);
                try executeQry(query: tempdr);
                try executeQry(query: CREATE_DOCTOR_PRESCRIBE);
                try executeQry(query: FMCG_STATUS);
                try executeQry(query: Util_TABLE);
                try executeQry(query: Apprisal_TABLE);
                try executeQry(query: Apprisal_VALUE_TABLE);
                try executeQry(query: VERSION_TABLE);
                try executeQry(query: PH_DOCTOR_IETM);
                try executeQry(query: MASTER_DOCTOR);
                try executeQry(query: ALLMST);
                try executeQry(query: LOCATION_TABLE);
                try executeQry(query: WORK_WITH_TABLE);
                try executeQry(query: RC_DOCTOR);
                try executeQry(query: PARTY);
                try executeQry(query: RELATION);
                try executeQry(query: ITEM_SPL);
                try executeQry(query: DCR_CHK);
                try executeQry(query: FTP_TABLE);
                try executeQry(query: CHEMIST_TABLE);
                try executeQry(query: CHEMIST_ADD_TABLE);
                
                //try executeQry(query: STOCKIST_TABLE);
                try executeQry(query: CREATE_LOGIN_DETAIL);
                try executeQry(query: CREATE_USER_DETAIL);
                try executeQry(query: CREATE_USER_DETAIL2);
                try executeQry(query: DCR_TABLE);
                try executeQry(query: CHEMIST_SUBMIT_TABLE);
                try executeQry(query: STOCKIST_SUBMIT_TABLE);
                try executeQry(query: STOCKIST_ADD_TABLE);
                try executeQry(query: CHEMIST_SAMPLE_TABLE);
                try executeQry(query: STOCKIST_SAMPLE_TABLE);
                try executeQry(query: Lat_Long_Data);
                try executeQry(query: PH_Farmar);
                try executeQry(query: myRepa);
                try executeQry(query: CREATE_TABLE_LAT_LON_TEN);
                try executeQry(query: CREATE_TABLE_LAT_LON_ONEMINUTE);
                
                try executeQry(query: CREATE_TABLE_MENU_CONTROL);
                try executeQry(query: CREATE_TABLE_Notification);
                try executeQry(query: CREATE_TABLE_Approval_count);
                try executeQry(query: CREATE_TABLE_Expenses);
                try executeQry(query: CREATE_TABLE_NonListed_call);
                try executeQry(query: MAIL_TABLE);
                try executeQry(query: Dcr_Appraisal);
                try executeQry(query: CREATE_TABLE_dob_doa);
                try executeQry(query: CREATE_TABLE_Expenses_head);
                try executeQry(query: CREATE_TABLE_Tenivia_traker);
                try executeQry(query: CREATE_TABLE_Doctor_Call_Remark);
                try executeQry(query: CREATE_TABLE_Lat_Long_Reg);
                
                //                    MARK:- in DB 27 version
                try executeQry(query:DAIRY_TABLE);
                try executeQry(query:DAIRY_PERSON_TABLE);
                try executeQry(query:DAIRY_REASON_TABLE);
                try executeQry(query:DAIRY_DCR_TABLE);
                
                try executeQry(query: ITEM_STOCK_DCR_TABLE);
                
                try executeQry(query: DCR_ITEM_TABLE);
                try executeQry(query: CREATE_VSTOCK);
                
                try executeQry(query: PH_STK_ITEM_RATE_TABLE);
                
                try executeQry(query: RC_CHEM);
                
                try executeQry(query: VA_Download)
                
            case 1,25:
                try executeQry(query : "ALTER TABLE " + CBO_DB_Helper.PH_Dcr_stk + " ADD COLUMN allgiftqty text DEFAULT ''");
                try executeQry(query : "ALTER TABLE " + CBO_DB_Helper.PH_Dcr_stk + " ADD COLUMN allgiftid text DEFAULT ''");
                fallthrough
            case 26:
                try executeQry(query : "ALTER TABLE " + CBO_DB_Helper.PH_ITEM_TABLE + " ADD COLUMN SHOW_ON_TOP text DEFAULT 'N'");
                fallthrough
            case 27:
                try executeQry(query:DAIRY_TABLE);
                try executeQry(query:DAIRY_PERSON_TABLE);
                try executeQry(query:DAIRY_REASON_TABLE);
                try executeQry(query:DAIRY_DCR_TABLE);
                
                fallthrough
                
            case 28:
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.PH_ITEM_TABLE + " ADD COLUMN SHOW_YN text DEFAULT 'Y'")
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_DAIRY_DCR+" ADD COLUMN IS_INTRESTED text DEFAULT ''")
                fallthrough
            case 29:
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.PH_DOCTOR_TABLE + " ADD COLUMN CRM_COUNT text DEFAULT ''");
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.PH_DOCTOR_TABLE + " ADD COLUMN DRCAPM_GROUP text DEFAULT ''");
                fallthrough
            case 30:
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_DOCTOR_TABLE+" ADD COLUMN SHOWYN text DEFAULT '1'");
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_Party+" ADD COLUMN SHOWYN text DEFAULT '1'");
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_CHEMIST_TABLE+" ADD COLUMN SHOWYN text DEFAULT '1'");
                fallthrough
            case 31:
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.Temp_Dr+" ADD COLUMN Ref_latlong text DEFAULT ''");
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_Dcr_chem+" ADD COLUMN Ref_latlong text DEFAULT ''");
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_Dcr_stk+" ADD COLUMN Ref_latlong text DEFAULT ''");
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_Dcr_Dr_rc+" ADD COLUMN Ref_latlong text DEFAULT ''");
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.PH_DAIRY_DCR + " ADD COLUMN Ref_latlong text DEFAULT ''");
                
                try executeQry(query: ITEM_STOCK_DCR_TABLE);
                fallthrough
            case 32:
                try executeQry(query: DCR_ITEM_TABLE);
                try executeQry(query: CREATE_VSTOCK);
                fallthrough
            case 33:
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN DA_ACTION text DEFAULT '0'");
                fallthrough
                
            case 34:
                try executeQry(query: PH_STK_ITEM_RATE_TABLE);
                fallthrough
            case 35:
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_Dcr_chem+" ADD COLUMN rate text DEFAULT ''");
                try executeQry(query: "ALTER TABLE "+CBO_DB_Helper.PH_Dcr_stk+" ADD COLUMN rate text DEFAULT ''");
                fallthrough
            case 36:
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.PH_ITEM_TABLE + " ADD COLUMN SPL_ID integer DEFAULT 0");
                fallthrough
            case 37:
                try executeQry(query: "ALTER TABLE " +  CBO_DB_Helper.FTP_Detail + " ADD COLUMN ftpip_download text DEFAULT '220.158.164.114'");
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.FTP_Detail + " ADD COLUMN username_download text DEFAULT 'CBO_DOMAIN_SERVER'");
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.FTP_Detail + " ADD COLUMN password_download text DEFAULT 'cbodomain@321'");
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.FTP_Detail + " ADD COLUMN port_download text DEFAULT '21'");
                fallthrough
            case 38:
                try executeQry(query: "ALTER TABLE " + CBO_DB_Helper.PH_DOCTOR_TABLE + " ADD COLUMN RXGENYN text DEFAULT '0'");
                fallthrough
            case 39:
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.PH_DOCTOR_TABLE + " ADD COLUMN APP_PENDING_YN text DEFAULT '0'");
                fallthrough
            case 40:
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.PH_ITEM_TABLE + " ADD COLUMN GENERIC_NAME text DEFAULT '0'");
                fallthrough
            case 41:
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Doctor_Call_Remark + " ADD COLUMN type text DEFAULT 'R'");
                fallthrough
            case 42:
                try executeQry(query:"ALTER TABLE " +  CBO_DB_Helper.PH_Dcr_chem + " ADD COLUMN status text DEFAULT ''");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.PH_Dcr_chem  + " ADD COLUMN Competitor_Product text DEFAULT ''");
                fallthrough
            case 43:
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN EXP_TYPE DEFAULT '0'");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN ATTACHYN text DEFAULT 'N'");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN MAX_AMT float DEFAULT 0");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN TAMST_VALIDATEYN text DEFAULT 'N'");
                fallthrough
            case 44:
        
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN SHOW_IN_TA_DA DEFAULT '0'");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN KMYN text DEFAULT 'N'");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses_head + " ADD COLUMN HEADTYPE_GROUP float DEFAULT 0");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses + " ADD COLUMN km text DEFAULT '0'");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.Expenses + " ADD COLUMN editable Integer DEFAULT 1");
                fallthrough
            
            case 45:
                      
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.PH_ITEM_TABLE + " ADD COLUMN BRAND_NAME DEFAULT item_name");
                try executeQry(query:"ALTER TABLE " + CBO_DB_Helper.PH_ITEM_TABLE + " ADD COLUMN BRAND_ID text DEFAULT item_id");
                
                fallthrough
                
            case 46:
                
                try executeQry(query:RC_CHEM);
                
                fallthrough
                
            case 47:
                
                try executeQry(query: VA_Download)
                
                fallthrough
            
            default:
                let a="Successfully Updated"
                print (a)
            }
            UserDefaults.standard.set(dbVersion, forKey: "db_Version")
        }
        catch{
            throw error
        }
    } 
    
    
    public func insertdata( mycode : String,uname : String,pw : String,pin: String) {
        var cv = [String :  String ]()
        cv["code"] = mycode
        cv["username"] = uname
        cv["password"] = pw
        cv["pin"] = pin
        
        insertQry(Table_name: CBO_DB_Helper.LOGIN_TABLE, values: cv);
    }
    //
    public func getCompanyCode()-> String {
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["code"]
            
            for x in (try connection?.prepare(Table(CBO_DB_Helper.LOGIN_TABLE)))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
            }
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        var companyname : String!
        for i in 0 ..< dataDict.count{
            companyname = dataDict[i]["code"]
        }
        
        return (companyname ?? "-1")!
    }
    
    //
    //
    //            public func getUserName() -> String{
    //                sd = this.getWritableDatabase();
    //                String username = "";
    //                Cursor c = sd.rawQuery("select username from cbo_login", null);
    //                if (c.moveToFirst()) {
    //                do {
    //                    username = c.getString(c.getColumnIndex("username"));
    //                    } while (c.moveToNext());
    //                    }
    //                c.close();
    //                return username;
    //            }
    //
    //
    public func getPin() -> String {
        
        
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["pin"]
            
            for x in (try connection?.prepare(Table(CBO_DB_Helper.LOGIN_TABLE)))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
            }
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        var mypin : String!
        for i in 0 ..< dataDict.count{
            mypin = dataDict[i]["pin"]
        }
        return (mypin ?? "0")!
        
    }
    //
    public func deleteLogin() {
        DeleteQry(Table_name: CBO_DB_Helper.LOGIN_TABLE, WhereClause: "")
    }
    //
    //
    //            public func getLoginDetail() -> Cursor{
    //                sd = this.getWritableDatabase();
    //                return sd.query(LOGIN_TABLE, null, null, null, null, null, null);
    //            }
    //
    //    //===========================================================Login Finish====================================================================================
    
    public func insertDoctorInLocal( dr_id : String , dr_name : String, ww1 : String, ww2 : String,  ww3 : String, loc : String, time : String,  LOC_EXTRA : String) {
        var cv = [String : Any]()
        cv["dr_id"] = dr_id
        cv["dr_name"] = dr_name
        cv["work_with1"] = ww1
        cv["work_with2"] = ww2
        cv["work_with3"] =  ww3
        cv["location"] = loc
        cv["time"] = time
        cv["LOC_EXTRA"] = LOC_EXTRA
        insertQry(Table_name: "phdcrdr", values: cv)
    }
    
    //
    //
    //            public func updateDr_Location(String loc, String drId) {
    //                sd = this.getWritableDatabase();
    //                ContentValues cv = new ContentValues();
    //                cv["location", loc);
    //                long result = sd.update("phdcrdr", cv, "dr_id =" + drId, null);
    //            }
    //
    //
    public func updateDr_LocExtra( LOC_EXTRA : String, drId : String) {
        
        var cv = [String : Any]()
        cv["LOC_EXTRA"] = LOC_EXTRA
        updateQry(Table_name: "phdcrdr", values: cv, WhereClause: "dr_id =" + drId)
        
        //sd.update("phdcrdr", cv, "dr_id =" + drId, null)
    }
    
    
    
    
    public func getDoctorLocationFromSqlite( drid : String) -> String {
        
        var drname = "";
        do {
            let statement = try connection!.prepare("select location from phdcrdr where dr_id='" + drid + "'")
            
            while let c = statement.next() {
                
                drname = try c[getColumnIndex(statement : statement , Coloumn_Name: "location")]! as! String
                
            }
        } catch {
            print(error)
            
        }
        return drname;
    }
    
    
    public func getDoctorLocExtraFromSqlite( drid : String) -> String {
        
        var drname = "";
        do{
            let statement = try connection!.prepare("select LOC_EXTRA from phdcrdr where dr_id='" + drid + "'")
            
            while let c = statement.next(){
                
                drname = try c[getColumnIndex(statement : statement , Coloumn_Name:  "LOC_EXTRA")]! as! String
            }
        }catch {
            print(error)
        }
        return drname;
    }
    
    public func getDoctorww3FromSqlite( drid : String) -> String{
        
        var drname = "";
        do{
            let statement = try connection!.prepare("select work_with3 from phdcrdr where dr_id='" + drid + "'");
            
            while let c = statement.next(){
                
                drname = try (c[getColumnIndex( statement : statement , Coloumn_Name: "work_with3")]! as! String )
                if (drname == "") {
                    
                    return "0";
                }
            }
        } catch {
            print(error)
        }
        return drname;
    }
    
    public func getDoctorww2FromSqlite( drid : String) -> String {
        
        
        var drname = "";
        
        do {
            
            let statement = try connection!.prepare("select work_with2 from phdcrdr where dr_id='" + drid + "'")
            while let c = statement.next(){
                drname = try c[getColumnIndex(statement : statement , Coloumn_Name:  "work_with2")]! as! String
            }
            
            if (drname == "") {
                return "0";
            }
        }
        catch {
            print(error)
        }
        
        return drname;
    }
    
    
    public func getDoctorww1FromSqlite( drid : String) -> String {
        
        var drname = ""
        do {
            let statement  = try connection!.prepare("select work_with1 from phdcrdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next(){
                drname = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "work_with1")]! as! String)
                if drname == "" {
                    return "0"
                }
            }
        }
        catch{
            print(error)
        }
        
        return drname;
    }
    public func getDoctorTimeFromSqlite( drid : String) -> String {
        
        var drname = "";
        do {
            let statement = try connection!.prepare("select time from phdcrdr where dr_id='" + drid + "'")
            
            while let c = statement.next(){
                drname = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "time")]! as! String)
                
                
            }
        }catch  {
            print(error)
        }
        return drname;
    }
    
    public func getDoctor() -> [String] {
        
        var doclist = [String]();
        do{
            let query = "select dr_id from phdcrdr"
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                try doclist.append(c[getColumnIndex(statement : statement, Coloumn_Name: "dr_id")]! as! String)
            }
        }catch{
            print(error)
        }
        
        return doclist;
    }
    
    public func getDoctorName() throws -> Statement{
        return try getDoctorName(RXGENYN: "0");
    }
    public func getDoctorNameCount(RXGENYN : String) throws -> Int{
        do{
            var extraQry = "";
            var count = 0
            if (RXGENYN != "0"){
                extraQry = "and phdoctor.RXGENYN ='" + "1" + "'";
            }
            let query = "select count(*) AS c from tempdr " +
                "left join phdoctor on phdoctor.dr_id = tempdr.dr_id " +
                "where (call_type = '0' or call_type='2') " + extraQry
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                count = Int (c[try getColumnIndex(statement : statement, Coloumn_Name: "dr_id")]! as! String)!
                
            }
            return count
        }catch{
            throw error
        }
    }
    public func getDoctorName(RXGENYN : String) throws -> Statement{
        do{
            var extraQry = "";
            if (RXGENYN != "0"){
                extraQry = "and phdoctor.RXGENYN ='" + "1" + "'";
            }
            let query = "select * from tempdr " +
                "left join phdoctor on phdoctor.dr_id = tempdr.dr_id " +
                "where (call_type = '0' or call_type='2') " + extraQry
            return try connection!.prepare(query)
        }catch{
            throw error
        }
    }
    
    
    public func deleteDoctor() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_Dr, WhereClause: "")
    }
    //    ///////////////////////DR_RX_TABLE ////////////////////////
    //
    //    //        String CREATE_DR_RX_TABLE ="CREATE TABLE "+DR_RX_TABLE +"(id integer primary key, dr_id text,item_id text)";
    
    public func insert_drRx_Data(drid : String, item : String ) {
        var cv = [String : Any]()
        cv["dr_id"] =  drid
        cv["item_id"] = item
        insertQry(Table_name: CBO_DB_Helper.DR_RX_TABLE, values: cv)
    }
    
    public func  getDr_Rx_id(updated : String? = nil ) -> [String]{
        
        var dr_id = [String]()
        
        var qry = "select dr_id from " + CBO_DB_Helper.DR_RX_TABLE
        do {
            if (updated != nil) {
                
                qry =  "select tempdr.dr_id from tempdr inner join  " + CBO_DB_Helper.DR_RX_TABLE + " on dr_rx_table.dr_id=tempdr.dr_id  where updated ='" + updated! + "'"
            } else{
                
                let statement = try connection!.prepare(qry)
                while let c = statement.next(){
                    
                    try dr_id.append(c[getColumnIndex(statement : statement , Coloumn_Name: "dr_id")] as! String)
                }
            }
        }catch {
            print(error)
        }
        
        return dr_id;
    }
    
    public func getDr_Rx_itemId( dr_id : String) -> String {
        
        var item_id = "";
        
        let query = "select item_id from " + CBO_DB_Helper.DR_RX_TABLE + " where dr_id =" + dr_id;
        do{
            let statement = try connection!.prepare(query)
            
            while let c = statement.next(){
                item_id = try (c[getColumnIndex(statement : statement , Coloumn_Name: "item_id")] as! String)
                
            }
        }
            
        catch{
            print(error)
        }
        return item_id;
    }
    
    public func updateDr_Rx_Data( dr_id : String , item_id :String ) {
        var cv = [String : Any]()
        cv["dr_id"] = dr_id
        cv["item_id"] = item_id
        updateQry(Table_name: CBO_DB_Helper.DR_RX_TABLE, values: cv, WhereClause: "dr_id =" + dr_id)
    }
    
    public func delete_Rx_Table() {
        
        DeleteQry(Table_name: CBO_DB_Helper.DR_RX_TABLE, WhereClause: "")
        
        
    }
    //
    //    //    =========================
    //
    //
    //
    public func insertdata( drid : String, item : String ,item_name : String ,  qty: String,  pob : String,  stk_rate : String,  visual : String, noc : String) {
        var cv = [String : Any]()
        cv["dr_id"] = drid
        cv["item_id"] = item
        cv["item_name"] = item_name
        cv["qty"] =  qty
        cv["pob"] =  pob.replacingOccurrences(of: "\n", with: "")
        cv["stk_rate"] =  stk_rate
        cv["visual"] = visual
        cv["noc"] = noc
        cv["updated"] = "0"
        insertQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, values: cv)
        
        delete_DCR_Item(ID: drid,item_id: item,ItemType: stk_rate == "" ? "SAMPLE" : "GIFT",Category: "DR");
        insert_DCR_Item(ID: drid,ArrITEM_ID: item,ArrQTY: qty,ItemType: stk_rate == ("") ? "SAMPLE" : "GIFT",Category: "DR");
    }
    
    public func updatedata( drid : String, item : String ,item_name : String ,  qty: String,  pob : String,  stk_rate : String,  visual : String, noc : String) {
        var cv = [String : Any]()
        cv["dr_id"] = drid
        cv["item_id"] = item
        cv["item_name"] = item_name
        cv["qty"] =  qty
        cv["pob"] =  pob
        cv["stk_rate"] =  stk_rate
        cv["visual"] = visual
        cv["noc"] = noc
        cv["updated"] = "0"
        updateQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, values: cv, WhereClause: "item_id =" + item)
    }
    
    public func updatedataforVisualAd( dr_id : String, item : String ,  visual : String) {
           var cv = [String : Any]()
           cv["visual"] = visual
           cv["updated"] = "0"
           updateQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, values: cv, WhereClause: "item_id = '" + item + "' and dr_id ='" + dr_id + "'")
       }
    //
    //sd.update(DOCTOR_ITEM_TABLE, cv, "item_id='" + item + "'", null);
    public func updateDr_item(  id : String) {
        var cv = [String : String]()
        cv["updated"] = "1"
        updateQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, values: cv, WhereClause: "dr_id =" + id)
        //                        (DOCTOR_ITEM_TABLE, cv, "dr_id =" + id, null);
    }
    
    
    public func deletedata( drid : String , Rate : String) {
        
        
        
        if(Rate == "") {
            //query = "DELETE FROM  " + DOCTOR_ITEM_TABLE +" WHERE dr_id='" + drid + "'" ;
            DeleteQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, WhereClause: "dr_id='" + drid + "' and stk_rate!='x'")
            delete_DCR_Item(ID: drid,item_id: nil,ItemType: "SAMPLE",Category: "DR");
        }else{
            DeleteQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, WhereClause: "dr_id='" + drid + "' and stk_rate ='x'")
            //String query = "DELETE FROM  " + DOCTOR_ITEM_TABLE +" WHERE dr_id='" + drid + "' and stk_rate='x'" ;
            
            delete_DCR_Item(ID: drid,item_id: nil,ItemType: "GIFT",Category: "DR");
        }
        
    }
    //
    //    /////////////////////////// DOCOTR_pRESCRIBE_TABLE;//////////////
    //
    //                public func insertdataPrescribe( drid : String, item : String , item_name : String,  qty : String,  pob : String,  stk_rate : String,  visual :String) {
    //                        ContentValues cv = new ContentValues();
    //                        cv["dr_id", drid);
    //                        cv["item_id", item);
    //                        cv["item_name", item_name);
    //                        cv["qty", qty);
    //                        cv["pob", pob);
    //                        cv["stk_rate", stk_rate);
    //                        cv["visual", visual);
    //                        sd = this.getWritableDatabase();
    //                        sd.insert(Dr_PRESCRIBE, null, cv);
    //                }
    //
    //
    //                public func insertVisuals( drid : String,  item : String, item_name : String, qty : String, pob : String, stk_rate : String, visual : String) {
    //                        ContentValues cv = new ContentValues();
    //                        cv["dr_id", drid);
    //                        cv["item_id", item);
    //                        cv["item_name", item_name);
    //                        cv["qty", qty);
    //                        cv["pob", pob);
    //                        cv["stk_rate", stk_rate);
    //                        cv["visual", visual);
    //                        sd = this.getWritableDatabase();
    //                        sd.insert(DOCTOR_ITEM_TABLE, null, cv);
    //                }
    //
    //                public func updateVisuals( drid : String,  item : String,  item_name : String,  qty: String,  pob : String,  stk_rate : String,  visual : String) {
    //                        ContentValues cv = new ContentValues();
    //                        cv["dr_id", drid);
    //                        cv["item_id", item);
    //                        cv["item_name", item_name);
    //                        cv["qty", qty);
    //                        cv["pob", pob);
    //                        cv["stk_rate", stk_rate);
    //                        cv["visual", visual);
    //                        sd = this.getWritableDatabase();
    //                        sd.update(DOCTOR_ITEM_TABLE, cv, "item_id='" + item + "'", null);
    //                }
    
    public func getDoctorList() -> [String]  {
        
        var doclist = [String]();
        do{
            let statement = try connection!.prepare("Select * from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE)
            while let c = statement.next(){
                try doclist.append(c[getColumnIndex(statement : statement, Coloumn_Name: "dr_id")] as! String);
            }
        }catch{
            print(error)
        }
        
        
        return doclist;
    }
    
    public func getDoctorAllItems(drid: String) -> [String] {
        var doclist = [String]();
        do{
            let statement = try connection!.prepare("Select * from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + " where dr_id='" + drid + "'")
            while let c = statement.next(){
                try doclist.append(c[getColumnIndex(statement : statement, Coloumn_Name: "item_id")] as! String);
            }
        }catch{
            print(error)
        }
        
        return doclist;
    }
    
    public func getDoctorVisualId(drid: String) -> [String]{
        var doclist = [String]();
        do{
            let statement = try connection!.prepare("Select * from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + " where dr_id='" + drid + "' and visual='1'")
            while let c = statement.next(){
                try doclist.append(c[getColumnIndex(statement : statement, Coloumn_Name: "item_id")] as! String);
            }
        }catch{
            print(error)
        }
        
        return doclist;
        
    }
    
    
    public func getDoctorVisualIdByBrand(drid: String) -> [String]{
           var doclist = [String]();
           do{
            //"select I.BRAND_ID,I.BRAND_NAME, D.item_name, D.item_id from phdoctoritem D LEFT JOIN phitem I on I.item_id = D.item_id where  SHOW_YN = '1' and dr_id=" + dr_id + " GROUP BY I.BRAND_ID"
               let statement = try connection!.prepare("Select I.BRAND_ID from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + " D LEFT JOIN phitem I on I.item_id = D.item_id where dr_id='" + drid + "' and visual='1' GROUP BY I.BRAND_ID")
               while let c = statement.next(){
                   try doclist.append(c[getColumnIndex(statement : statement, Coloumn_Name: "BRAND_ID")] as! String);
               }
           }catch{
               print(error)
           }
           
           return doclist;
           
       }
    
    public func getDoctorVisualUpdate(drid: String) -> [String]{
        var doclist = [String]();
        do{
            let statement = try connection!.prepare("Select * from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + " where dr_id='" + drid + "'")
            while let c = statement.next(){
                try doclist.append(c[getColumnIndex(statement : statement, Coloumn_Name: "updated")] as! String);
            }
        }catch{
            print(error)
        }
        
        return doclist;
        
    }
    //
    public func deleteDoctorItem() {
        DeleteQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE , WhereClause: "")
        
    }
    //
    ///////////////Delete DrItem _prescribe////////////
    public func deleteDoctorItemPrescribe() {
        DeleteQry(Table_name: CBO_DB_Helper.Dr_PRESCRIBE, WhereClause: "")
    }
    
    
    public func getDocItem( mdrid: String) -> [String] {
        
        var docItems  = [String]()
        var sb = String()
        var sb_qty = String()
        var sb_pob = String()
        var sb_visual = String()
        var sb_noc = String()
        var sb_rate = String()
        
        let quer = "select * from phdcritem where dr_id='" + mdrid + "'";
        do {
            let statement = try connection!.prepare(quer);
            
            while let c = statement.next(){
                
                try  sb = sb + (c[getColumnIndex( statement: statement , Coloumn_Name: "item_id")]as! String) + ","
                
                try  sb_qty =  sb_qty + (c[getColumnIndex( statement : statement , Coloumn_Name: "qty")] as! String) + ","
                
                try  sb_pob = sb_pob + (c[getColumnIndex( statement : statement , Coloumn_Name:"pob")] as! String) + ","
                
                try  sb_visual = sb_visual + (c[getColumnIndex( statement : statement , Coloumn_Name:"visual")] as! String) + ","
                
                try sb_noc = sb_noc + (c[getColumnIndex(statement: statement , Coloumn_Name: "noc")] as! String) + ","
                try sb_rate = sb_rate + (c[getColumnIndex(statement: statement , Coloumn_Name: "stk_rate")] as! String) + ","
                
            }
            
            
        } catch {
            print(error)
        }
        
        if (sb == "") {
            sb = sb + "0"
        }
        if (sb_qty == "") {
            sb_qty =  sb_qty+"0"
        }
        if (sb_pob == "") {
            sb_pob += "0"
        }
        if (sb_visual == "") {
            sb_visual.append("0");
        }
        if (sb_noc == ("")) {
            sb_noc.append("0");
        }
        if (sb_rate == ("")) {
            sb_rate.append("0");
        }
        docItems.append(sb)
        docItems.append(sb_qty)
        docItems.append(sb_pob)
        docItems.append(sb_visual)
        docItems.append(sb_noc)
        docItems.append(sb_rate)
        
        
        return docItems;
    }
    
    
    public func getPrescribeItem( mdrid : String) -> [String] {
        
        var preScribeItem = [String]();
        //var sb = ""
        var sb_iDrId = ""
        var sb_sItem = ""
        //var sb_sQty = ""
        do{
            let  statement = try connection?.prepare("select * from drprescribe where DR_ID ='\(mdrid)'");
            while let a = statement?.next() {
                try sb_iDrId = "\(sb_iDrId) \(a[getColumnIndex(statement: statement!, Coloumn_Name: "item_id")]!)),"
                try sb_sItem = "\(sb_iDrId) \(a[getColumnIndex(statement: statement!, Coloumn_Name: "pob")]!)),"
            }
            
            
        }catch{
            print(error)
            
        }
        
        preScribeItem.append(sb_sItem);
        preScribeItem.append(sb_iDrId);
        
        return preScribeItem;
    }
    
    //
    //
    public func getSampleProductsDcrDrItems( drid: String) throws -> Statement {
        do{
            return  try connection!.prepare("select item_id,item_name from phdcritem  where  item_id in(select item_id from phitem where gift_type='ORIGINAL') AND dr_id='\( drid)'");
        } catch {
            print(error)
            throw error
        }
    }
    
    //
    //    //=============================================================Doctor Products=======================================================================================
    
    public func insertProducts( id :String,  name : String ,  stk_rate : String,  gift : String,
                                SHOW_ON_TOP : String,  SHOW_YN : String,
                                SPL_ID : Int,  GENERIC_NAME : String,
                                BRAND_ID : String,  BRAND_NAME : String) {
        
        var cv = [String : Any]()
        cv["item_id"] = "\(id)"
        cv["item_name"] = "\(name)"
        cv["stk_rate"] = Double(stk_rate)
        cv["gift_type"] = "\(gift)"
        cv["SHOW_ON_TOP"] = SHOW_ON_TOP
        cv["SHOW_YN"] = SHOW_YN
        cv["SPL_ID"] = SPL_ID
        cv["GENERIC_NAME"] = GENERIC_NAME
        
        cv["BRAND_ID"] = BRAND_ID
        cv["BRAND_NAME"] = BRAND_NAME
        
        insertQry(Table_name: CBO_DB_Helper.PH_ITEM_TABLE, values: cv)
        
    }
    
    public func getAllVisualAdd( itemidnotin : String,SHOW_ON_TOP : String) throws -> Statement {
        do{
            return  try connection!.prepare("select item_id, item_name,stk_rate from phitem where (gift_type='ORIGINAL' or  gift_type='OTHER') and SHOW_YN = '1' and SHOW_ON_TOP ='\(SHOW_ON_TOP)' and item_id not in(\(itemidnotin))");
        }catch{
            print(error)
            throw error
        }
    }
    
    public func getAllVisualAddByBrand( itemidnotin : String,SHOW_ON_TOP : String) throws -> Statement {
           do{
               return  try connection!.prepare("select min(ID) as G_ID,BRAND_ID,BRAND_NAME, item_id, item_name,stk_rate from phitem where (gift_type='ORIGINAL' or  gift_type='OTHER') and SHOW_YN = '1' and SHOW_ON_TOP ='\(SHOW_ON_TOP)' and item_id not in(\(itemidnotin)) GROUP BY BRAND_ID ORDER BY G_ID");
           }catch{
               print(error)
               throw error
           }
    }
    
    public func getAllLeadProducts( itemidnotin : String) throws -> Statement  {
        
        do{
            let query = " Select  T.item_id, ifnull( PH_STK_ITEM_RATE.RATE ,T.stk_rate) as stk_rate,  sn, VSTOCK.STOCK_QTY,VSTOCK.BALANCE ,T.SPL_ID,T.GENERIC_NAME as item_name from (select item_id, item_name,stk_rate, '1' as sn,SPL_ID,GENERIC_NAME from phitem where gift_type='ORIGINAL' and item_id not in(select item_id from phdoctoritem where dr_id=\(itemidnotin)) Union all " +
                " select phitem.item_id,phitem.item_name,phitem.stk_rate,'0' as sn,phitem.SPL_ID,phitem.GENERIC_NAME from phdoctoritem  inner join phitem on phdoctoritem.item_id=phitem.item_id where phdoctoritem.dr_id=\(itemidnotin) order by sn)T " +
                "left join VSTOCK on VSTOCK.ITEM_ID = T.item_id " +
                "left join PH_STK_ITEM_RATE on PH_STK_ITEM_RATE.ITEM_ID = T.item_id and PH_STK_ITEM_RATE.STK_ID ='\(itemidnotin) " +
            "where T.GENERIC_NAME != '' "
            
            //            let query = " Select  T.item_id, item_name,stk_rate,  sn, ifnull( VSTOCK.STOCK_QTY ,0) as STOCK_QTY, ifnull( VSTOCK.BALANCE ,0) as BALANCE from (select item_id, item_name,stk_rate, '1' as sn from phitem where gift_type='ORIGINAL' and item_id not in(select item_id from phdoctoritem where dr_id=\(itemidnotin)) Union all " +
            //                " select phdoctoritem.item_id,phdoctoritem.item_name,phitem.stk_rate,'0' as sn from phdoctoritem  inner join phitem on phdoctoritem.item_id=phitem.item_id where phdoctoritem.dr_id=\(itemidnotin) order by sn)T "
            //                + "left join VSTOCK on VSTOCK.ITEM_ID = T.item_id"
            
            return  try connection!.prepare(query)
            
            
        }catch{
            print(error)
            throw error
        }
        
    }
    
    
    public func getAllProducts( itemidnotin : String) throws -> Statement  {
        
        do{
            
            //            let query =  " Select  T.item_id, item_name,ifnull( PH_STK_ITEM_RATE.RATE ,T.stk_rate) as stk_rate,  sn, VSTOCK.STOCK_QTY,VSTOCK.BALANCE ,T.SPL_ID from (select item_id, item_name,stk_rate, '1' as sn,SPL_ID from phitem where gift_type='ORIGINAL' and item_id not in(select item_id from phdoctoritem where dr_id=\(itemidnotin)) Union all " +
            //                " select phitem.item_id,phitem.item_name,phitem.stk_rate,'0' as sn,phitem.SPL_ID from phdoctoritem  inner join phitem on phdoctoritem.item_id=phitem.item_id where phdoctoritem.dr_id=\(itemidnotin) order by sn)T " +
            //            "left join VSTOCK on VSTOCK.ITEM_ID = T.item_id " +
            //                "left join PH_STK_ITEM_RATE on PH_STK_ITEM_RATE.ITEM_ID = T.item_id and PH_STK_ITEM_RATE.STK_ID ='\(itemidnotin)'"
            
            let query = " Select  T.item_id, item_name,ifnull( PH_STK_ITEM_RATE.RATE ,T.stk_rate) as stk_rate,  sn, ifnull( VSTOCK.STOCK_QTY ,0) as STOCK_QTY, ifnull( VSTOCK.BALANCE ,0) as BALANCE,T.SPL_ID  from (select item_id, item_name,stk_rate, '1' as sn,SPL_ID  from phitem where gift_type='ORIGINAL' and item_id not in(select item_id from phdoctoritem where dr_id=\(itemidnotin)) Union all " +
                " select phdoctoritem.item_id,phdoctoritem.item_name,phitem.stk_rate,'0' as sn,phitem.SPL_ID from phdoctoritem  inner join phitem on phdoctoritem.item_id=phitem.item_id where phdoctoritem.dr_id=\(itemidnotin) order by sn)T "
                + "left join VSTOCK on VSTOCK.ITEM_ID = T.item_id " +
            "left join PH_STK_ITEM_RATE on PH_STK_ITEM_RATE.ITEM_ID = T.item_id and PH_STK_ITEM_RATE.STK_ID ='\(itemidnotin)'"
            
            return  try connection!.prepare(query)
            
            
        }catch{
            print(error)
            throw error
        }
        
    }
    
    
    public func  getDoctorSpecialityCodeByDrId( dr_id : String) throws -> Statement  {
        do{
            return  try connection!.prepare("select phallmst.remark  from phdoctor inner join phallmst on phdoctor.spl_id = phallmst.allmst_id where phdoctor.dr_id=\(dr_id)");
        }catch{
            print(error)
            throw error
        }
    }
    
    public func getDoctorSpecialityIdByDrId( dr_id : String) throws -> Statement  {
        do{
            return  try connection!.prepare("select spl_id from phdoctor where dr_id=\(dr_id)");
        }catch{
            print(error)
            throw error
        }
    }
    
    public func giftDelete() {
        DeleteQry(Table_name: CBO_DB_Helper.DOCTOR_ITEM_TABLE, WhereClause: "dr_id=\( Custom_Variables_And_Method.DR_ID) and item_id in(select item_id from phitem where gift_type='GIFT')")
        delete_DCR_Item(ID: ""+Custom_Variables_And_Method.DR_ID,item_id: nil,ItemType: "GIFT",Category: "DR");
    }
    
    public func getAllGifts( ItemIdNotIn : String) throws -> Statement  {
        do{
            //return  try connection!.prepare("select item_id, item_name,stk_rate from phitem where gift_type='GIFT' ");
            
            return  try connection!.prepare("select phitem.item_id, phitem.item_name,phitem.stk_rate,ifnull( VSTOCK.STOCK_QTY ,0) as STOCK_QTY, ifnull( VSTOCK.BALANCE ,0) as BALANCE from phitem"
                + " left join VSTOCK on VSTOCK.ITEM_ID = phitem.item_id"
                + " where gift_type='GIFT'");
        }catch{
            print(error)
            throw error
        }
    }
    //
    //
    public func delete_phitem(){
        DeleteQry(Table_name: CBO_DB_Helper.PH_ITEM_TABLE, WhereClause: "")
    }
    //
    public func delete_phdoctoritem() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_DOCTOR_ITEM_TABLE, WhereClause: "")
    }
    
    //                public func delete_phdoctor() {
    //                    DeleteQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, WhereClause: "")
    //
    //                }
    
    public func delete_phdoctor(DoNotDeleteCalledDrs : Bool) {
        
        if (DoNotDeleteCalledDrs){
            
            DeleteQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, WhereClause: "not EXISTS(Select 1 FROM tempdr WHERE phdoctor.DR_ID=tempdr.DR_ID)")
            
        }else {
            DeleteQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, WhereClause: "")
        }
        
        
    }
    
    //
    public func delete_phallmst() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_All_Mst, WhereClause: "")
    }
    //
    public func delete_phparty() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Party, WhereClause: "")
    }
    //
    public func delete_phrelation() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Relation, WhereClause: "")
    }
    
    
    public func getSelectedFromDr( dr_id: String) throws -> Statement {
        do{
            return  try connection!.prepare("select item_name,item_id from phdoctoritem where dr_id=" + dr_id + "");
        }catch{
            print(error)
            throw error
        }
    }
    
    public func getSelectedFromDrByBrand( dr_id: String) throws -> Statement {
        
    
        do{
            return  try connection!.prepare("select I.BRAND_ID,I.BRAND_NAME, D.item_name, D.item_id from phdoctoritem D LEFT JOIN phitem I on I.item_id = D.item_id where  SHOW_YN = '1' and dr_id=" + dr_id + " GROUP BY I.BRAND_ID");
        }catch{
            print(error)
            throw error
        }
    }
    
    
    public func getAllItemsForGroup( GroupId : String) throws -> Statement {
           
          
           do{
               //return  try connection!.prepare("select BRAND_ID,BRAND_NAME, item_name, item_id from phitem where  SHOW_YN = '1' and BRAND_ID = " + GroupId + " GROUP BY BRAND_ID");
            
            return  try connection!.prepare("select BRAND_ID,BRAND_NAME, item_name, item_id from phitem where  SHOW_YN = '1' and BRAND_ID = " + GroupId);
            
           
           }catch{
               print(error)
               throw error
           }
       }
    
    //
    public func insertDoctorData( dr_id : Int,item_id : Int,  item_name : String)  {
        var cv = [String : Any]()
        cv["dr_id"] = dr_id
        cv["item_id"] = item_id
        cv["item_name"] = item_name
        insertQry(Table_name: CBO_DB_Helper.PH_DOCTOR_ITEM_TABLE, values: cv);
        
    }
    //
    //    //=========================================================================phdoctor===============================================================================
    
    public func insert_phdoctor(dr_id : Int,  dr_name : String,  dr_code: String,  area : String,  spl_id : Int , LAST_VISIT_DATE : String
        ,  CLASS : String,  PANE_TYPE : String,  POTENCY_AMT : String, ITEM_NAME : String
        ,  ITEM_POB : String ,  ITEM_SALE : String,  DR_AREA : String,  DR_LAT_LONG : String,  FREQ :String,  NO_VISITED :String
        , DR_LAT_LONG2 : String, DR_LAT_LONG3 : String, COLORYN : String, CRM_COUNT : String, DRCAPM_GROUP : String,SHOWYN : String, MAX_REG : Int, RXGENYN : String,APP_PENDING_YN : String) {
        
        var cv = [String : Any]()
        
        cv["dr_id"] = dr_id
        cv["dr_name"] = dr_name
        cv["dr_code"] = dr_code
        cv["area"] =  area
        cv["spl_id"] = spl_id
        cv["LAST_VISIT_DATE"] = LAST_VISIT_DATE
        
        cv["CLASS"] = CLASS
        cv["PANE_TYPE"] =  PANE_TYPE
        cv["POTENCY_AMT"] =  POTENCY_AMT
        cv["ITEM_NAME"] =  ITEM_NAME
        cv["ITEM_POB"] =  ITEM_POB
        cv["ITEM_SALE"] =  ITEM_SALE
        
        cv["DR_AREA"] = DR_AREA
        cv["DR_LAT_LONG"] =  DR_LAT_LONG
        
        cv["FREQ"] = FREQ
        cv["NO_VISITED"] =  NO_VISITED
        
        
        cv["DR_LAT_LONG2"] =  MAX_REG > 1 ? DR_LAT_LONG2:DR_LAT_LONG //DR_LAT_LONG2
        cv["DR_LAT_LONG3"] = MAX_REG > 2 ? DR_LAT_LONG3:DR_LAT_LONG // DR_LAT_LONG3
        cv["COLORYN"] =  COLORYN
        
        cv["CRM_COUNT"] = CRM_COUNT
        cv["DRCAPM_GROUP"] = DRCAPM_GROUP
        cv["SHOWYN"] = SHOWYN
        cv["RXGENYN"] = RXGENYN
        cv["APP_PENDING_YN"] = APP_PENDING_YN
        do{
            let  statement = try connection?.prepare("Select * from " + CBO_DB_Helper.PH_DOCTOR_TABLE + " where dr_id='\(dr_id)'");
            if ((statement?.next()) != nil) {
                updateQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, values: cv, WhereClause: "dr_id='\(dr_id)'")
            } else {
                insertQry(Table_name:CBO_DB_Helper.PH_DOCTOR_TABLE , values: cv)
            }
        }
        catch{
            print(error)
        }
        
        
    }
    
    public func doctorApproved( APP_PENDING_YN : String) {
        // APP_PENDING_YN 0- approved
        var cv = [String : Any]()
        cv["APP_PENDING_YN"] = APP_PENDING_YN
        updateQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, values: cv, WhereClause: "")
        
    }
    
    
    //
    func getDoctorListLocal() throws -> Statement {
        //Cursor c=sd.rawQuery("select phdoctor.dr_id,phdoctor.dr_code,phdoctor.dr_name  from phdoctor left outer join phallmst on phdoctor.spl_id = phallmst.id where phdoctor.area in("+MyConnection.pub_area.toUpperCase(Locale.getDefault())+") order by phdoctor.dr_name", null);
        do{
            return  try connection!.prepare("select phdoctor.dr_id,phdoctor.dr_name,phdoctor.LAST_VISIT_DATE,phdoctor.CLASS,phdoctor.POTENCY_AMT,phdoctor.ITEM_NAME,phdoctor.ITEM_POB,phdoctor.ITEM_SALE,phdoctor.DR_AREA,phdoctor.PANE_TYPE, phdoctor.DR_LAT_LONG ,phdoctor.FREQ, phdoctor.NO_VISITED,phdoctor.DR_LAT_LONG2,phdoctor.DR_LAT_LONG3,phdoctor.COLORYN,phdoctor.CRM_COUNT,phdoctor.DRCAPM_GROUP,phdoctor.SHOWYN,phdoctor.APP_PENDING_YN, cast (phdoctor.PANE_TYPE as int) as PANE_TYPE1, CASE WHEN IFNull(tempdr.dr_id,0) >0 THEN 1 ELSE 0 END AS CALLYN  from phdoctor LEFT OUTER JOIN tempdr  ON phdoctor.DR_ID=tempdr.DR_ID where SHOWYN = '1' order by PANE_TYPE1 DESC");
        }catch{
            print(error)
            throw error
        }
        
    }
    
    
    func getRcDoctorListLocal() throws -> Statement {
        //Cursor c=sd.rawQuery("select phdoctor.dr_id,phdoctor.dr_code,phdoctor.dr_name  from phdoctor left outer join phallmst on phdoctor.spl_id = phallmst.id where phdoctor.area in("+MyConnection.pub_area.toUpperCase(Locale.getDefault())+") order by phdoctor.dr_name", null);
        do{
            return  try connection!.prepare("select phdoctor.dr_id,phdoctor.dr_name,phdoctor.LAST_VISIT_DATE,phdoctor.CLASS,phdoctor.POTENCY_AMT,phdoctor.ITEM_NAME,phdoctor.ITEM_POB,phdoctor.ITEM_SALE,phdoctor.DR_AREA,phdoctor.PANE_TYPE, phdoctor.DR_LAT_LONG ,phdoctor.FREQ, phdoctor.NO_VISITED,phdoctor.DR_LAT_LONG2,phdoctor.DR_LAT_LONG3,phdoctor.COLORYN,phdoctor.CRM_COUNT,phdoctor.DRCAPM_GROUP,phdoctor.SHOWYN ,phdoctor.APP_PENDING_YN,cast (phdoctor.PANE_TYPE as int) as PANE_TYPE1, CASE WHEN IFNull(phdcrdr_rc.dr_id,0) >0 THEN 1 ELSE 0 END AS CALLYN  from phdoctor LEFT OUTER JOIN phdcrdr_rc  ON phdoctor.DR_ID=phdcrdr_rc.DR_ID where SHOWYN = '1' order by PANE_TYPE1 DESC");
        }catch{
            print(error)
            throw error
        }
        
    }
    
    func getDoctorListLocal(plan_type : String? , caltype :String?) throws -> Statement{
        
        var extraQuery : String = "";
        if (plan_type != nil){
            extraQuery = " and PANE_TYPE = " +  plan_type! ;
        }
        if (caltype != nil){
            extraQuery = extraQuery + " and CALLYN = " +  caltype! ;
        }
        
        
        do{
            return  try connection!.prepare("select phdoctor.dr_id,phdoctor.dr_name,phdoctor.LAST_VISIT_DATE,phdoctor.CLASS,phdoctor.POTENCY_AMT,phdoctor.ITEM_NAME,phdoctor.ITEM_POB,phdoctor.ITEM_SALE,phdoctor.DR_AREA,phdoctor.PANE_TYPE,phdoctor.DR_LAT_LONG,phdoctor.FREQ,phdoctor.NO_VISITED,phdoctor.DR_LAT_LONG2,phdoctor.DR_LAT_LONG3,phdoctor.COLORYN,phdoctor.CRM_COUNT,phdoctor.DRCAPM_GROUP,phdoctor.SHOWYN,phdoctor.APP_PENDING_YN, CASE WHEN IFNull(tempdr.dr_id,0) >0 THEN 1 ELSE 0 END AS CALLYN  from phdoctor LEFT OUTER JOIN tempdr  ON phdoctor.DR_ID=tempdr.DR_ID where SHOWYN = '1'" + extraQuery);
        }catch{
            
            print(error)
            throw error
        }
    }
    //
    func getWorkWithLocal() throws -> Statement {
        do{
            return  try connection!.prepare("select pa_name,pa_id from phparty where desig_id >=1 and desig_id <=10 order by pa_name" );
        }catch{
            print(error)
            throw error
        }
    }
    
    
    //=========================================================================phallmst===============================================================================
    //
    public func insert_phallmst( allmst_id : String,  table_name : String,  field_name : String ,  remark : String) {
        
        var cv = [String : Any]()
        cv["allmst_id"] = Int(allmst_id)
        cv["table_name"] = table_name
        cv["field_name"] = field_name
        cv["remark"] = remark
        insertQry(Table_name: CBO_DB_Helper.PH_All_Mst , values: cv)
    }
    //
    //    //=========================================================================phparty===============================================================================
    //
    public func insert_phparty( pa_id : String,  pa_name : String,  desig_id : String,  category : String,  hqid : String , PA_LAT_LONG : String , PA_LAT_LONG2 : String , PA_LAT_LONG3 : String, SHOWYN : String){
        
        var cv = [String : Any]()
        cv["pa_id"] = Int(pa_id)
        cv["pa_name"] = pa_name
        cv["desig_id"] = Int(desig_id)
        cv["category"] = category
        cv["hq_id"] = Int(hqid)
        cv["PA_LAT_LONG"] = PA_LAT_LONG
        cv["PA_LAT_LONG2"] = PA_LAT_LONG2
        cv["PA_LAT_LONG3"] = PA_LAT_LONG3
        cv["SHOWYN"] = SHOWYN
        insertQry(Table_name:CBO_DB_Helper.PH_Party , values: cv)
        
        
    }
    //
    //    =========================================================================phrelation===============================================================================
    
    public func insert_phrelation( pa_id : String ,  under_id : String ,rank : String) {
        
        var cv = [String: Any]()
        cv["pa_id"] = Int(pa_id)
        cv["under_id"] = Int(under_id)
        cv["rank"] = Int(rank)
        insertQry(Table_name: CBO_DB_Helper.PH_Relation, values: cv)
    }
    
    //    //=========================================================================ph-item_pl===============================================================================
    
    public func insert_phitempl( item_id : String,  dr_spl_id : String, srno : String)  {
        var cv = [String: Any]()
        cv["item_id"] = item_id
        cv["dr_spl_id"] = dr_spl_id
        cv["srno"] = Int(srno)
        insertQry(Table_name: CBO_DB_Helper.PH_item_spl, values: cv)
    }
    
    public func delete_phitemspl() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_item_spl, WhereClause: "")
    }
    
    
    public func getphitemSpl()  throws -> Statement {
        //Cursor c=sd.rawQuery("select phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id="+MyConnection.DOCTOR_SPL_ID+" order by phitem.item_name", null);
        do{
            return  try connection!.prepare("select phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id='\(Custom_Variables_And_Method.DOCTOR_SPL_ID!)' order by phitemspl.srno");
        }catch{
            print(error)
            throw error
        }
    }
    
    public func getphitemSplByBrand()  throws -> Statement {
        //Cursor c=sd.rawQuery("select phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id="+MyConnection.DOCTOR_SPL_ID+" order by phitem.item_name", null);
        do{
            return  try connection!.prepare("select phitem.BRAND_ID,phitem.BRAND_NAME,phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id='\(Custom_Variables_And_Method.DOCTOR_SPL_ID!)'  and SHOW_YN = '1' GROUP BY phitem.BRAND_ID order by phitemspl.srno");
        }catch{
            print(error)
            throw error
        }
    }
    //
    //    //=========================================================================Final_dcr_check===============================================================================
    
    public func insertfinalTest( chemist : String,  stockist : String,  exp : String)  {
        var cv = [String : String]()
        cv["chemist"] = chemist
        cv["stockist"] =  stockist
        cv["exp"] =  exp
        insertQry(Table_name: CBO_DB_Helper.Final_DCR_check, values: cv)
        
    }
    //
    public func updatefinalTest( chemist :String,  stockist : String,  exp : String) {
        var cv = [String : String]()
        cv["chemist"] = chemist
        cv["stockist"] = stockist
        cv["exp"] = exp
        updateQry(Table_name: CBO_DB_Helper.Final_DCR_check, values: cv, WhereClause: "")
    }
    //
    //
    public func getFinalSubmit() throws -> Statement {
        
        do{
            return  try connection!.prepare("select * from " + CBO_DB_Helper.Final_DCR_check );
        }catch{
            print(error)
            throw error
        }
        
    }
    //
    public func deleteFinalDcr() {
        DeleteQry(Table_name:CBO_DB_Helper.Final_DCR_check , WhereClause: "")
    }
    
    //===========================================FTP TABLE======================================================================================================
    
    public func insert_FtpData( ip : String,  user : String,  pass:String,  port : String,  path : String,ip_download : String,  user_download : String,  pass_download:String,  port_download : String) {
        var cv = [String : String]()
        cv["ftpip"] = ip
        cv["username"] = user
        cv["password"] = pass
        cv["port"] = port
        cv["path"] = path
        
        cv["ftpip_download"] = ip_download
        cv["username_download"] = user_download
        cv["password_download"] = pass_download
        cv["port_download"] = port_download
        
        insertQry(Table_name: CBO_DB_Helper.FTP_Detail, values: cv)
    }
    
    
    public func getFTPDATA() throws -> Statement   {
        
        do{
            return  try connection!.prepare("select * from ftpdetail");
        }catch{
            print(error)
            throw error
        }
        
        
        //                    sd = this.getWritableDatabase();
        //                    return sd.query("ftpdetail", null, null, null, null, null, null);
    }
    
    
    //    //MARK:- 10-02-2018 adding
    //            public func getFTPDATA() throws -> Statement  {
    //
    //                do{
    //
    //                    return try connection!.prepare("ftpdetail", nil, nil, nil, nil, nil, nil);
    //
    //        //            return  try connection!.prepare("select phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id=\( Custom_Variables_And_Method.DOCTOR_SPL_ID) order by phitemspl.srno");
    //                }catch{
    //                    print(error)
    //                    throw error
    //                }
    //            }
    //
    
    
    public func deleteFTPTABLE() {
        DeleteQry(Table_name: CBO_DB_Helper.FTP_Detail, WhereClause: "")
    }
    //
    //    //======================================================================chemist table=============================================================================
    //
    public func insert_Chemist( chid : Int,  chname : String,  area:String  ,  chem_code : String , LAST_VISIT_DATE : String, DR_LAT_LONG : String, DR_LAT_LONG2 : String, DR_LAT_LONG3 : String,SHOWYN : String)  {
        var cv = [String: Any]()
        cv["chem_id"] =  chid
        cv["chem_name"] =  chname
        cv["chem_code"] =  chem_code
        cv["area"] =  area
        cv["LAST_VISIT_DATE"] =  LAST_VISIT_DATE
        cv["DR_LAT_LONG"] =  DR_LAT_LONG
        cv["DR_LAT_LONG2"] = DR_LAT_LONG2
        cv["DR_LAT_LONG3"] =  DR_LAT_LONG3
        cv["SHOWYN"] = SHOWYN
        
        insertQry(Table_name: CBO_DB_Helper.PH_CHEMIST_TABLE, values: cv)
        
    }
    
    public func updateLatLong( latlong : String,  id :  String, type : String , index : String) {
        
        var cv = [String: Any]()
        
        if (type == "C"){
            cv["DR_LAT_LONG\(index)"] = latlong
            if(index == ("")){
                cv["DR_LAT_LONG2"] = latlong
                cv["DR_LAT_LONG3"] = latlong
                
            }
            updateQry(Table_name: CBO_DB_Helper.PH_CHEMIST_TABLE, values: cv, WhereClause: "chem_id =" + id)
            
        }else if (type == "D") {
            cv["DR_LAT_LONG\(index)"] = latlong
            if(index == ("")){
                cv["DR_LAT_LONG2"] = latlong
                cv["DR_LAT_LONG3"] = latlong
                
            }
            updateQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, values: cv, WhereClause: "dr_id =" + id)
        }else if (type == "DP") {
            cv["DR_LAT_LONG\(index)"] = latlong
            if(index == ("")){
                cv["DR_LAT_LONG2"] = latlong
                cv["DR_LAT_LONG3"] = latlong
                
            }
            updateQry(Table_name: CBO_DB_Helper.PH_DAIRY, values: cv, WhereClause: "DAIRY_ID =" + id)
        } else if (type == "S") {
            cv["PA_LAT_LONG\(index)"] = latlong
            if(index == ("")){
                cv["PA_LAT_LONG2"] = latlong
                cv["PA_LAT_LONG3"] = latlong
                
            }
            updateQry(Table_name: CBO_DB_Helper.PH_Party, values: cv, WhereClause: "pa_id =" + id)
        }
        
        insertLat_Long_Reg(DCS_ID: id,LAT_LONG: latlong,DCS_TYPE: type,DCS_ADD: "",DCS_INDES: index);
        
    }
    
    func updateLatLongOnCall( latlong : String,  id : String, type : String) {
        
        var cv = [String: Any]()
        
        if (type == "C"){
            cv["DR_LAT_LONG"] = latlong
            cv["DR_LAT_LONG2"] = latlong
            cv["DR_LAT_LONG3"] = latlong
            cv["SHOWYN"] = "1"
            updateQry(Table_name: CBO_DB_Helper.PH_CHEMIST_TABLE, values: cv, WhereClause: "chem_id =" + id)
            
        }else if (type == "D") {
            cv["DR_LAT_LONG"] = latlong
            cv["DR_LAT_LONG2"] = latlong
            cv["DR_LAT_LONG3"] = latlong
            cv["SHOWYN"] = "1"
            updateQry(Table_name: CBO_DB_Helper.PH_DOCTOR_TABLE, values: cv, WhereClause: "dr_id =" + id)
        }else if (type == "DP") {
            cv["DR_LAT_LONG"] = latlong
            cv["DR_LAT_LONG2"] = latlong
            cv["DR_LAT_LONG3"] = latlong
            // cv["SHOWYN"] = "1"
            
            updateQry(Table_name: CBO_DB_Helper.PH_DAIRY, values: cv, WhereClause: "DAIRY_ID =" + id)
        } else if (type == "S") {
            cv["PA_LAT_LONG"] = latlong
            cv["PA_LAT_LONG2"] = latlong
            cv["PA_LAT_LONG3"] = latlong
            cv["SHOWYN"] = "1"
            updateQry(Table_name: CBO_DB_Helper.PH_Party, values: cv, WhereClause: "pa_id =" + id)
        }
        
    }
    
    
    public func getChemistListLocal()  throws -> Statement {
        
        do{
            return  try connection!.prepare("select phchemist.chem_id,phchemist.chem_name,phchemist.LAST_VISIT_DATE,DR_LAT_LONG,DR_LAT_LONG2,DR_LAT_LONG3,phchemist.SHOWYN, CASE WHEN IFNull(phdcrchem.chem_id,0) >0 THEN 1 ELSE 0 END AS CALLYN from phchemist LEFT OUTER JOIN phdcrchem  ON phchemist.chem_id=phdcrchem.chem_id where SHOWYN = '1'");
        }catch{
            print(error)
            throw error
        }
        
    }
    
    
    func getLatLong( type : String,  id : String) -> String {
        var latlong = "";
        if (type == ("C")) {
            latlong = getChemistLatLong(chem_id: id);
        }else if (type == ("D")) {
            latlong = getDrCall_latLong(drid: id);
        }else if (type == ("S")) {
            latlong = stockistAllItemLatLong(stk_id: id);
        }
        return latlong;
    }
    
    
    
    public func deleteChemist() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_CHEMIST_TABLE, WhereClause: "")
    }
    //            //============================================================Add Chemist Table================================================================================
    //
    public func addChemistInLocal( chemid : String,chemname : String , visit_time : String,  chem_latLong : String,  chem_address : String,  updated : String, chem_km : String, srno : String, LOC_EXTRA : String)  {
        var cv = [String :  Any ]()
        cv["chem_id"] = chemid
        cv["chem_name"] = chemname
        cv["visit_time"] =  visit_time
        cv["chem_latLong"] =  chem_latLong
        cv["chem_address"] = chem_address
        cv["updated"] = updated
        cv["chem_km"] = chem_km
        cv["srno"] =  srno
        cv["LOC_EXTRA"] =  LOC_EXTRA
        insertQry(Table_name: CBO_DB_Helper.Chemist_Temp, values: cv)
        
    }
    //
    //
    public func updateChemistKilo( km : String,  id : String ) {
        var cv = [String : String]()
        cv["updated"] = "1"
        cv["chem_km"] = km
        updateQry(Table_name: CBO_DB_Helper.Chemist_Temp, values: cv, WhereClause: "chem_id =" + id)
    }
    
    //
    public func getKm_Chemist( chem_id : String) -> String {
        var mychem = "";
        do{
            let statement = try connection!.prepare("select chem_km from chemisttemp where chem_id='" + chem_id + "'")
            while let c = statement.next(){
                mychem =  try c[getColumnIndex( statement : statement , Coloumn_Name: "chem_km")] as! String
            }
        }catch{
            print(error)
        }
        return mychem;
    }
    
    func getRcChemListLocal() throws -> Statement {
        
           do {
               return  try  connection!.prepare("select phchemist.chem_id,phchemist.chem_name,phchemist.LAST_VISIT_DATE," +
                       "DR_LAT_LONG,DR_LAT_LONG2,DR_LAT_LONG3,SHOWYN, CASE WHEN IFNull(phdcrchem_rc.chem_id,0) >0 THEN 1 ELSE 0 END AS CALLYN" +
                       " from phchemist LEFT OUTER JOIN phdcrchem_rc  ON phchemist.chem_id=phdcrchem_rc.chem_id" +
                       " where SHOWYN = '1' ")
           } catch {
               print(error)
               throw error
           }
           
    }
    
    
    public func getRemark_Chemist( chem_id : String) -> String {
        var mychem = "";
        do{
            let statement = try connection!.prepare( "select remark from phdcrchem where chem_id='" + chem_id + "'")
            
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "remark")] as! String
            }
        }catch{
            print(error)
        }
        
        return mychem;
    }
    //
    
    public func getFileChemist( chem_id : String) -> String{
        var mychem = "";
        do{
            let statement = try connection!.prepare("select file from phdcrchem where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "file")] as! String
            }
        }catch{
            print(error)
        }
        
        return mychem;
    }
    public func getRef_LotLong_Chemist( chem_id : String) -> String{
        var mychem = "";
        do{
            let statement = try connection!.prepare("select Ref_latlong from phdcrchem where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "Ref_latlong")] as! String
            }
        }catch{
            print(error)
        }
        
        return mychem;
    }
    //
    
    public func getRate_Chemist( chem_id : String) -> String{
        var mychem = "";
        do{
            let statement = try connection!.prepare("select rate from phdcrchem where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "rate")] as! String
            }
        }catch{
            print(error)
        }
        
        return mychem;
    }
    
    public func getStatus_Chemist( chem_id : String) -> String{
        var mychem = "";
        do{
            let statement = try connection!.prepare("select status from phdcrchem where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "status")] as! String
            }
        }catch{
            print(error)
        }
        
        return mychem;
    }
    
    public func getCompProduct_Chemist( chem_id : String) -> String{
        var mychem = "";
        do{
            let statement = try connection!.prepare("select Competitor_Product from phdcrchem where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "Competitor_Product")] as! String
            }
        }catch{
            print(error)
        }
        
        return mychem;
    }
    
    
    public func getSRNO_Chemist( chem_id : String) -> String {
        var mychem = "";
        do{
            let statement = try connection!.prepare("select srno from chemisttemp where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                mychem = try c[getColumnIndex(statement : statement , Coloumn_Name: "srno")] as! String
            }
            
        }catch{
            print(error)
        }
        
        return mychem;
    }
    
    public func getUpdateChemistAddress( chem_id : String,  chem_address : String){
        
        var cv = [String : String]()
        
        cv["chem_address"] = chem_address
        updateQry(Table_name: "chemisttemp", values: cv, WhereClause: "chem_id =" + chem_id)
        
    }
    //
    //
    public func getChemistLatLong( chem_id : String) -> String {
        var mychem = ""
        do{
            let statement = try connection!.prepare("select * from chemisttemp where chem_id='" + chem_id + "'")
            
            while let c =  statement.next(){
                
                mychem = try (c[getColumnIndex(statement: statement, Coloumn_Name: "chem_latLong")] as! String)
            }
            
        } catch {
            print(error)
        }
        return mychem;
    }
    //
    //
    public func getChemistAddress( chem_id : String)  -> String {
        var mychem = "";
        do {
            
            let statement = try connection!.prepare("select * from chemisttemp where chem_id='" + chem_id + "'")
            while let c =  statement.next(){
                mychem = try c[getColumnIndex( statement : statement , Coloumn_Name: "chem_address")] as! String
                
            }
        }
        catch{
            print(error)
        }
        return mychem;
    }
    public func getChemistLocExtra( chem_id : String)  -> String{
        var mychem = "";
        
        do{
            
            let statement = try connection!.prepare("select * from chemisttemp where chem_id='" + chem_id + "'")
            while let c =  statement.next(){
                mychem = try c[getColumnIndex(statement : statement, Coloumn_Name:  "LOC_EXTRA")] as! String
            }
            
        }catch{
            print(error)
        }
        
        return mychem;
    }
    
    public func chemistListForFinalSubmit( updated : String? = nil ) -> [String] {
        var chem_list = [String]()
        var qry = "select * from chemisttemp"
        
        if (updated != nil) {
            
            qry =  "select * from chemisttemp where updated='" + updated! + "'"
        }
        
        do {
            let statement = try connection!.prepare(qry)
            while let c = statement.next(){
                
                try chem_list.append("\(c[getColumnIndex(statement : statement , Coloumn_Name: "chem_id")]!)")
            }
            
        } catch{
            print(error)
        }
        
        return chem_list;
    }
    
    
    //
    public func deleteTempChemist() {
        DeleteQry(Table_name: CBO_DB_Helper.Chemist_Temp, WhereClause: "")
    }
    //
    func getStockistListLocal() throws -> Statement {
        do{
            return  try connection!.prepare("select phparty.pa_name,phparty.pa_id,phparty.PA_LAT_LONG,phparty.PA_LAT_LONG2,phparty.PA_LAT_LONG3, phparty.SHOWYN ,CASE WHEN IFNull(phdcrstk.stk_id,0) >0 THEN 1 ELSE 0 END AS CALLYN  from phparty LEFT OUTER JOIN phdcrstk  ON phdcrstk.stk_id=phparty.pa_id  where category='STOCKIST' and SHOWYN = '1'");
            
            
            
        }catch{
            print(error)
            throw error
        }
        
    }
    
    
    public func addStockistInLocal( stkid : String,stkname : String)  {
        var cv = [String :  Any ]()
        cv["stk_id"] = stkid
        cv["stk_name"] = stkname
        
        insertQry(Table_name: CBO_DB_Helper.Temp_Stockist, values: cv)
        
    }
    
    public func stockistListForFinalSubmit() throws-> [String]{
        
        return try stockistListForFinalSubmit(updated: nil);
    }
    
    public func stockistListForFinalSubmit( updated : String? = nil) throws -> [String] {
        var chem_list = [String]();
        var statement : Statement!
        do {
            if (updated == nil) {
                statement = try connection!.prepare("select * from phdcrstk");
            }else{
                statement = try connection!.prepare("select * from phdcrstk where updated='"+updated!+"'");
            }
            while let c = statement.next(){
                try chem_list.append(c[getColumnIndex(statement: statement, Coloumn_Name: "stk_id")]! as! String);
            }
        }catch {
            throw error
        }
        
        return chem_list;
    }
    
    //
    public func deleteTempStockist() {
        DeleteQry(Table_name: CBO_DB_Helper.Temp_Stockist, WhereClause: "")
    }
    //    //=================================================================login_detail  table==========================================================================
    //
    //        public func insertLoginDetail( comp_code : String,  db_ip : String, db_name : String,  user : String,  password : String,  ver: String) -> Double {
    //                sd = this.getWritableDatabase();
    //                ContentValues cv = new ContentValues();
    //                cv["company_code", comp_code);
    //                cv["ols_ip", db_ip);
    //                cv["ols_db_name", db_name);
    //                cv["ols_db_user", user);
    //                cv["ols_db_password", password);
    //                cv["ver", ver);
    //
    //                long l= sd.insert("logindetail", null, cv);
    //                return l;
    //            }
    //
    //            public func getDatabaseDetail() -> Cursor {
    //                sd = this.getWritableDatabase();
    //                return sd.rawQuery("select * from logindetail", null);
    //            }
    //
    //
    public func deleteLoginDetail() {
        DeleteQry(Table_name: CBO_DB_Helper.LOGIN_DETAILS, WhereClause: "" )
        
    }
    //    //===============================================================login user details=====================================================================================
    //
    //
    public func insertUserDetails( paid : String, paname : String ,  hqtr :String, desid : String, pubdesid : String,  compname : String,  weburl :String){
        
        var cv = [String :  Any ]()
        cv["pa_id"] =  Int(paid)
        cv["pa_name"] = paname
        cv["head_qtr"] =  hqtr
        cv["desid"] = desid
        cv["pub_desig_id"] = pubdesid
        cv["compny_name"] = compname
        cv["web_url"] = weburl
        //let a : Double = sd.insert("userdetail", null, cv);
        insertQry(Table_name: CBO_DB_Helper.UserDetails, values: cv)
        
    }
    //
    
    
    ////        func InsertContact(name:String,address:String,city:String,zipCode:String ,  phone : String)  {
    ////            var ContantValues = [String :  String ]()
    ////
    ////                ContantValues["NAME"] = name
    ////                ContantValues["ADDRESS"] = address
    ////                ContantValues["CITY"] = city
    ////                ContantValues["ZIP_CODE"] = zipCode
    ////                ContantValues["PHONE"] = phone
    ////
    ////            insertQry(Table_name: CBO_DB_Helper.Contacts, values: ContantValues)
    ////
    ////        }
    
    
    public func insertUserDetail22( loc : String,  visual : String)  {
        var cv = [String :  String ]()
        
        cv["location_required"] = loc
        cv["visual_required"] = visual
        
        insertQry(Table_name: CBO_DB_Helper.UserDetails2, values: cv)
        //                    Long a=sd.insert("userdetail2", null, cv);
        
    }
    
    //            public func getUserDetailLogin() -> Cursor {
    //                    sd = this.getWritableDatabase();
    //                    return sd.rawQuery("select * from userdetail", null);
    //            }
    //
    //    public Cursor getOtherUserDetail() {
    //    sd = this.getWritableDatabase();
    //    return sd.rawQuery("select * from userdetail2", null);
    //    }
    //
    public func getLocationDetail() -> String {
        
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["location_required"]
            
            for x in (try connection?.prepare(Table(CBO_DB_Helper.UserDetails2)))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
            }
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        var companyname : String!
        for i in 0 ..< dataDict.count{
            companyname = dataDict[i]["location_required"]
        }
        
        return (companyname ?? "-1")!
        
        //            String loc = "";
        //            sd = this.getWritableDatabase();
        //            Cursor c = sd.rawQuery("select location_required from userdetail2", null);
        //            try {
        //            if (c.moveToFirst()) {
        //            do {
        //            loc = c.getString(c.getColumnIndex("location_required"));
        //            } while (c.moveToNext());
        //            }
        //            } finally {
        //            c.close();
        //            }
        //            return loc;
    }
    //
    public func getVisualDetail() -> String {
        
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["visual_required"]
            
            for x in (try connection?.prepare(Table(CBO_DB_Helper.UserDetails2)))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
            }
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        var companyname : String!
        for i in 0 ..< dataDict.count{
            companyname = dataDict[i]["visual_required"]
        }
        
        return (companyname ?? "-1")!
        
    }
    //
    public func deleteUserDetail(){
        DeleteQry(Table_name: CBO_DB_Helper.UserDetails, WhereClause: "")
    }
    
    public func deleteUserDetail2(){
        DeleteQry(Table_name: CBO_DB_Helper.UserDetails2, WhereClause: "")
    }
    //================================================================dcr detail============================================================================================
    //
    //
    public func insertDcrDetails( dcrid : String,  pubarea : String) {
        
        var cv = [String : String]()
        cv["dcr_id"] = dcrid
        cv["pub_area"] = pubarea
        insertQry(Table_name: CBO_DB_Helper.DCRRetail, values: cv)
        
        //        sd.insert("dcrdetail", null, cv);
        //        return a;
    }
    //
    //    public Cursor getDCRDetails() {
    //    sd = this.getWritableDatabase();
    //    return sd.rawQuery("select * from dcrdetail", null);
    //    }
    //
    //
    public func deleteDCRDetails() {
        DeleteQry(Table_name: CBO_DB_Helper.DCRRetail, WhereClause: "")
        
        
    }
    //
    //    //================================================================PHDCRCHEM TABLE====================================================================================
    
    
    
   
    func insertChemRem(dcrid : String, chem_id : String, address : String, time : String, latLong : String, updated : String, rc_km : String, srno : String, batteryLevel : String, remark : String, file : String, LOC_EXTRA : String, Ref_latlong : String) {
        
        var cv = [String :  Any ]()
        cv["dcr_id"] = dcrid
        cv["chem_id"] = chem_id
        cv["address"] = address
        cv["time"] =  time
        cv["latLong"] = latLong
        cv["updated"] =  updated
        cv["rc_km"] =  rc_km
        cv["srno"] = srno
        cv["battery_level"] = batteryLevel
        cv["remark"] =  remark
        cv["file"] = file
        cv["LOC_EXTRA"] = LOC_EXTRA
        cv["Ref_latlong"] = Ref_latlong
        insertQry(Table_name: "phdcrchem_rc", values: cv)
    }
    
    
    
    
    
    
    func submitChemistInLocal( dcrid : String, chemid : String, pobamt : String, allitemid : String, allitemqty : String, address : String,allgiftid : String, allgiftqty : String, time : String,battryLevel : String, sample : String, remark : String,file : String,LOC_EXTRA  : String,Ref_latlong : String,rate : String,status : String,Competitor_Product : String) {
        
        var cv = [String :  Any ]()
        cv["dcr_id"] = dcrid
        cv["chem_id"] = chemid
        cv["pob_amt"] = pobamt
        cv["allitemid"] =  allitemid
        cv["allitemqty"] = allitemqty
        cv["address"] =  address
        cv["allgiftid"] =  allgiftid
        cv["allgiftqty"] = allgiftqty
        cv["time"] = time
        cv["battery_level"] = battryLevel
        cv["sample"] = sample
        cv["remark"] =  remark
        cv["file"] = file
        cv["LOC_EXTRA"] = LOC_EXTRA
        cv["Ref_latlong"] = Ref_latlong
        cv["rate"] = rate
        
        cv["status"] = status
        cv["Competitor_Product"] = Competitor_Product
        
        insertQry(Table_name: CBO_DB_Helper.PH_Dcr_chem, values: cv)
        
        delete_DCR_Item(ID: chemid,item_id: nil,ItemType: nil,Category: "CHEM");
        insert_DCR_Item(ID: chemid,ArrITEM_ID: allitemid,ArrQTY: sample,ItemType: "SAMPLE",Category: "CHEM");
        insert_DCR_Item(ID: chemid,ArrITEM_ID: allgiftid,ArrQTY: allgiftqty,ItemType: "GIFT",Category: "CHEM");
        
    }
    
   
    
    public func updateKm_ChemRC(km : String, id : String) {
        
         var cv = [String :  Any ]()
        cv["updated"] = "\(+1)"
        cv["rc_km"] =  km
        
        updateQry(Table_name: "phdcrchem_rc", values: cv, WhereClause: "chem_id=" + id + "")
    }
    
    
   
    
    func updateChemistInLocal(dcrid : String, chemid : String, pobamt : String, allitemid : String,
                              allitemqty : String, address : String,allgiftid : String, allgiftqty : String,
                              time : String, sample : String, remark : String,file : String,rate : String,
                              status : String,Competitor_Product : String) {
        
        var cv = [String :  Any ]()
        cv["dcr_id"] = dcrid
        cv["chem_id"] = chemid
        if allitemid != ""{
            cv["pob_amt"] = pobamt
            cv["allitemid"] =  allitemid
            cv["allitemqty"] = allitemqty
            cv["sample"] = sample
        }
        if(allgiftid != ""){
            cv["allgiftid"] =  allgiftid
            cv["allgiftqty"] = allgiftqty
        }
        //cv["address"] =  address
        
        //cv["time"] = time
        
        cv["remark"] =  remark
        cv["status"] = status
        cv["Competitor_Product"] = Competitor_Product
        
        cv["file"] = file
        cv["rate"] = rate
        updateQry(Table_name: CBO_DB_Helper.PH_Dcr_chem, values: cv, WhereClause: "chem_id=" + chemid + "")
        
        
        delete_DCR_Item(ID: chemid,item_id: nil,ItemType: nil,Category: "CHEM");
        insert_DCR_Item(ID: chemid,ArrITEM_ID: allitemid,ArrQTY: sample,ItemType: "SAMPLE",Category: "CHEM");
        insert_DCR_Item(ID: chemid,ArrITEM_ID: allgiftid,ArrQTY: allgiftqty,ItemType: "GIFT",Category: "CHEM");
    }
    
    
    func searchChemist( chem_id : String) -> [String]{
        
        
        var chem_list = [String]();
        
        do{
            let  statement = try connection?.prepare("select * from \(CBO_DB_Helper.PH_Dcr_chem) where chem_id=" + chem_id + "");
            while let a = statement?.next() {
                try chem_list.append(a[getColumnIndex(statement: statement!, Coloumn_Name: "chem_id")]! as! String)
            }
            
        }catch{
            print(error)
            
        }
        return chem_list
        
    }
    
   
    func getChemRc(updated : String? = nil) -> [String]{
        var drlist = [String]();
        
        var qry = "select * from phdcrchem_rc"
        if (updated != nil) {
            qry = "select * from phdcrchem_rc where updated='\(updated!)'"
        }
        do{
            let  statement = try connection?.prepare(qry);
            while let a = statement?.next() {
                try drlist.append(a[getColumnIndex(statement: statement!, Coloumn_Name: "chem_id")]! as! String)
            }
            
        }catch{
            print(error)
            
        }
        
        return drlist;
    }
    
    
    
    public func getKm_ChemRc(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select rc_km from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "rc_km")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func getSRNO_ChemRc(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select srno from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "srno")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func ChemRc_Battery(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select batteryLevel from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "batteryLevel")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func ChemRc_remark(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select remark from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "remark")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
  
   public func ChemRc_file(chem_id : String) -> String {
       var chtem = "";
       do {
           let statement = try connection!.prepare("select file from phdcrchem_rc where chem_id='" + chem_id + "'")
           while let c = statement.next() {
               chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "file")] as! String)
           }
       }catch{
           print(error)
       }
       
       return chtem;
       
   }
    
    public func ChemRc_RefLatLong(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select Ref_latlong from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "Ref_latlong")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func getTime_ChemRc(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select time from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "time")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func getAddress_ChemRc(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select address from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "address")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func getLatLong_ChemRc(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select latLong from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "latLong")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func getLocExtra_ChemRc(chem_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select LOC_EXTRA from phdcrchem_rc where chem_id='" + chem_id + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "LOC_EXTRA")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    
    public func Chem_RCupdateAllItemAddress(chem_id : String, address : String) {
           
            var cv = [String :  Any ]()
           cv["address"] = address
           
           
           updateQry(Table_name: "phdcrchem_rc", values: cv, WhereClause: "chem_id=" + chem_id + "")
       }
  
    
    
      public func deleteChemRc() {
          DeleteQry(Table_name: "phdcrchem_rc", WhereClause: "")
          
      }
    
        public func delete_ChemistRemainder_from_local_all(chem_id : String) {
            DeleteQry(Table_name: "phdcrchem_rc", WhereClause:  "chem_id=" + chem_id + "")
            
        }
    
    
    //
    //    public ArrayList<String> getChemistItem(String mdrid) {
    //    sd = this.getWritableDatabase();
    //    ArrayList<String> docItems = new ArrayList<String>();
    //    StringBuilder sb = new StringBuilder();
    //    StringBuilder sb_qty = new StringBuilder();
    //    StringBuilder sb_pob = new StringBuilder();
    //    StringBuilder address = new StringBuilder();
    //    StringBuilder gift_id = new StringBuilder();
    //    StringBuilder gift_qty = new StringBuilder();
    //    StringBuilder time = new StringBuilder();
    //    String quer = "select * from phdcrchem where chem_id='" + mdrid + "'";
    //    Cursor c = sd.rawQuery(quer, null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    sb.append(c.getString(c.getColumnIndex("allitemid"))).append(",");
    //    sb_qty.append(c.getString(c.getColumnIndex("allitemqty"))).append(",");
    //    sb_pob.append(c.getString(c.getColumnIndex("pob_amt"))).append(",");
    //    address.append(c.getString(c.getColumnIndex("address"))).append(",");
    //    gift_id.append(c.getString(c.getColumnIndex("allgiftid"))).append(",");
    //    gift_qty.append(c.getString(c.getColumnIndex("allgiftqty"))).append(",");
    //    time.append(c.getString(c.getColumnIndex("time"))).append(",");
    //
    //    }
    //    while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //    docItems.add(sb.toString());
    //    docItems.add(sb_qty.toString());
    //    docItems.add(sb_pob.toString());
    //    docItems.add(address.toString());
    //    docItems.add(gift_id.toString());
    //    docItems.add(gift_qty.toString());
    //    docItems.add(time.toString());
    //
    //    return docItems;
    //    }
    //
    
    public func chemAllItem(chid : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select allitemid from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next() {
                chtem = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "allitemid")] as! String)
            }
        }catch{
            print(error)
        }
        
        return chtem;
        
    }
    
    public func chemAllItemGiftQty( chid : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select allgiftqty from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next(){
                chtem = try c[getColumnIndex(statement : statement , Coloumn_Name: "allgiftqty")] as! String
            }
        }catch{
            print(error)
        }
        return chtem;
    }
    
    public func chemAllItemGiftid(chid : String ) -> String   {
        var chtem = "";
        do{
            let statement = try connection!.prepare("select allgiftid from phdcrchem where chem_id='" + chid + "'")
            
            while let c = statement.next(){
                chtem = try c[getColumnIndex(statement: statement , Coloumn_Name: "allgiftid")] as! String
            }
        }catch{
            print(error)
        }
        
        return chtem;
    }
    
    
    //
    //    public func upDateChemistAddressFinal(String chem_id, String address) {
    //
    //    ContentValues cv = new ContentValues();
    //    sd = this.getWritableDatabase();
    //
    //    cv["address", address);
    //
    //    long result = sd.update("phdcrchem", cv, "chem_id =" + chem_id, null);
    //
    //
    //    }
    //
    public func upDateChemistLocExtra( chem_id : String , address : String) {
        
        var cv = [String:String]()
        cv["LOC_EXTRA"] = address
        updateQry(Table_name: "phdcrchem", values: cv, WhereClause: "chem_id =" + chem_id)
    }
    
    //
    //    public String chemAllItemAddress(String chid) {
    //    String chtem = "";
    //    sd = this.getWritableDatabase();
    //    Cursor c = sd.rawQuery("select address from phdcrchem where chem_id='" + chid + "'", null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    chtem = c.getString(c.getColumnIndex("address"));
    //    } while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //    return chtem;
    //    }
    
    public func chemAllItemLocExtra( chid : String) -> String{
        var chtem = "";
        do{
            let statement  = try connection!.prepare("select LOC_EXTRA from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next() {
                chtem = try c[getColumnIndex(statement: statement , Coloumn_Name:  "LOC_EXTRA")]as! String
            }
        }catch{
            print(error)
        }
        
        return chtem;
    }
    
    
    public func chemAllItemQty( chid : String) -> String{
        var chtem = "";
        do{
            let statement = try connection!.prepare("select allitemqty from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next()
            {
                chtem = try (c[getColumnIndex(statement : statement , Coloumn_Name: "allitemqty")] as! String)
            }
            
        }catch{
            print(error)
        }
        
        return chtem;
    }
    
    public func chemAllItemPob(chid : String) -> String   {
        var chtem = "";
        do{
            
            let statement = try connection!.prepare("select pob_amt from phdcrchem where chem_id='" + chid + "'")
            
            while let c = statement.next(){
                chtem = try c[getColumnIndex(statement : statement , Coloumn_Name:  "pob_amt")] as! String
            }
            
            
        }catch{
            print(error)
        }
        
        
        return chtem;
    }
    
    
    public func chemAllItemSample( chid : String) -> String {
        var sample = "";
        do {
            let statement =  try connection!.prepare("select sample from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next(){
                sample =  try c[getColumnIndex(statement : statement , Coloumn_Name:  "sample")] as! String
            }
            
        } catch{
            print(error)
        }
        
        return sample;
    }
    
    public func chemAllTime(chid : String ) -> String {
        var chtem = "";
        do{
            let statement = try connection!.prepare("select time from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next(){
                chtem = try c[getColumnIndex(statement : statement , Coloumn_Name: "time")] as! String
            }
        }catch{
            print(error)
        }
        return chtem;
    }
    
    
    
    public func chemBatterLevel( chid : String) -> String {
        var level = "";
        do{
            let statement = try connection!.prepare("select battery_level from phdcrchem where chem_id='" + chid + "'")
            while let c = statement.next() {
                level = try (c[getColumnIndex(statement : statement , Coloumn_Name: "battery_level")] as! String)
            }
        }catch{
            print(error)
        }
        
        return level;
    }
    
    
    public func deleteChemistRecordsTable() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_chem  , WhereClause: "")
    }
    
    func insertChemistSample( chem_id :String ,  item_id :String,  item_name :String,  qty  :String,  sample :String) {
        var cv = [String :  Any ]()
        cv["chem_id"] = chem_id
        cv["item_id"] = item_id
        cv["item_name"] = item_name
        cv["qty"] =  qty
        cv["sample"] = sample
        insertQry(Table_name: CBO_DB_Helper.Chemist_Sample , values: cv)
        
    }
    
    func getChemistIdForsample() -> [String]{
        var chem_id = [String]();
        
        do{
            let  statement = try connection?.prepare("select * from \(CBO_DB_Helper.Chemist_Sample)");
            while let a = statement?.next() {
                try chem_id.append(a[getColumnIndex(statement: statement!, Coloumn_Name: "chem_id")]! as! String)
            }
            
        }catch{
            print(error)
            
        }
        return chem_id
        
    }
    
    public func deleteChemistSample() {
        DeleteQry(Table_name: CBO_DB_Helper.Chemist_Sample, WhereClause: "")
        
    }
    //
    //
    //    //================================================================================================================================================================
    
    func submitStockitInLocal( dcrid :Int,  stkid : String, pobamt  : String,  allitemid  : String,
                               allitemqty : String,  address : String,  time  : String,  battery_level  : String,
                               latLong  : String,  updated  : String,  stk_km : String, srno : String, sample  : String, remark : String, file : String,  LOC_EXTRA  : String , allgiftid: String, allgiftqty: String,Ref_latlong : String,rate : String) {
        var cv = [String :  Any ]()
        cv["dcr_id"] = dcrid
        cv["stk_id"] =  stkid
        cv["pob_amt"] = pobamt
        cv["allitemid"] = allitemid
        cv["allitemqty"] =  allitemqty
        
        
        cv["address"] =  address
        cv["time"] =  time
        cv["battery_level"] =  battery_level
        cv["latLong"] = latLong
        cv["updated"] =  updated
        cv["stk_km"] = stk_km
        cv["srno"] =  srno
        cv["sample"] =  sample
        cv["remark"] =  remark
        cv["file"] =  file
        cv["LOC_EXTRA"] = LOC_EXTRA
        
        cv["allgiftid"] =  allgiftid
        cv["allgiftqty"] = allgiftqty
        cv["Ref_latlong"] = Ref_latlong
        cv["rate"] = rate
        
        
        
        insertQry(Table_name: CBO_DB_Helper.PH_Dcr_stk , values: cv)
        
        
        
        delete_DCR_Item(ID: stkid,item_id: nil,ItemType: nil,Category: "STK");
        insert_DCR_Item(ID: stkid,ArrITEM_ID: allitemid,ArrQTY: sample,ItemType: "SAMPLE",Category: "STK");
        insert_DCR_Item(ID: stkid,ArrITEM_ID: allgiftid,ArrQTY: allgiftqty,ItemType: "GIFT",Category: "STK");
        
    }
    //
    func updateStockistInLocal( dcrid : Int, stkid : String, pobamt : String,  allitemid  : String,  allitemqty  : String, address  : String, time  : String, sample  : String, remark  : String, file  : String , allgiftid : String ,allgiftqty : String,rate : String ) {
        var cv = [String :  Any ]()
        cv["dcr_id"] = dcrid
        cv["stk_id"] = stkid
        if allitemid != ""{
            cv["pob_amt"] = pobamt
            cv["allitemid"] =  allitemid
            cv["allitemqty"] = allitemqty
            cv["sample"] =  sample
        }
        
        //cv["address"] =  address
        if allgiftid != ""{
            cv["allgiftid"] =  allgiftid
            cv["allgiftqty"] = allgiftqty
        }
        
        cv["remark"] =  remark
        cv["file"] =  file
        
        
        cv["rate"] = rate
        //cv["time"] =  time
        updateQry(Table_name: CBO_DB_Helper.PH_Dcr_stk , values: cv, WhereClause: "stk_id=\(stkid )")
        
        delete_DCR_Item(ID: stkid,item_id: nil,ItemType: nil,Category: "STK");
        insert_DCR_Item(ID: stkid,ArrITEM_ID: allitemid,ArrQTY: sample,ItemType: "SAMPLE",Category: "STK");
        insert_DCR_Item(ID: stkid,ArrITEM_ID: allgiftid,ArrQTY: allgiftqty,ItemType: "GIFT",Category: "STK");
    }
    
    public func updateStk_Km( km : String , id : String) {
        var cv = [String : String]()
        cv["updated"] = "1"
        cv["stk_km"] = km
        updateQry(Table_name: CBO_DB_Helper.PH_Dcr_stk , values: cv, WhereClause: "stk_id =" + id)
    }
    
    
    
    public func getKm_Stockist( stk_id : String) -> String {
        var value = ""
        do{
            let statement =  try connection!.prepare("select stk_km from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value =  try c[getColumnIndex(statement : statement , Coloumn_Name: "stk_km")] as! String            }
        }catch{
            print(error)
        }
        
        return value;
    }
    
    public func getRemark_Stockist(stk_id : String ) -> String{
        var value = "";
        do{
            let statement = try connection!.prepare("select remark from phdcrstk where stk_id='" + stk_id + "'")
            
            while let c = statement.next() {
                value = try c[getColumnIndex(statement: statement , Coloumn_Name:  "remark")] as! String
            }
        }catch {
            print(error)
        }
        
        return value;
    }
    
    
    public func getFile_Stockist(stk_id : String) -> String {
        var value = "";
        
        do{
            let statement = try connection!.prepare("select file from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement: statement, Coloumn_Name: "file")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    public func getRefLatLong_Stockist(stk_id : String) -> String {
        var value = "";
        
        do{
            let statement = try connection!.prepare("select Ref_latlong from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement: statement, Coloumn_Name: "Ref_latlong")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    public func getRate_Stockist(stk_id : String) -> String {
        var value = "";
        
        do{
            let statement = try connection!.prepare("select rate from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement: statement, Coloumn_Name: "rate")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    public func getSRNO_Stockist(stk_id : String) -> String {
        var value = ""
        do{
            let statement = try connection!.prepare("select srno from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement : statement , Coloumn_Name: "srno")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    
    func searchStockist( skt_id : String) -> [String]{
        var chem_list = [String]();
        
        do{
            let  statement = try connection?.prepare("select * from \(CBO_DB_Helper.PH_Dcr_stk) where stk_id='\(skt_id)'");
            while let a = statement?.next() {
                try chem_list.append(a[getColumnIndex(statement: statement!, Coloumn_Name: "stk_id")]! as! String)
            }
        }catch{
            print(error)
        }
        return chem_list
    }
    
    
    
    public func stockistAllItemAddress( stk_id : String) -> String {
        var value = ""
        do{
            let statement = try connection!.prepare("select address from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex( statement : statement , Coloumn_Name: "address")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    
    public func stockistAllItemLatLong( stk_id : String) -> String {
        var value = ""
        do{
            let statement = try connection!.prepare("select latLong from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try (c[getColumnIndex(statement : statement, Coloumn_Name: "latLong")] as! String);
            }
        }catch{
            print(error)
        }
        
        return value;
    }
    
    public func stockistAllItemLocExtra(stk_id : String) -> String {
        var value = "";
        do{
            let statement = try connection!.prepare("select LOC_EXTRA from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next(){
                value = try c[getColumnIndex(statement : statement , Coloumn_Name: "LOC_EXTRA")] as! String
            }
        }catch{
            print(error)
        }
        
        return value;
    }
    
    public func stockistupdateAllItemAddress( stk_id : String , address : String) {
        
        var cv = [String : String]()
        cv["address"] = address
        updateQry(Table_name: "phdcrstk", values: cv, WhereClause:  "stk_id =" + stk_id)
    }
    
    //
    //    public func stockistupdateAllItemLocExtra(String stk_id, String address) {
    //
    //    ContentValues cv = new ContentValues();
    //    sd = this.getWritableDatabase();
    //
    //    cv["address", address);
    //
    //    long result = sd.update("phdcrstk", cv, "stk_id =" + stk_id, null);
    //
    //
    //    }
    
    
    public func stockistAllItemPOB( stk_id : String) -> String {
        var value = "";
        
        do {
            let statement = try connection!.prepare("select pob_amt from phdcrstk where stk_id='" + stk_id + "'")
            
            while let c = statement.next() {
                value = try (c[getColumnIndex(statement : statement , Coloumn_Name: "pob_amt")] as! String)
            }
        } catch {
            print(error)
        }
        
        return value;
    }
    
    public func stockistAllItemSample( stk_id : String) -> String {
        var value = ""
        do{
            let statement = try connection!.prepare("select sample from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement : statement , Coloumn_Name: "sample")]as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    // MARK:- Update
    
    func stockistAllItemGiftid( stk_id : String) -> String {
        var chtem = "";
        do {
            let statement = try connection!.prepare("select allgiftid from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                chtem = try c[getColumnIndex(statement : statement , Coloumn_Name: "allgiftid")]as! String
            }
        } catch{
            print(error)
        }
        return chtem;
    }
    
    //MARK:- update
    
    func stockistAllItemGiftQty(stk_id : String) -> String {
        var chtem = "";
        
        do {
            let statement = try connection!.prepare("select allgiftqty from phdcrstk where stk_id='" + stk_id + "'")
            
            while let c = statement.next() {
                chtem = try c[getColumnIndex(statement: statement, Coloumn_Name: "allgiftqty")] as! String
            }
        }catch{
            print(error)
        }
        return chtem;
    }
    
    
    public func stockistAllItemQty( stk_id : String) -> String{
        var value = "";
        do{
            let statement = try connection!.prepare("select allitemqty from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try  c[getColumnIndex(statement : statement , Coloumn_Name: "allitemqty")] as! String
            }
        }catch{
            print(error)
        }
        
        return value;
    }
    
    
    public func stockistAllItemId(stk_id : String) -> String {
        var value = ""
        do{
            let statement = try connection!.prepare("select allitemid from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex( statement : statement , Coloumn_Name:  "allitemid")] as! String
            }
        }catch{
            print(error)
        }
        
        
        return value;
    }
    
    public func stockistAllTime(stk_id : String) -> String {
        var value = "";
        do {
            let statement = try connection!.prepare("select time from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex( statement : statement , Coloumn_Name: "time")] as! String
                
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    public func stockist_Battery( stk_id : String) -> String {
        var value = ""
        do{
            let statement = try connection!.prepare("select battery_level from phdcrstk where stk_id='" + stk_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement : statement , Coloumn_Name:  "battery_level")] as! String
            }
        }catch{
            print(error)
        }
        
        return value;
    }
    
    //
    public func deleteStockistRecordsTable() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_stk, WhereClause: "")
    }
    //
    //    //================================================================Util Table======================================================================================
    //
    func insertUtils(area : String) {
        var cv = [String : Any]()
        cv["pub_area"] = area
        insertQry(Table_name:CBO_DB_Helper.Utils , values: cv)
    }
    
    //
    //    public Cursor getUtils() {
    //    sd = this.getWritableDatabase();
    //    return sd.rawQuery("select * from utils", null);
    //    }
    //
    public func deleteUtils() {
        DeleteQry(Table_name: CBO_DB_Helper.Utils, WhereClause: "")
    }
    //    //===============================================================dr-Reminder Table==================================================================================
    //    //String RC_DOCTOR="CREATE TABLE phdcrdr_rc ( id integer primary key,dcr_id text,dr_id text,address text,time text)";
    //
    func insertDrRem( dcrid : String, drid : String,address : String,time : String,latLong : String, updated : String, rc_km : String,srno : String, batteryLevel : String,remark : String,file : String,LOC_EXTRA : String,Ref_latlong : String) {
        var cv =  [String : Any]()
        cv["dcr_id"] = dcrid
        cv["dr_id"] = drid
        cv["address"] = address
        cv["time"] =  time
        cv["latLong"] = latLong
        cv["updated"] = updated
        cv["rc_km"] = rc_km
        cv["srno"] =  srno
        cv["batteryLevel"] = batteryLevel
        cv["remark"] = remark
        cv["file"] =  file
        cv["LOC_EXTRA"] = LOC_EXTRA
        cv["Ref_latlong"] = Ref_latlong
        insertQry(Table_name: "phdcrdr_rc", values: cv)
        
    }
    
    
    public func updateKm_RC( km : String , id : String) {
        
        var cv = [String : String]()
        
        cv["updated"] = "\(1)"
        cv["rc_km"] = km
        updateQry(Table_name: CBO_DB_Helper.PH_Dcr_Dr_rc, values: cv, WhereClause: "dr_id =" + id )
        
    }
    
    //
    //    public ArrayList<String> getDrRc() {
    //
    //        return getDrRc(null);
    //    }
    
    func getDrRc(updated : String? = nil) -> [String]{
        var drlist = [String]();
        
        var qry = "select * from phdcrdr_rc"
        if (updated != nil) {
            qry = "select * from phdcrdr_rc where updated='\(updated!)'"
        }
        do{
            let  statement = try connection?.prepare(qry);
            while let a = statement?.next() {
                try drlist.append(a[getColumnIndex(statement: statement!, Coloumn_Name: "dr_id")]! as! String)
            }
            
        }catch{
            print(error)
            
        }
        
        return drlist;
    }
    
    public func getKm_Rc(drid : String ) -> String{
        var dcrid = ""
        do{
            let statement = try connection!.prepare("select rc_km from phdcrdr_rc where dr_id='" + drid + "'")
            while let c = statement.next() {
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name:  "rc_km")] as! String
            }
        }catch{
            print(error)
        }
        return dcrid;
    }
    
    
    public func getSRNO_Rc( drid : String ) -> String {
        var dcrid = ""
        
        do{
            let statement = try connection!.prepare("select srno from phdcrdr_rc where dr_id='" + drid + "'")
            
            while let  c = statement.next() {
                dcrid = try c[getColumnIndex( statement : statement , Coloumn_Name: "srno")] as! String
            }
        }catch{
            print(error)
        }
        return dcrid;
    }
    
    public func Rc_Battery(dr_id : String) -> String {
        var value = "";
        
        do{
            let statement = try connection!.prepare("select batteryLevel from phdcrdr_rc where dr_id='" + dr_id + "'")
            while let c = statement.next() {
                value = try c[getColumnIndex(statement :statement , Coloumn_Name:  "batteryLevel")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    public func Rc_remark(dr_id : String) -> String  {
        var value = "";
        
        do{
            let statement =  try connection!.prepare("select remark from phdcrdr_rc where dr_id='" + dr_id + "'")
            while let c = statement.next(){
                value = try c[getColumnIndex(statement : statement , Coloumn_Name:  "remark")] as! String
            }
        }catch{
            print(error)
        }
        
        return value;
    }
    
    public func Rc_file(dr_id : String) -> String {
        var value = "";
        
        do{
            let statement =  try connection!.prepare("select file from phdcrdr_rc where dr_id='" + dr_id + "'")
            
            while let c = statement.next() {
                value = try c[getColumnIndex(statement: statement , Coloumn_Name: "file")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    public func Rc_RefLatLong(dr_id : String) -> String {
        var value = "";
        
        do{
            let statement =  try connection!.prepare("select Ref_latlong from phdcrdr_rc where dr_id='" + dr_id + "'")
            
            while let c = statement.next() {
                value = try c[getColumnIndex(statement: statement , Coloumn_Name: "Ref_latlong")] as! String
            }
        }catch{
            print(error)
        }
        return value;
    }
    
    public func getTime_RC( drid : String) -> String {
        var dcrid = "";
        do{
            let statement =  try connection!.prepare("select time from phdcrdr_rc where dr_id='" + drid + "'")
            while let c = statement.next(){
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name:  "time")] as! String
            }
        }catch{
            print(error)
        }
        
        return dcrid;
    }
    
    public func getAddress_RC(drid : String ) -> String {
        var dcrid = ""
        do{
            
            let statement = try connection!.prepare("select address from phdcrdr_rc where dr_id='" + drid + "'")
            while let c = statement.next() {
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name: "address")] as! String
            }
            
        }catch{
            print(error)
        }
        return dcrid;
    }
    
    
    public func getLatLong_RC(drid : String) -> String {
        var dcrid = ""
        do {
            let statement = try connection!.prepare("select latLong from phdcrdr_rc where dr_id='" + drid + "'")
            while let c = statement.next() {
                dcrid = try c[getColumnIndex(statement: statement , Coloumn_Name:  "latLong")] as! String
            }
        }catch{
            print(error)
        }
        return dcrid;
    }
    
    
    public func getLocExtra_RC(drid : String) -> String  {
        var dcrid = ""
        do{
            let statement =  try connection!.prepare("select LOC_EXTRA from phdcrdr_rc where dr_id='" + drid + "'")
            while let c = statement.next() {
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name: "LOC_EXTRA")] as! String
            }
        }catch{
            print(error)
        }
        return dcrid;
    }
    
    
    public func Dr_RCupdateAllItemAddress( drid : String ,  address : String) {
        
        var cv = [String : String]()
        
        cv["address"] = address
        updateQry(Table_name: "phdcrdr_rc ", values: cv , WhereClause: "dr_id =" + drid )
        
    }
    
    public func deleteDoctorRc() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_Dr_rc , WhereClause: "")
    }
    //
    //    //==============================================================================VERSION TABLE==========================================================================
    //
    public func insertVersionInLocal( ver : String) {
        var cv =  [String :  String]()
        cv["ver"] = ver
        insertQry(Table_name: CBO_DB_Helper.Version, values: cv)
    }
    //
    func getNewVersion() -> String {
        var version = "";
        
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["ver"]
            
            for x in (try connection?.prepare(Table(CBO_DB_Helper.Version)))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
            }
            
            for i in 0 ..< dataDict.count{
                version = dataDict[i]["ver"]!
            }
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        
        
        
        return version;
    }
    
    public func deleteVersion() {
        DeleteQry(Table_name: CBO_DB_Helper.Version, WhereClause: "")
    }
    //
    //    //==============================================Doctor Workwith table===================================================================================================
    //    String WORK_WITH_TABLE = "CREATE TABLE dr_workwith ( id integer primary key,workwith text,wwid text)";
    //
    func insertDrWorkWith( wwname :  String, wwid : String) {
        //    sd = this.getWritableDatabase();
        var cv = [String : String]()
        cv["workwith"]  = wwname
        cv["wwid"] = wwid
        insertQry(Table_name: CBO_DB_Helper.Dr_WorkWith , values: cv)
        
    }
    
    
    func getDR_Workwith() throws -> Statement {
        do{
            return  try connection!.prepare("select workwith,wwid from dr_workwith ");
        }catch{
            print(error)
            throw error
        }
        
    }
    //
    func deleteDRWorkWith() {
        DeleteQry(Table_name: CBO_DB_Helper.Dr_WorkWith, WhereClause: "")
    }
    //
    //    //==========================================================doctor added once more==============================================================================
    //String DOCTOR_IN_LOCAL = "CREATE TABLE phdcrdr_more ( id integer primary key,dr_id text,dr_name text,ww1 text,ww2 text,ww3 text,loc text,time text)";
    
    func AddedDoctorMore( drid : String,  drname : String, time : String, ww1 : String, ww2 : String, ww3 : String, loc : String) {
        var cv =  [String :  Any]()
        cv["dr_id"] = drid
        cv["dr_name"] = drname
        cv["time"] = time
        cv["ww1"] = ww1
        cv["ww2"] = ww2
        cv["ww3"] = ww3
        cv["loc"] = loc
        insertQry(Table_name: "phdcrdr_more", values: cv)
        
    }
    
    
    func getDoctorName1() throws -> Statement {
        do{
            return  try connection!.prepare("select * from phdcrdr_more");
        }catch{
            print(error)
            throw error
        }
    }
    
    public func deleteDoctormore(){
        
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_Dr_more, WhereClause: "")
    }
    //
    //∫
    public func getdoctormoreLit( updated : String? = nil) -> [String] {
        var mylist = [String]()
        
        // Cursor c = sd.rawQuery("select dr_id from phdcrdr_more", null);
        var qry = "select distinct dr_id from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE
        
        if (updated != nil) {
            
            qry =  "select distinct dr_id from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + "  where updated ='" + updated! + "'"
        }
        
        do {
            let statement = try connection!.prepare(qry)
            while let c = statement.next(){
                
                try mylist.append(c[getColumnIndex(statement : statement , Coloumn_Name: "dr_id")] as! String)
            }
            
        } catch{
            print(error)
        }
        return mylist;
    }
    //
    //    //===========================================================DCRID table==============================================================================================
    //    String DCR_ID = "CREATE TABLE mydcr ( id integer primary key,dcr_id text)";
    //
    public func putDcrId( dcrid : String) {
        var cv = [String : String]()
        cv["dcr_id"] = dcrid
        insertQry(Table_name: CBO_DB_Helper.MYDCR , values: cv)
    }
    
    public func getDCR_ID_FromLocal() -> String  {
        
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["dcr_id"]
            
            for x in (try connection?.prepare(Table(CBO_DB_Helper.MYDCR)))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
            }
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        var companyname : String!
        for i in 0 ..< dataDict.count{
            companyname = dataDict[i]["dcr_id"]
        }
        
        return (companyname ?? "-1")!
        
        //    String dcrid = "0";
        //    sd = this.getWritableDatabase();
        //    Cursor c = sd.rawQuery("select dcr_id from mydcr", null);
        //    try {
        //    if (c.moveToFirst()) {
        //    do {
        //    dcrid = c.getString(c.getColumnIndex("dcr_id"));
        //    } while (c.moveToNext());
        //    }
        //    } finally {
        //    c.close();
        //    }
        //    return dcrid;
    }
    //
    public func deletedcrFromSqlite() {
        DeleteQry(Table_name: CBO_DB_Helper.MYDCR, WhereClause: "")
        
        
    }
    //
    //    //=======================================================================Resigned Table=================================================================================
    //
    ////
    //
    //    public String getResignedStatus() {
    //    String dcrid = "";
    //    sd = this.getWritableDatabase();
    //    Cursor c = sd.rawQuery("select doryn from resigned", null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    dcrid = (c.getString(c.getColumnIndex("doryn")));
    //    //dcrid.add(c.getString(c.getColumnIndex("dosyn")));
    //    } while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //    return dcrid;
    //    }
    //
    //    public String getResignedReason() {
    //    String dcrid = "";
    //    sd = this.getWritableDatabase();
    //    Cursor c = sd.rawQuery("select * from resigned", null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    dcrid = (c.getString(c.getColumnIndex("dosyn")));
    //    //dcrid.add(c.getString(c.getColumnIndex("dosyn")));
    //    } while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //    return dcrid;
    //    }
    //
    //    public String getPassword() {
    //    String dcrid = "";
    //    sd = this.getWritableDatabase();
    //    Cursor c = sd.rawQuery("select password from resigned", null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    dcrid = c.getString(c.getColumnIndex("password"));
    //    } while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //    return dcrid;
    //    }
    //
    //
    public func deleteResigned() {
        DeleteQry(Table_name: CBO_DB_Helper.Resigned, WhereClause: "")
    }
    //
    //    //====================================================Doctor Table for final submit==================================================================================
    //    //"CREATE TABLE tempdr ( id integer primary key,dr_id text,dr_name text,batteryLevel text,dr_latLong text,dr_address text)";
    func addTempDrInLocal(drid : String, drname : String, visit_time : String, batteryLevel : String, dr_latLong : String,  dr_address : String,  dr_remark : String,  updated : String,  dr_Km : String,  srno : String,  work_with_name : String,  DR_AREA : String,  file : String, call_type : String,  LOC_EXTRA  : String,Ref_latlong : String) {
        
        var cv = [String : Any]()
        cv["dr_id"] =  drid
        cv["dr_name"] =  drname
        cv["visit_time"] = visit_time
        cv["batteryLevel"] = batteryLevel
        cv["dr_latLong"] =  dr_latLong
        cv["dr_address"] =  dr_address
        cv["dr_remark"] = dr_remark
        cv["updated"] =  updated
        cv["dr_km"] =  dr_Km
        cv["srno"] =  srno
        cv["work_with_name"] = work_with_name
        cv["DR_AREA"] = DR_AREA
        cv["file"] = file
        cv["call_type"] = call_type
        cv["LOC_EXTRA"] = LOC_EXTRA
        cv["Ref_latlong"] = Ref_latlong
        
        insertQry(Table_name: "tempdr", values: cv)
        //Long a=sd.insert("tempdr", null, cv);
        //Log.d("javed SRNO table",srno);
        
    }
    //
    
    public func updateRemark_TempDrInLocal( drid : String, dr_remark :String) {
        var cv = [String : Any]()
        cv["dr_remark"] = dr_remark
        updateQry(Table_name: "tempdr", values: cv, WhereClause: "dr_id =" + drid)
        
        //Log.d("javed SRNO table",srno);
    }
    //
    //    public func setUpdateAllZero() {
    //
    //    sd = this.getWritableDatabase();
    //    String drUpdate = "update tempdr set updated ='0'";
    //    sd.execSQL(drUpdate);
    //    String chemUpdate = "update chemisttemp set updated ='0'";
    //    sd.execSQL(chemUpdate);
    //    String stkUpdate = "update phdcrstk set updated ='0'";
    //    sd.execSQL(stkUpdate);
    //    String drRcUpdate = "update phdcrdr_rc set updated ='0'";
    //    sd.execSQL(drRcUpdate);
    //
    //    }
    //
    public func updateDrKilo(km :String,  id : String) {
        
        
        var cv = [String : String]()
        cv["updated"] = "1"
        cv["dr_km"] = km
        updateQry(Table_name: CBO_DB_Helper.Temp_Dr , values: cv, WhereClause: "" )
        
        //        up update("tempdr", cv, "dr_id =" + id, null);
        
    }
    
    //
    public func  tempDrListForFinalSubmit(updated : String? = nil) ->[String]{
        var chem_list = [String]()
        var qry = "select * from tempdr"
        if (updated != nil) {
            qry = "select * from tempdr where updated ='"+updated!+"'"
        }
        do {
            let statement = try connection!.prepare(qry)
            while let c = statement.next(){
                
                try chem_list.append(c[getColumnIndex(statement : statement , Coloumn_Name: "dr_id")]! as! String )
                
            }
            
        } catch{
            print(error)
        }
        return chem_list;
    }
    //
    public func deleteTempDr() {
        
        DeleteQry(Table_name: CBO_DB_Helper.Temp_Dr, WhereClause: "")
        
    }
    
    public  func getDr_Remark(drid : String) -> String {
        var dcrid = "";
        do{
            
            let statement = try connection!.prepare("select dr_remark from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "dr_remark")]! as! String)
            }
        }
        catch{
            print(error)
        }
        
        return dcrid;
    }
    //
    public func getKm_Doctor( drid : String) -> String{
        
        var dcrid = "";
        do{
            
            let statement = try connection!.prepare("select dr_km from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "dr_km")]! as! String)
            }
        }
        catch{
            print(error)
        }
        
        
        return dcrid;
    }
    
    
    public func getSRNO_Doctor( drid : String) -> String {
        
        var dcrid = "";
        do{
            
            let statement = try connection!.prepare("select srno from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "srno")]! as! String)
            }
        }
        catch{
            print(error)
        }
        
        return dcrid;
    }
    
    
    public func getFILE_Doctor(drid : String) -> String {
        
        var dcrid = "";
        do{
            
            let statement = try connection!.prepare("select file from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "file")]! as! String)
            }
        }
        catch{
            print(error)
        }
        
        return dcrid;
        
    }
    
    //
    public func getCALL_TYPE_Doctor(drid : String) -> String {
        
        var dcrid = "";
        do{
            
            let statement = try connection!.prepare("select call_type from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "call_type")]! as! String)
            }
        }
        catch{
            print(error)
        }
        
        return dcrid;
    }
    public func getRef_LatLong_Doctor(drid : String) -> String {
        
        var dcrid = "";
        do{
            
            let statement = try connection!.prepare("select Ref_latlong from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name:  "Ref_latlong")]! as! String)
            }
        }
        catch{
            print(error)
        }
        
        return dcrid;
    }
    
    public func getBattryLevel_RC( drid : String) -> String {
        var dcrid = "";
        do {
            let statement = try connection!.prepare("select batteryLevel from tempdr where dr_id='" + drid + "'")
            while let c =  statement.next(){
                dcrid = try (c[getColumnIndex(statement : statement , Coloumn_Name: "batteryLevel")] as! String)
            }
        }catch {
            print(error)
        }
        
        return dcrid;
    }
    public func updateDrCall_Address( dr_Address : String,  drId : String)  {
        
        var cv = [String : String]()
        
        cv["dr_address" ] = dr_Address
        
        updateQry(Table_name: "tempdr", values: cv, WhereClause: "dr_id =" + drId )
        
    }
    
    
    func  getDrCall_latLong( drid : String) -> String  {
        var dcrid = "";
        do{
            let statement = try connection!.prepare("select dr_latLong from tempdr where dr_id='" + drid + "'")
            
            
            while let c = statement.next() {
                
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name:  "dr_latLong")]! as! String
            }
        }
        catch{
            print(error)
        }
        return dcrid;
    }
    
    
    func getDrCall_Location(drid : String) -> String {
        var dcrid = "";
        do {
            let statement = try connection!.prepare("select dr_address from tempdr where dr_id='" + drid + "'");
            
            
            while let c = statement.next(){
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name:  "dr_address")]! as! String
                
            }
        }
        catch{
            print(error)
        }
        return dcrid;
    }
    
    
    func getDrCall_LocExtra(drid : String) -> String {
        var dcrid = "";
        do {
            let statement = try connection!.prepare("select LOC_EXTRA from tempdr where dr_id='" + drid + "'")
            while let c = statement.next(){
                dcrid = try c[getColumnIndex(statement : statement , Coloumn_Name: "LOC_EXTRA")]! as! String
                
            }
        }
        catch{
            print(error)
        }
        
        return dcrid;
    }
    
    //
    //
    //    public ArrayList<String> getDoctorPrescribed() {
    //    sd = this.getWritableDatabase();
    //    ArrayList<String> doclist1 = new ArrayList<String>();
    //
    //    //String qurey="select * from phdcrdr";
    //    Cursor c = sd.rawQuery("select dr_id from drprescribe", null);
    //
    //
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    doclist1.add(c.getString(c.getColumnIndex("dr_id")));
    //    }
    //    while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //    return doclist1;
    //    }
    //
    //
    //
    //
    //    ////////////////////////////===============Farmer Registration Shivam =============//////////////////////
    //
    //    //  "CREATE TABLE "+PH_Farmer+"(id integer primary key autoincrement,date text,mcc_owner_name text,Mcc_owner_no text,farmer_attendence text,group_meeting_place text,
    //    // product_detail text,IH_staff_attendence text,sale_to_farmer text,order_book_for_mcc text)";
    //    public long Save(String date, String owner_name, String owner_no, String farmer_attendence, String group_meeting_place, String product_detail, String IH_staff_attendence, String farmer_sale, String order_book, String mRemark) {
    //    sd = this.getWritableDatabase();
    //    try {
    //
    //    ContentValues contentValues = new ContentValues();
    //
    //    contentValues.put("date", date);
    //    contentValues.put("mcc_owner_name", owner_name);
    //    contentValues.put("Mcc_owner_no", owner_no);
    //    contentValues.put("farmer_attendence", farmer_attendence);
    //    contentValues.put("group_meeting_place", group_meeting_place);
    //    contentValues.put("product_detail", product_detail);
    //    contentValues.put("IH_staff_attendence", IH_staff_attendence);
    //    contentValues.put("sale_to_farmer", farmer_sale);
    //    contentValues.put("order_book_for_mcc", order_book);
    //    contentValues.put("remark", mRemark);
    //    sd.insert(PH_Farmer, null, contentValues);
    //    //return 1;
    //    } catch (Exception e) {
    //    e.printStackTrace();
    //    }finally {
    //    }
    //
    //    return 0;
    //    }
    //
    //
    func collect_all_data()  -> [String]{
        var idList = [String]();
        do{
            let statement = try connection!.prepare("Select * from " + CBO_DB_Helper.PH_Farmer)
            while let c = statement.next() {
                try idList.append(c[getColumnIndex(statement : statement ,Coloumn_Name: "date")]! as! String);
            }
        }catch{
            print (error)
        }
        
        return idList;
    }
    //
    //
    //    /////////======================= getting all data through id =====================/////////////////
    //
    //
    //    public String date(String id) {
    //
    //    String date = "";
    //    sd= this.getReadableDatabase();
    //
    //    Cursor cursor = sd.rawQuery("select date from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //
    //    date = cursor.getString(cursor.getColumnIndex("date"));
    //    }
    //
    //    }finally {
    //    cursor.close();
    //    }
    //
    //    return date;
    //    }
    //
    //    public String remark_farmar(String id) {
    //
    //    String remark = "";
    //    sd= this.getReadableDatabase();
    //
    //    Cursor cursor = sd.rawQuery("select remark from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //
    //    remark = cursor.getString(cursor.getColumnIndex("remark"));
    //
    //    }
    //
    //    }finally {
    //    cursor.close();;
    //    }
    //
    //    return remark;
    //    }
    //
    //    public String owner_name_mcc(String id) {
    //
    //    String owner_name = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select mcc_owner_name from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    owner_name = cursor.getString(cursor.getColumnIndex("mcc_owner_name"));
    //
    //    }
    //
    //    }finally {
    //    cursor.close();
    //    }
    //
    //    return owner_name;
    //    }
    //
    //
    //    public String owner_no(String id) {
    //    String owner_no = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select Mcc_owner_no  from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    owner_no = cursor.getString(cursor.getColumnIndex("Mcc_owner_no"));
    //
    //    }
    //
    //    }finally {
    //    cursor.close();
    //    }
    //    return owner_no;
    //    }
    //
    //    public String farmer_attendence( String id) {
    //    String farmer_atnd = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select farmer_attendence from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    farmer_atnd = cursor.getString(cursor.getColumnIndex("farmer_attendence"));
    //    }
    //
    //    }finally {
    //    cursor.close();
    //    }
    //    return farmer_atnd;
    //    }
    //
    //    public String meeting_place(String id) {
    //    String meeting_place = "";
    //    sd = this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select group_meeting_place from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    meeting_place = cursor.getString(cursor.getColumnIndex("group_meeting_place"));
    //    }
    //
    //    }finally {
    //    cursor.close();
    //    }
    //    return meeting_place;
    //    }
    //
    //    public String product_detail(String id) {
    //    String product = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select product_detail from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    product = cursor.getString(cursor.getColumnIndex("product_detail"));
    //
    //    }
    //
    //    }finally {
    //    cursor.close();
    //    }
    //    return product;
    //    }
    //
    //    public String IH_staff_attnd(String id) {
    //    String ih_staff = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select IH_staff_attendence from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    ih_staff = cursor.getString(cursor.getColumnIndex("IH_staff_attendence"));
    //    }
    //    }finally {
    //    cursor.close();
    //    }
    //    return ih_staff;
    //    }
    //
    //    public String sale_to_farmer(String id) {
    //    String sale_farmer = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select sale_to_farmer from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    sale_farmer = cursor.getString(cursor.getColumnIndex("sale_to_farmer"));
    //
    //    }
    //    }finally {
    //    cursor.close();
    //    }
    //    return sale_farmer;
    //    }
    //
    //    public String order_book_mcc(String id) {
    //    String order_book = "";
    //    sd= this.getReadableDatabase();
    //    Cursor cursor = sd.rawQuery("select order_book_for_mcc from PHFarmer where id =" + id, null);
    //    try {
    //    if (cursor.moveToFirst()) {
    //    order_book = cursor.getString(cursor.getColumnIndex("order_book_for_mcc"));
    //
    //    }
    //    }finally {
    //    cursor.close();
    //    }
    //    return order_book;
    //    }
    //
    public func deleteFarmar_Table() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Farmer, WhereClause: "")
    }
    //
    //
    //    //////////////////////////////========================////////////////////////////////////////////////////
    //
    //    ///////////////////// RCPA TABLE //////////////////////////////
    //
    //    //    String myRepa ="CREATE TABLE "+PH_RCPA+"(id integer primary key autoincrement,dcr_id text,paid text,drid text,chemid text,month text,itemid text,qty text)";
    //
    public func insertDataRcpa( dcrid : String ,  paid : String,drid : String, chemid : String,  month : String, itemid : String, qty : String) {
        
        var cv =  [String : String]()
        
        cv["dcr_id"]  =  dcrid
        cv["paid"] = paid
        cv["drid"] =  drid
        cv["chemid"] = chemid
        cv["month"] =  month
        cv["itemid"] = itemid
        cv["qty"]  = qty
        
        insertQry(Table_name: CBO_DB_Helper.PH_RCPA, values: cv)
        
    }
    //
    //
    //
    public func deleteRcpa_Table() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_RCPA, WhereClause: "")
    }
    //
    //    /////////////////////////////////////////////////Emp Tracking/////////////////
    //
    //
    //
    public func deleteAllRecord() {
        DeleteQry(Table_name: CBO_DB_Helper.myTable, WhereClause: "")
    }
    //    /////////////////////////////////////////////////Emp Tracking data 10 minutes/////////////////
    //
    //    public Long insertData_latLon10(String lat, String lon, String time, String km,String LOC_EXTRA) {
    //
    //    sd = this.getWritableDatabase();
    //
    //    if(sd.rawQuery("select * from "+latLong10Minute +" where time='"+time+"'", null).getCount()==0) {
    //
    //    ContentValues cv = new ContentValues();
    //    cv["lat", lat);
    //    cv["lon", lon);
    //    cv["time", time);
    //    cv["km", km);
    //    cv["updated", "0");
    //    cv["LOC_EXTRA", LOC_EXTRA);
    //    Long a = sd.insert(latLong10Minute, null, cv);
    //    return a;
    //    }
    //    return 0L;
    //    }
    //
    
    public func latLon10_updated(id : String){
        var cv = [String : String]()
        cv["updated"] = "1"
        updateQry(Table_name: CBO_DB_Helper.latLong10Minute, values: cv, WhereClause: "id =" + id )
    }
    
    //
    //    public Map getDataFromlatLon10(String updated) {
    //
    //    Map<String, ArrayList<String>> DataInMap = new HashMap<String, ArrayList<String>>();
    //
    //    sd = this.getReadableDatabase();
    //    String selectQuery ="";
    //    if (updated==null) {
    //    selectQuery = "select * from " + latLong10Minute;
    //    }else {
    //    selectQuery = "select * from " + latLong10Minute +" where updated='"+updated+"'";
    //    }
    //    Cursor c = sd.rawQuery(selectQuery, null);
    //    ArrayList<String> idList = new ArrayList<String>();
    //    ArrayList<String> latList = new ArrayList<String>();
    //    ArrayList<String> lonList = new ArrayList<String>();
    //    ArrayList<String> timeList = new ArrayList<String>();
    //    ArrayList<String> kmList = new ArrayList<String>();
    //    ArrayList<String> locExtraList = new ArrayList<String>();
    //
    //
    //    try {
    //    if (c.moveToFirst()) {
    //
    //
    //    do {
    //    String id = c.getString(c.getColumnIndex("id"));
    //    String lat = c.getString(c.getColumnIndex("lat"));
    //    String lon = c.getString(c.getColumnIndex("lon"));
    //    String time = c.getString(c.getColumnIndex("time"));
    //    String kmData = c.getString(c.getColumnIndex("km"));
    //    String LocExtraData = c.getString(c.getColumnIndex("LOC_EXTRA"));
    //
    //    idList.add(id);
    //    latList.add(lat);
    //    lonList.add(lon);
    //    timeList.add(time);
    //    kmList.add(kmData);
    //    locExtraList.add(kmData);
    //
    //    } while (c.moveToNext());
    //    DataInMap.put("myId", idList);
    //    DataInMap.put("myLat", latList);
    //    DataInMap.put("myMyLon", lonList);
    //    DataInMap.put("myTime", timeList);
    //    DataInMap.put("myKm", kmList);
    //    DataInMap.put("myLocExtra", locExtraList);
    //
    //
    //    }
    //
    //
    //    }finally {
    //    c.close();
    //    }
    //
    //    return DataInMap;
    //    }
    //
    public func deleteAllRecord10() {
        DeleteQry(Table_name: CBO_DB_Helper.latLong10Minute, WhereClause: "")
    }
    //
    //    public func deleteRecord10(String id) {
    //
    //
    //    sd = getWritableDatabase();
    //    /*
    //     String query = "Delete * from "+myTable;
    //
    //     sd.execSQL(query);*/
    //    sd.delete(latLong10Minute, "id =" + id, null);
    //
    //    }
    //    ////////////////////////////////////ONEmINUTElATlONG////////////////
    //
    //
    //    public Map getDataFromlatLonFromOneMinute() {
    //
    //    Map<String, ArrayList<String>> DataInMap = new HashMap<String, ArrayList<String>>();
    //
    //    sd = this.getReadableDatabase();
    //    String selectQuery = "select * from " + myTable1MinuteLatLong;
    //    Cursor c = sd.rawQuery(selectQuery, null);
    //    ArrayList<String> idList = new ArrayList<String>();
    //    ArrayList<String> latList = new ArrayList<String>();
    //    ArrayList<String> lonList = new ArrayList<String>();
    //    ArrayList<String> timeList = new ArrayList<String>();
    //
    //    try {
    //    if (c.moveToFirst()) {
    //
    //
    //    do {
    //    String id = c.getString(c.getColumnIndex("id"));
    //    String lat = c.getString(c.getColumnIndex("lat"));
    //    String lon = c.getString(c.getColumnIndex("lon"));
    //    String time = c.getString(c.getColumnIndex("time"));
    //
    //    idList.add(id);
    //    latList.add(lat);
    //    lonList.add(lon);
    //    timeList.add(time);
    //
    //    } while (c.moveToNext());
    //    DataInMap.put("myId", idList);
    //    DataInMap.put("myLat", latList);
    //    DataInMap.put("myMyLon", lonList);
    //    DataInMap.put("myTime", timeList);
    //
    //
    //    }
    //
    //
    //    }finally {
    //    c.close();
    //    }
    //
    //
    //    return DataInMap;
    //    }
    //
    public func deleteAllRecordFromOneMinute() {
        DeleteQry(Table_name: CBO_DB_Helper.myTable1MinuteLatLong, WhereClause: "")
        
    }
    //
    //    //////////////////////
    public func getPaid() -> String {
        
        var companyname : String! = "-1"
        do{
            let statement = try connection!.prepare("select pa_id  from " + CBO_DB_Helper.UserDetails)
            
            while let c = try statement.failableNext(){
                try companyname = "\(c[getColumnIndex(statement : statement , Coloumn_Name : "pa_id")]!)"
            }
        }catch{
            print(error)
        }
        
        return (companyname ?? "-1")!
        
    }
    //
    public func getPaName() -> String{
        
        var companyname : String! = "-1"
        do{
            let statement = try connection!.prepare("select pa_name  from " + CBO_DB_Helper.UserDetails)
            
            while let c = statement.next(){
                try companyname = c[getColumnIndex(statement : statement , Coloumn_Name : "pa_name")] as! String
            }
        }catch{
            print(error)
        }
        
        return (companyname ?? "-1")!
        
        
    }
    
    public func getHeadQtr() -> String{
        var companyname : String! = "-1"
        do{
            let statement = try connection!.prepare("select head_qtr  from " + CBO_DB_Helper.UserDetails)
            
            while let c = statement.next(){
                try companyname = c[getColumnIndex(statement : statement , Coloumn_Name : "head_qtr")] as! String
            }
        }catch{
            print(error)
        }
        
        return (companyname ?? "-1")!
    }
    
    
    //
    public func getDESIG() -> String {
        
        var companyname : String! = "-1"
        do{
            let statement = try connection!.prepare("select desid  from " + CBO_DB_Helper.UserDetails)
            
            while let c = statement.next(){
                try companyname = c[getColumnIndex(statement : statement , Coloumn_Name : "desid")] as! String
            }
        }catch{
            print(error)
        }
        
        return (companyname ?? "-1")!
        
        //                    String paname = "";
        //            Cursor c = getUserDetailLogin();
        //            try {
        //            if (c.moveToFirst()) {
        //            do {
        //            paname = c.getString(c.getColumnIndex("desid"));
        //            } while (c.moveToNext());
        //            }
        //            }finally {
        //            c.close();
        //            }
        //            return paname;
    }
    
    //    public String getDCR_ID() {
    //    String paname = "";
    //    Cursor c = getDCRDetails();
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    paname = c.getString(c.getColumnIndex("dcr_id"));
    //    } while (c.moveToNext());
    //    }
    //    }finally {
    //    c.close();
    //    }
    //    return paname;
    //    }
    //
    public func getPUB_AREA() -> String{
        
        var reseult : String! = "-1"
        do{
            let statement = try connection!.prepare("select pub_area  from " + CBO_DB_Helper.Utils)
            
            while let c = statement.next(){
                try reseult = c[getColumnIndex(statement : statement , Coloumn_Name : "pub_area")] as! String
            }
        }catch{
            print(error)
        }
        
        return (reseult ?? "-1")!
        
    }
    //
    public func getPUB_DESIG() -> String {
        
        var reseult : String! = "-1"
        do{
            let statement = try connection!.prepare("select pub_desig_id  from " + CBO_DB_Helper.UserDetails)
            
            while let c = statement.next(){
                try reseult = c[getColumnIndex(statement : statement , Coloumn_Name : "pub_desig_id")] as! String
            }
        }catch{
            print(error)
        }
        
        return (reseult ?? "-1")!
    }
    
    public func getCOMP_NAME() -> String {
        
        var companyname : String! = "-1"
        do{
            let statement = try connection!.prepare("select compny_name from " + CBO_DB_Helper.UserDetails)
            
            while let c = try statement.failableNext(){
                try companyname = c[getColumnIndex(statement : statement , Coloumn_Name : "compny_name")] as? String
            }
        }catch{
            print(error)
        }
        
        return (companyname ?? "-1")!
    }
    //
    public func getWEB_URL() -> String{
        
        var companyname : String! = "-1"
        do{
            let statement = try connection!.prepare("select web_url from " + CBO_DB_Helper.UserDetails)
            
            while let c = statement.next(){
                try companyname = c[getColumnIndex(statement : statement , Coloumn_Name : "web_url")] as! String
            }
        }catch{
            print(error)
        }
        return (companyname ?? "-1")!
        
    }
    
    
    //
    //    public Cursor dataFromAllTables() {
    //
    //    Cursor resultSet;
    //    sd = this.getReadableDatabase();
    //    String query = "select id,'tempdr' as Doc_Type, cast(visit_time as float) as tm, dr_latLong as latLong,updated , cast (srno as int) as srno from tempdr Union all select id,'chemisttemp' as Doc_Type, cast(visit_time as float) as tm, chem_latLong as latLong,updated , cast (srno as int) as srno from chemisttemp Union all select id, 'phdcrstk' as Doc_Type,cast(time as float) as tm, latLong as latLong ,updated , cast (srno as int) as srno from phdcrstk Union all select id, 'phdcrdr_rc' as Doc_Type,cast (time as float) as tm, latLong as latLong ,updated , cast (srno as int) as srno from phdcrdr_rc order by  srno  asc";
    //    // String query = "select id,'tempdr' as Doc_Type,visit_time as tm, dr_latLong as latLong,updated from tempdr Union all select id,'chemisttemp' as Doc_Type,visit_time as tm, chem_latLong as latLong,updated from chemisttemp Union all select id, 'phdcrstk' as Doc_Type,time as tm, latLong as latLong ,updated from phdcrstk Union all select id, 'phdcrdr_rc' as Doc_Type,time as tm, latLong as latLong ,updated from phdcrdr_rc order by tm asc";
    //    resultSet = sd.rawQuery(query, null);
    //
    //    if (resultSet.moveToFirst()) {
    //    return resultSet;
    //    } else {
    //    return null;
    //    }
    //
    //
    //    }
    //    //   "CREATE TABLE " + MenuControl + "(id Integer PRIMARY KEY AUTOINCREMENT,menu text,menu_code text,menu_name text)";
    //
    //
    public func insertMenu( menu: String, menu_code :String, menu_name : String, menu_url :String, main_menu_srno : String) {
        
        var cv = [String :String ]()
        
        cv["menu"] = menu
        cv["menu_code"] = menu_code
        cv["menu_name"] = menu_name
        cv["menu_url"] = menu_url
        cv["main_menu_srno"] = main_menu_srno
        insertQry(Table_name: CBO_DB_Helper.MenuControl, values: cv)
    }
    
    
    
    //MARK:- get menu function old
    public func getMenu( menu : String , code : String) ->[[String: String]]{
        
        var MenuDataInMap =  [[String : String]]()
        var alice : Table!
        if (code == "") {
            alice = Table(CBO_DB_Helper.MenuControl).filter(Expression<String>("menu") == menu)
        }else{
            alice = Table(CBO_DB_Helper.MenuControl).filter(Expression<String>("menu") == menu).filter(Expression<String>("menu_code") == code)
        }
        
        do {
            let colArray =  ["menu_code","menu_name"]
            for x in (try connection?.prepare(alice))! {
                MenuDataInMap.append( getColValue(row: x, dataDict: colArray ))
            }
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        return MenuDataInMap
    }
    
    // MARK:- get menu function new
    
    
    public func getMenuNew( menu :String,  code : String) throws -> [String : String] {
        
        var MenuDataInMap = [String: String]()
        var query = ""
        if (code == "") {
            query = "Select * from " + CBO_DB_Helper.MenuControl + " where menu=" + "'" + menu + "'";
        }else{
            query = "Select * from " + CBO_DB_Helper.MenuControl + " where  menu=" + "'" + menu + "' and menu_code=" + "'" + code + "'";
            MenuDataInMap[code] =  ""
        }
        //  String query = "Select * from " + MenuControl;
        do {
            
            let statement = try connection!.prepare(query)
            
            while let c = statement.next() {
                
                let menuCode = try c[getColumnIndex(statement: statement, Coloumn_Name :"menu_code")] as! String
                let menuName =  try c[getColumnIndex(statement: statement, Coloumn_Name :"menu_name")] as! String
                if (menuName != ("NA")){
                    MenuDataInMap[menuCode] =  menuName
                }
            }
            
        }catch{
            throw error
        }
        return MenuDataInMap;
    }
    
    
    
    public func getTab() -> [[String: String]]   {
        let alice = Table(CBO_DB_Helper.MenuControl).group([Expression<String>("menu")]).order([Expression<String>("main_menu_srno")])
        
        var MenuDataInMap =  [[String : String]]()
        do {
            let colArray =  ["menu"]
            
            for x in (try connection?.prepare(alice))! {
                MenuDataInMap.append( getColValue(row: x, dataDict: colArray ))
            }
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        return(MenuDataInMap)
    }
    
    
    
    
    public func getMenuUrl( menu : String, menu_code : String ) -> String {
        
        var url : String = ""
        
        let alice = Table(CBO_DB_Helper.MenuControl).filter(Expression<String>("menu") == menu).filter(Expression<String>("menu_code") == menu_code)
        
        //          "Select * from " + MenuControl + " where menu=" + "'" + menu + "' and menu_code='"+menu_code+"'";
        
        
        
        var dataDict = [[String : String]]()
        do {
            let colArray =  ["menu_url"]
            //
            for x in (try connection?.prepare(alice))!{
                dataDict.append( getColValue(row: x, dataDict: colArray ))
                
            }
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
        }
        
        for i in 0 ..< dataDict.count{
            url = dataDict[i]["menu_url"]!
        }
        
        return url.replacingOccurrences(of: "amp;", with: "");
    }
    
    
    
    public func getmenu_count(  table : String) -> Int {
        
        let alice = Table(table)
        do {
            var rowCount = 0
            
            for x in (try connection?.prepare(alice))!{
                rowCount += 1
            }
            return rowCount
            
        }catch{
            let nserror = error as NSError
            print("can not fine  data . Error \(nserror) , \(nserror.userInfo)")
            return 0
        }
        //        let cnt  = DatabaseUtils.queryNumEntries(sd, table);
        //        return Integer.parseInt(1""+cnt);
        
    }
    
    
    
    public func getCalledArea() -> [String]{
        
        var areaList = [String]();
        let Query = "select DISTINCT area from (" +
            "Select phchemist.area from chemisttemp left join phchemist on chemisttemp.chem_id= phchemist.chem_id " +
            "UNION All " +
            "Select DR_AREA as area from tempdr" +
        ")T where T.area != ''";
        
        
        do {
            
            let statement = try connection!.prepare(Query)
            
            while let c = statement.next() {
                areaList.append(c[try getColumnIndex(statement: statement, Coloumn_Name :"area")] as! String)
            }
            
        }catch{
            print(error)
        }
        return areaList;
    }
    
    
    func  getCallDetail(table:String ,look_for_id:String, show_edit_delete:String) -> [String : [String]] {
        
        var Tabs = [String : [String]]()
        var query="";
        var name="";
        var time="";
        var id="";
        var where_cluse="";
        var idList,nameList,timeList,sample_id,sample_name,sample_qty,sample_pob,sample_noc,remark,gift_id,gift_name,gift_qty,show_edit_delete_list
        ,dr_class_list,dr_potential_list,dr_area_list,dr_work_with_list,attachment_list , IS_INTRESTED : [String]!
        
        
        var visible_status = [String]()
        
        idList = [String]()
        nameList = [String]()
        timeList = [String]()
        
        sample_id = [String]()
        sample_name = [String]()
        sample_qty = [String]()
        
        gift_id = [String]()
        gift_name = [String]()
        gift_qty = [String]()
        
        sample_pob = [String]()
        sample_noc = [String]()
        remark = [String]()
        show_edit_delete_list = [String]()
        
        dr_class_list = [String]()
        dr_potential_list = [String]()
        dr_area_list = [String]()
        dr_work_with_list = [String]()
        attachment_list = [String]()
        IS_INTRESTED = [String]()
        
        do {
            if (table == "chemisttemp") {
                id = "chem_id";
                name = "chem_name";
                time = "visit_time";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select  chem_id,chem_name,visit_time from " + table + " " + where_cluse + " order by srno";
            } else if (table == "tempdr") {
                id = "dr_id";
                name = "dr_name";
                time = "visit_time";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select  dr_id,dr_name,visit_time,dr_remark,work_with_name,DR_AREA,call_type from " + table + " " + where_cluse + " order by srno";
            } else if (table == "phdcrstk") {
                id = "stk_id";
                name = "stk_id";
                time = "time";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select  stk_id,time,remark from " + table + " " + where_cluse + " order by srno";
            } else if (table == "phdcrdr_rc") {
                id = "dr_id";
                name = "dr_id";
                time = "time";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select  dr_id,time,remark from " + table + " " + where_cluse + " order by srno";
            } else if (table == "phdcrchem_rc") { //@rinku
                id = "chem_id";
                name = "chem_id";
                time = "time";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select  chem_id,time,remark from " + table + " " + where_cluse + " order by srno";
            } else if (table == "Expenses") {
                id = "exp_head_id";
                name = "exp_head";
                time = "amount";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select * from " + CBO_DB_Helper.Expenses ;
            }else if (table == "nonListed_call") {
                id = "sRemark";
                name = "sDrName";
                time = "time";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select * from " + CBO_DB_Helper.NonListed_call ;
            }else if (table == "appraisal") {
                id = "PA_ID";
                name = "PA_NAME";
                time = "sGRADE_NAME_STR";
                if (look_for_id != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select * from " + CBO_DB_Helper.Appraisal + " where FLAG=1";
            }else if (table == "tenivia_traker") {
                id = "DR_ID";
                name = "DR_NAME";
                time = "TIME";
                if (look_for_id  != "") {
                    where_cluse = " where " + id + "='" + look_for_id + "'";
                }
                query = "Select * from " + CBO_DB_Helper.Tenivia_traker + " " + where_cluse;
                
                // MARK:- Dairy Include
            }else if (table == "Dairy" || table == "Poultry") {
                id = "DAIRY_ID";
                name = "DAIRY_NAME";
                time = "visit_time";
                
                if (table == "Dairy") {
                    where_cluse = " where DOC_TYPE = 'D'" ;
                }else{
                    where_cluse = " where DOC_TYPE = 'P'" ;
                }
                
                if (look_for_id != "") {
                    where_cluse = where_cluse + " and " + id + "='" + look_for_id + "'";
                }
                query = "Select * from " + CBO_DB_Helper.PH_DAIRY_DCR + " " + where_cluse;
            }
            
            let  statement  = try connection!.prepare(query)
            
            while let c = statement.next(){
                
                var dr_sample_id = ""
                var dr_sample_name = "";
                var dr_sample_qty = "";
                var dr_gift_id = "";
                var dr_gift_name = "";
                var dr_gift_qty = "";
                var dr_sample_pob = "";
                var dr_sample_noc="";
                var pob_amt="0";
                var dr_remark="";
                
                var dr_class = "";
                var dr_potential = "";
                var dr_area = "";
                var dr_work_with="";
                var attachment="";
                
                
                let dr_id = try "\(c[getColumnIndex(statement: statement, Coloumn_Name: id)]!)"
                
                var dr_name = try c[getColumnIndex(statement: statement, Coloumn_Name: name)] as! String
                
                let dr_time = try c[getColumnIndex(statement: statement, Coloumn_Name: time)] as! String
                
                
                if (table == "phdcrstk") {
                    if try (c[getColumnIndex(statement : statement , Coloumn_Name :  "remark")] as! String != "") {
                        dr_remark = try c[getColumnIndex(statement : statement , Coloumn_Name :  "remark")] as! String
                    }
                    let  statement1  = try connection!.prepare("select pa_name, pa_id from phparty where category='STOCKIST' and pa_id='" + dr_id + "'");
                    
                    
                    while let c1 = statement1.next() {
                        //do {
                        try dr_name = c1[getColumnIndex(statement : statement1 , Coloumn_Name : "pa_name")] as! String
                        //} while (c1.moveToNext());
                    }
                    
                    
                    let statement2 = try connection!.prepare("select allitemid,allitemqty,sample,pob_amt,allgiftqty,allgiftid  from phdcrstk where stk_id='" + dr_id + "'")
                    
                    
                    while let c2 = statement2.next(){
                        
                        
                        dr_sample_id = try c2[getColumnIndex(statement : statement2 ,Coloumn_Name : "allitemid")] as! String
                        
                        dr_sample_qty = try c2[getColumnIndex(statement : statement2 ,Coloumn_Name :"sample")] as! String
                        dr_sample_pob = try c2[getColumnIndex(statement : statement2 ,Coloumn_Name :"allitemqty")] as! String
                        
                        
                        
                        dr_gift_id = try c2[getColumnIndex(statement : statement2 ,Coloumn_Name :"allgiftid")] as! String
                        dr_gift_qty = try c2[getColumnIndex(statement : statement2 ,Coloumn_Name :"allgiftqty")] as! String
                        
                        pob_amt = try c2[getColumnIndex(statement : statement2 ,Coloumn_Name :"pob_amt")] as! String
                        
                    }
                    
                    
                    var dr_sample_id_list = dr_sample_id.components(separatedBy: ",")
                    
                    
                    for i in 0 ..< dr_sample_id_list.count {
                        let statement3 = try connection!.prepare( "select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' and item_id='" + dr_sample_id_list[i] + "'")
                        
                        var saparator=",";
                        if (i == 0){
                            saparator = ""
                        }
                        
                        
                        while let c3 = statement3.next() {
                            dr_sample_name = try dr_sample_name + saparator + "\(c3[getColumnIndex(statement: statement3, Coloumn_Name: "item_name")] as! String)"
                        }
                    }
                    
                    
                    
                    var dr_gift_id_list = dr_gift_id.components(separatedBy: ",")
                    for  i in 0 ..< dr_gift_id_list.count {
                        
                        let statement3 = try connection!.prepare( "select item_id, item_name,stk_rate from phitem where gift_type='GIFT' and item_id='" + dr_gift_id_list[i] + "'")
                        
                        //                        Cursor c4 = sd.rawQuery("select item_id, item_name,stk_rate from phitem where gift_type='GIFT' and item_id='" + dr_gift_id_list[i] + "'", null);
                        
                        var saparator=",";
                        if (i==0){
                            saparator="";
                        }
                        
                        while let c3 = statement3.next() {
                            dr_gift_name = try dr_gift_name + saparator + "\(c3[getColumnIndex(statement: statement3, Coloumn_Name: "item_name")] as! String)"
                        }
                    }
                    
                    
                    
                } else if (table == "phdcrdr_rc") { // if close
                    
                    if try (c[getColumnIndex(statement: statement, Coloumn_Name : "remark")] as! String == "") {
                        dr_remark = try c[getColumnIndex(statement: statement, Coloumn_Name : "remark")] as! String
                        
                    }
                    
                    let statement1  = try connection!.prepare("select dr_id,dr_name,CLASS,POTENCY_AMT,DR_AREA,PANE_TYPE  from phdoctor where dr_id='" + dr_id + "'")
                    
                    
                    while let c1 = statement1.next() {
                        
                        dr_name = try c1[getColumnIndex(statement: statement1, Coloumn_Name :"dr_name")] as! String
                        dr_area = try c1[getColumnIndex(statement: statement1, Coloumn_Name :"DR_AREA")] as! String
                        dr_class = try c1[getColumnIndex(statement: statement1, Coloumn_Name :"CLASS")] as! String
                        dr_potential = try c1[getColumnIndex(statement: statement1, Coloumn_Name : "POTENCY_AMT")] as! String
                    }
                    
                }   // else close
                else if (table ==  "tempdr" ) {
                    var pob : Float = 0.0
                    
                    if try (c[getColumnIndex( statement : statement , Coloumn_Name:  "dr_remark")] as! String  == "") {
                        dr_remark = try c[getColumnIndex(statement : statement , Coloumn_Name:  "dr_remark")] as! String
                    }
                    
                    dr_work_with = try c[getColumnIndex(statement : statement , Coloumn_Name : "work_with_name")] as! String
                    dr_area = try c[getColumnIndex(statement: statement , Coloumn_Name : "DR_AREA")] as! String
                    
                    if try (c[getColumnIndex(statement : statement , Coloumn_Name : "call_type")] as! String == "2"){
                        dr_name+="(U)"
                    }
                    else if try (c[getColumnIndex(statement : statement , Coloumn_Name : "call_type")] as! String == "1"){
                        dr_name+="(M)";
                    }else{
                        dr_name+="(P)";
                    }
                    
                    var statement1 = try connection!.prepare("select CLASS,POTENCY_AMT,PANE_TYPE  from phdoctor where dr_id='" + dr_id + "'")
                    
                    
                    while let c1 = statement1.next(){
                        
                        dr_class = try c1[getColumnIndex(statement : statement1 , Coloumn_Name:  "CLASS")] as! String
                        dr_potential = try c1[getColumnIndex(statement : statement1 , Coloumn_Name:  "POTENCY_AMT")] as! String
                        
                    }
                    
                    
                    statement1 = try connection!.prepare("select dr_id,item_id,item_name,pob,qty,stk_rate,noc from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + " where dr_id='" + dr_id + "'")
                    
                    while let c1 =  statement1.next() {
                        
                        if try (c1[getColumnIndex(statement: statement1 , Coloumn_Name: "stk_rate")] as! String != "x") {
                            
                            dr_sample_id = try c1[getColumnIndex(statement : statement1 , Coloumn_Name: "item_id")] as! String + "," + dr_sample_id;
                            dr_sample_name = try c1[getColumnIndex(statement : statement1 , Coloumn_Name: "item_name")] as! String + "," + dr_sample_name;
                            dr_sample_qty = try c1[getColumnIndex(statement : statement1 , Coloumn_Name:"qty")] as! String + "," + dr_sample_qty;
                            dr_sample_pob = (try c1[getColumnIndex(statement :  statement1 , Coloumn_Name:  "pob")] as! String).replacingOccurrences(of: "\n", with: "") + "," + dr_sample_pob;
                            dr_sample_noc = try  c1[getColumnIndex(statement : statement1 , Coloumn_Name: "noc")] as! String + "," + dr_sample_noc;
                            pob +=  Float((try c1[getColumnIndex( statement : statement1 , Coloumn_Name: "pob")]as! String).replacingOccurrences(of: "\n", with: ""))! * Float( try c1[getColumnIndex(statement : statement1 , Coloumn_Name: "stk_rate")] as! String)!
                        }
                        //Log.v("javed tab",c1.getString(c1.getColumnIndex("dr_id"))+"\n"+dr_sample_name+"\n"+dr_sample_qty+"\n"+dr_sample_pob);
                        
                    }
                    
                    statement1 = try connection!.prepare("select dr_id,item_id,item_name,pob,qty,stk_rate  from " + CBO_DB_Helper.DOCTOR_ITEM_TABLE + " where dr_id='" + dr_id + "'")
                    
                    while let c1 = statement1.next() {
                        
                        if try (c1[getColumnIndex(statement: statement1 , Coloumn_Name: "stk_rate")] as! String == "x") {
                            dr_gift_id = try c1[getColumnIndex(statement : statement1 , Coloumn_Name: "item_id")] as! String + "," + dr_gift_id;
                            dr_gift_name = try c1[getColumnIndex(statement: statement1 , Coloumn_Name: "item_name")] as! String + "," + dr_gift_name;
                            dr_gift_qty = try c1[getColumnIndex(statement: statement1 , Coloumn_Name: "qty")] as! String + "," + dr_gift_qty;
                            
                        }
                        //Log.v("javed tab",c1.getString(c1.getColumnIndex("dr_id"))+"\n"+dr_sample_name+"\n"+dr_sample_qty+"\n"+dr_sample_pob);
                        
                    }
                    
                } // else close
                else if (table == "Dairy" || table == "Poultry") {
                    var pob : Float = 0.0
                    var dr_sample_id = "", dr_gift_id = "";
                    
                    if (try c[getColumnIndex(statement: statement, Coloumn_Name : "dr_remark")] as! String != ""){
                        
                        dr_remark = try c[getColumnIndex(statement: statement, Coloumn_Name : "dr_remark")] as! String
                    }
                    
                    dr_work_with = try c[getColumnIndex(statement: statement, Coloumn_Name : "person_name")] as! String
                    
                    dr_sample_id = try c[getColumnIndex(statement: statement, Coloumn_Name : "allitemid")]  as! String
                    
                    dr_sample_qty = try c[getColumnIndex(statement: statement, Coloumn_Name : "sample")] as! String
                    
                    dr_sample_pob = try c[getColumnIndex(statement: statement, Coloumn_Name : "allitemqty")] as! String
                    
                    dr_gift_id = try c[getColumnIndex(statement: statement, Coloumn_Name : "allgiftid")] as! String
                    
                    dr_gift_qty = try c[getColumnIndex(statement: statement, Coloumn_Name :"allgiftqty")] as! String
                    
                    pob_amt =  try c[getColumnIndex(statement: statement, Coloumn_Name :"pob_amt")]  as! String
                    
                    
                    //                     IS_INTRESTED =  try c[getColumnIndex(statement: statement, Coloumn_Name :"IS_INTRESTED")]  as! String
                    //
                    
                    
                    
                    var dr_sample_id_list = dr_sample_id.components(separatedBy: ",")
                    
                    for i in 0 ..< dr_sample_id_list.count  {
                        let statement2 = try connection!.prepare( "select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' and item_id='" + dr_sample_id_list[i] + "'")
                        
                        //                        "select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' and item_id='" + dr_sample_id_list[i] + "'")
                        var saparator=","
                        if (i==0){
                            saparator=""
                        }
                        
                        while let c2 =  statement2.next(){
                            
                            try  dr_sample_name = dr_sample_name + saparator + (  c2[getColumnIndex(statement : statement2 , Coloumn_Name: "item_name")]! as! String)
                        }
                    }
                    
                    var dr_gift_id_list = dr_gift_id.components(separatedBy:",");
                    
                    for i in  0 ..< dr_gift_id_list.count {
                        
                        let statement2 = try connection!.prepare( "select item_id, item_name,stk_rate from phitem where gift_type='GIFT' and item_id='" + dr_gift_id_list[i] + "'")
                        
                        var saparator=",";
                        if (i==0){
                            saparator="";
                        }
                        
                        while let c2 =  statement2.next(){
                            try  dr_sample_name = dr_gift_name + saparator + (  c2[getColumnIndex(statement : statement2 , Coloumn_Name: "item_name")]! as! String)
                        }
                    }
                }
                    
                    
                else if (table == "chemisttemp") {
                    
                    //Cursor c1 =  sd.rawQuery("select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' ", null);
                    let statement1 = try connection!.prepare("select allitemid,allitemqty,sample,allgiftid,allgiftqty,pob_amt,remark from phdcrchem where chem_id='" + dr_id + "'");
                    
                    
                    while let c1 = statement1.next() {
                        
                        dr_sample_id = try c1[getColumnIndex(statement :statement1  ,  Coloumn_Name : "allitemid")] as! String
                        dr_sample_qty = try c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"sample")] as! String
                        dr_sample_pob = try c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"allitemqty")] as! String
                        
                        dr_gift_id = try c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"allgiftid")] as! String
                        dr_gift_qty = try c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"allgiftqty")] as! String
                        pob_amt = try c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"pob_amt")] as! String
                        
                        if try (c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"remark")] as! String != ("")) {
                            dr_remark = try c1[getColumnIndex(statement : statement1  ,  Coloumn_Name :"remark")] as! String
                        }
                    }
                    
                    var dr_sample_id_list = dr_sample_id.components(separatedBy: ",")
                    
                    for i in  0 ..< dr_sample_id_list.count {
                        let statement2 = try connection!.prepare("select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' and item_id='" + dr_sample_id_list[i] + "'")
                        var saparator=",";
                        if (i==0){
                            saparator="";
                        }
                        
                        while let c2 = statement2.next() {
                            try  dr_sample_name = dr_sample_name + saparator + ( c2[getColumnIndex(statement : statement2 , Coloumn_Name:  "item_name")]! as! String )
                        }
                    }
                    
                    var dr_gift_id_list = dr_gift_id.components(separatedBy: ",")
                    for i in  0 ..< dr_gift_id_list.count {
                        let statement2 = try connection!.prepare("select item_id, item_name,stk_rate from phitem where gift_type='GIFT' and item_id='" + dr_gift_id_list[i] + "'")
                        
                        var saparator=",";
                        if (i==0){
                            saparator="";
                        }
                        while let c2 =  statement2.next(){
                            try dr_gift_name = dr_gift_name + saparator + (  c2[getColumnIndex(statement : statement2 , Coloumn_Name: "item_name")]! as! String)
                        }
                    }
                } else if (table == "phdcrchem_rc") {
                    
                    if try (c[getColumnIndex(statement : statement , Coloumn_Name :  "remark")] as! String != "") {
                        dr_remark = try c[getColumnIndex(statement : statement , Coloumn_Name :  "remark")] as! String
                    }
                    let  statement1  = try connection!.prepare("select chem_id,chem_name  from phchemist where chem_id='" + dr_id + "'");
                    print("statement1",statement1)
                    while let c1 = statement1.next() {
                        //do {
                        try dr_name = c1[getColumnIndex(statement : statement1 , Coloumn_Name : "chem_name")] as! String
                        //} while (c1.moveToNext());
                    }
                    
                }
                
                switch table {
                case "Expenses":
                    try remark.append(c[getColumnIndex(statement : statement , Coloumn_Name: "remark")]! as! String)
                    attachment = try (c[getColumnIndex(statement : statement , Coloumn_Name: "FILE_NAME")]! as! String )
                    break;
                    
                    
                case "nonListed_call":
                    try dr_name += " (" + (c[getColumnIndex(statement : statement , Coloumn_Name:  "sDocType")]! as! String ) + ")"
                    remark.append(dr_id)
                    
                    try dr_sample_name = (c[getColumnIndex(statement : statement , Coloumn_Name:   "iQfl")] as! String ) + " (" + (c[getColumnIndex(statement : statement , Coloumn_Name:  "iSpl")]! as! String) + ")"
                    //
                    //
                    dr_sample_qty = try c[getColumnIndex(statement : statement, Coloumn_Name: "sAdd1")]! as! String
                    dr_sample_pob = try c[getColumnIndex(statement : statement, Coloumn_Name: "sMobileNo")]! as! String
                    dr_area = try c[getColumnIndex(statement : statement, Coloumn_Name: "AREA")]! as! String
                    dr_class = try (c[getColumnIndex(statement : statement , Coloumn_Name : "CLASS")]!) as! String
                    dr_potential = try c[getColumnIndex(statement : statement , Coloumn_Name:  "POTENCY_AMT")]! as! String
                    attachment = try  c[getColumnIndex(statement : statement , Coloumn_Name: "iSplId")]! as! String
                    break;
                    
                case "appraisal":
                    dr_gift_name = try c[getColumnIndex(statement : statement , Coloumn_Name:  "sAPPRAISAL_NAME_STR")]! as! String
                    dr_gift_qty = try (c[getColumnIndex(statement : statement , Coloumn_Name:"sGRADE_STR")]! as! String  )
                    
                    try dr_remark = "Observation :- " + (c[getColumnIndex(statement : statement , Coloumn_Name:"sOBSERVATION")]! as! String) + "\nAction Taken - " + (c[getColumnIndex(statement : statement , Coloumn_Name:"sACTION_TAKEN")]! as! String)
                    remark.append(dr_remark);
                    break;
                    
                    
                    
                case "tenivia_traker":
                    dr_remark = try (c[getColumnIndex(statement : statement , Coloumn_Name: "REMARK")]! as! String)
                    remark.append(dr_remark);
                    if (dr_remark == "") {
                        try  dr_gift_name = (c[getColumnIndex(statement : statement , Coloumn_Name: "QTY_CAPTION")]! as! String ) + "," + (c[getColumnIndex(statement: statement,Coloumn_Name: "AMOUN_CAPTION")]! as! String)
                        
                        try dr_gift_qty = (c[getColumnIndex(statement : statement , Coloumn_Name: "QTY")]! as! String) + "," + (c[getColumnIndex(statement : statement , Coloumn_Name: "AMOUNT")]! as! String)
                    }
                    break;
                    
                    
                    
                    
                    
                    
                case "phdcrdr_rc","Poultry", "Dairy":
                    
                    remark.append(dr_remark);
                    
                    break;
                case "tempdr" ,"chemisttemp" ,"phdcrstk":
                    if (pob_amt == "0" || pob_amt ==  "0.0" || pob_amt == ".00" || Custom_Variables_And_Method.SAMPLE_POB_MANDATORY != "N"){
                        remark.append(dr_remark);
                    }else{
                        remark.append("POB amount Rs. " + pob_amt + "\n" + dr_remark)
                    }
                    break;
                    
                    
                default:
                    
                    remark.append("")
                    break
                    
                }
                
                
                idList.append(dr_id);
                nameList.append(dr_name);
                timeList.append(dr_time);
                
                sample_id.append(dr_sample_id)
                sample_name.append(dr_sample_name);
                sample_qty.append(dr_sample_qty);
                sample_pob.append(dr_sample_pob);
                sample_noc.append(dr_sample_noc);
                
                gift_id.append(dr_gift_id)
                gift_name.append(dr_gift_name);
                gift_qty.append(dr_gift_qty);
                show_edit_delete_list.append(show_edit_delete);
                visible_status.append(show_edit_delete);
                
                dr_area_list.append(dr_area);
                dr_class_list.append(dr_class);
                dr_potential_list.append(dr_potential);
                dr_work_with_list.append(dr_work_with);
                attachment_list.append(attachment);
                
                
            } // while
            
            
            if (nameList.count == 0 && table != "Expenses") {
                idList.append("-99");
                nameList.append("Yet to make your first Call");
                timeList.append("");
                
                sample_id.append("")
                sample_name.append("");
                sample_qty.append("");
                sample_pob.append("");
                sample_noc.append("");
                
                gift_id.append("")
                gift_name.append("")
                gift_qty.append("")
                visible_status.append("0");
                remark.append("");
                show_edit_delete_list.append("")
                
                dr_area_list.append("");
                dr_class_list.append("");
                dr_potential_list.append("");
                dr_work_with_list.append("");
                attachment_list.append("");
                
            }
            
            
            
            Tabs["id"] = idList
            Tabs["name"] = nameList
            Tabs["time"] = timeList
            
            Tabs["sample_id"] =  sample_id
            Tabs["sample_name"] =  sample_name
            Tabs["sample_qty"] =  sample_qty
            
            Tabs["gift_id"] = gift_id
            Tabs["gift_name"] = gift_name
            Tabs["gift_qty"] = gift_qty
            
            Tabs["sample_pob"] = sample_pob
            Tabs["sample_noc"] = sample_noc
            Tabs["visible_status"] = visible_status
            Tabs["remark"] = remark
            Tabs["show_edit_delete"] = show_edit_delete_list
            
            Tabs["class"] =  dr_class_list
            Tabs["potential"] = dr_potential_list
            Tabs["area"] = dr_area_list
            Tabs["workwith" ] = dr_work_with_list
            Tabs["attach" ] = attachment_list
            //            Tabs["is_intrested"] = IS_INTRESTED
            
        }// do block
        catch {
            print(error)
        }
        
        
        return Tabs
        
    }
    
    //
    //    public HashMap<String, List<String>> getCallDetail(String table,String look_for_id,String show_edit_delete) {
    //    sd = this.getWritableDatabase();
    //    HashMap<String, List<String>> Tabs = new HashMap<>();
    //    String query="";
    //    String name="";
    //    String time="";
    //    String id="";
    //    String where_cluse="";
    //    ArrayList<String> idList,nameList,timeList,sample_name,sample_qty,sample_pob,sample_noc,remark,gift_name,gift_qty,show_edit_delete_list
    //    ,dr_class_list,dr_potential_list,dr_area_list,dr_work_with_list,attachment_list;
    //    List<String> visible_status=new ArrayList<>();
    //    idList=new ArrayList<String>();
    //    nameList=new ArrayList<String>();
    //    timeList=new ArrayList<String>();
    //    sample_name=new ArrayList<String>();
    //    sample_qty=new ArrayList<String>();
    //
    //    gift_name=new ArrayList<String>();
    //    gift_qty=new ArrayList<String>();
    //
    //    sample_pob=new ArrayList<String>();
    //    sample_noc=new ArrayList<String>();
    //    remark=new ArrayList<String>();
    //    show_edit_delete_list=new ArrayList<String>();
    //
    //    dr_class_list=new ArrayList<String>();
    //    dr_potential_list=new ArrayList<String>();
    //    dr_area_list=new ArrayList<String>();
    //    dr_work_with_list=new ArrayList<String>();
    //    attachment_list=new ArrayList<String>();
    //
    //
    //    if (table.equals("chemisttemp")) {
    //    id = "chem_id";
    //    name = "chem_name";
    //    time = "visit_time";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select  chem_id,chem_name,visit_time from " + table + " " + where_cluse + " order by srno";
    //    } else if (table.equals("tempdr")) {
    //    id = "dr_id";
    //    name = "dr_name";
    //    time = "visit_time";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select  dr_id,dr_name,visit_time,dr_remark,work_with_name,DR_AREA,call_type from " + table + " " + where_cluse + " order by srno";
    //    } else if (table.equals("phdcrstk")) {
    //    id = "stk_id";
    //    name = "stk_id";
    //    time = "time";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select  stk_id,time,remark from " + table + " " + where_cluse + " order by srno";
    //    } else if (table.equals("phdcrdr_rc")) {
    //    id = "dr_id";
    //    name = "dr_id";
    //    time = "time";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select  dr_id,time,remark from " + table + " " + where_cluse + " order by srno";
    //    } else if (table.equals("Expenses")) {
    //    id = "exp_head_id";
    //    name = "exp_head";
    //    time = "amount";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select * from " + Expenses ;
    //    }else if (table.equals("nonListed_call")) {
    //    id = "sRemark";
    //    name = "sDrName";
    //    time = "time";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select * from " + NonListed_call ;
    //    }else if (table.equals("appraisal")) {
    //    id = "PA_ID";
    //    name = "PA_NAME";
    //    time = "sGRADE_NAME_STR";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select * from " + Appraisal +" where FLAG=1";
    //    }else if (table.equals("tenivia_traker")) {
    //    id = "DR_ID";
    //    name = "DR_NAME";
    //    time = "TIME";
    //    if (!look_for_id.equals("")) {
    //    where_cluse = " where " + id + "='" + look_for_id + "'";
    //    }
    //    query = "Select * from " + Tenivia_traker +" " +where_cluse;
    //    }
    //
    //    Cursor c = sd.rawQuery(query, null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    String dr_sample_name = "";
    //    String dr_sample_qty = "";
    //    String dr_gift_name = "";
    //    String dr_gift_qty = "";
    //    String dr_sample_pob = "";
    //    String dr_sample_noc="";
    //    String pob_amt="0";
    //    String dr_remark="";
    //
    //    String dr_class = "";
    //    String dr_potential = "";
    //    String dr_area = "";
    //    String dr_work_with="";
    //    String attachment="";
    //
    //    String dr_id = c.getString(c.getColumnIndex(id));
    //    String dr_name = c.getString(c.getColumnIndex(name));
    //    String dr_time = c.getString(c.getColumnIndex(time));
    //    if (table.equals("phdcrstk")) {
    //    String dr_sample_id = "";
    //    if (!c.getString(c.getColumnIndex("remark")).equals("")) {
    //    dr_remark = c.getString(c.getColumnIndex("remark"));
    //    }
    //    Cursor c1 = sd.rawQuery("select pa_name, pa_id from phparty where category='STOCKIST' and pa_id='" + dr_id + "'", null);
    //
    //    try {
    //    if (c1.moveToFirst()) {
    //    do {
    //    dr_name = c1.getString(c1.getColumnIndex("pa_name"));
    //    } while (c1.moveToNext());
    //    }
    //    } finally {
    //    c1.close();
    //    }
    //
    //
    //    Cursor c2 = sd.rawQuery("select allitemid,allitemqty,sample,pob_amt  from phdcrstk where stk_id='" + dr_id + "'", null);
    //
    //    try {
    //    if (c2.moveToFirst()) {
    //    do {
    //    dr_sample_id = c2.getString(c2.getColumnIndex("allitemid"));
    //    dr_sample_qty = c2.getString(c2.getColumnIndex("sample"));
    //    dr_sample_pob = c2.getString(c2.getColumnIndex("allitemqty"));
    //    pob_amt=c2.getString(c2.getColumnIndex("pob_amt"));
    //    } while (c2.moveToNext());
    //    }
    //    } finally {
    //    c2.close();
    //    }
    //
    //    String dr_sample_id_list[] = dr_sample_id.split(",");
    //    for (int i = 0; i < dr_sample_id_list.length; i++) {
    //    Cursor c3 = sd.rawQuery("select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' and item_id='" + dr_sample_id_list[i] + "'", null);
    //
    //    String saparator=",";
    //    if (i==0){
    //    saparator="";
    //    }
    //
    //    try {
    //    if (c3.moveToFirst()) {
    //    do {
    //    dr_sample_name =  dr_sample_name+ saparator +c3.getString(c3.getColumnIndex("item_name"));
    //    } while (c3.moveToNext());
    //    }
    //    } finally {
    //    c3.close();
    //    }
    //    }
    //
    //
    //    } else if (table.equals("phdcrdr_rc")) {
    //
    //    if (!c.getString(c.getColumnIndex("remark")).equals("")) {
    //    dr_remark = c.getString(c.getColumnIndex("remark"));
    //    }
    //
    //    Cursor c1 = sd.rawQuery("select dr_id,dr_name,CLASS,POTENCY_AMT,DR_AREA,PANE_TYPE  from phdoctor where dr_id='" + dr_id + "'", null);
    //
    //    try {
    //    if (c1.moveToFirst()) {
    //    do {
    //    dr_name = c1.getString(c1.getColumnIndex("dr_name"));
    //    dr_area=c1.getString(c1.getColumnIndex("DR_AREA"));
    //    dr_class=c1.getString(c1.getColumnIndex("CLASS"));
    //    dr_potential=c1.getString(c1.getColumnIndex("POTENCY_AMT"));
    //    } while (c1.moveToNext());
    //    }
    //    } finally {
    //    c1.close();
    //    }
    //    } else if (table.equals("tempdr")) {
    //    Float pob=0f;
    //    if (!c.getString(c.getColumnIndex("dr_remark")).equals("")) {
    //    dr_remark = c.getString(c.getColumnIndex("dr_remark"));
    //    }
    //    dr_work_with=c.getString(c.getColumnIndex("work_with_name"));
    //    dr_area=c.getString(c.getColumnIndex("DR_AREA"));
    //    if(c.getString(c.getColumnIndex("call_type")).equals("2")){
    //    dr_name+="(U)";
    //    }else if(c.getString(c.getColumnIndex("call_type")).equals("1")){
    //    dr_name+="(M)";
    //    }else{
    //    dr_name+="(P)";
    //    }
    //
    //    Cursor c1 = sd.rawQuery("select CLASS,POTENCY_AMT,PANE_TYPE  from phdoctor where dr_id='" + dr_id + "'", null);
    //
    //    try {
    //    if (c1.moveToFirst()) {
    //    do {
    //    dr_class=c1.getString(c1.getColumnIndex("CLASS"));
    //    dr_potential=c1.getString(c1.getColumnIndex("POTENCY_AMT"));
    //    } while (c1.moveToNext());
    //    }
    //    } finally {
    //    c1.close();
    //    }
    //
    //    c1 = sd.rawQuery("select dr_id,item_name,pob,qty,stk_rate,noc from " + DOCTOR_ITEM_TABLE + " where dr_id='" + dr_id + "'", null);
    //    try {
    //    if (c1.moveToFirst()) {
    //    do {
    //    if (!c1.getString(c1.getColumnIndex("stk_rate")).equals("x")) {
    //    dr_sample_name = c1.getString(c1.getColumnIndex("item_name")) + "," + dr_sample_name;
    //    dr_sample_qty = c1.getString(c1.getColumnIndex("qty")) + "," + dr_sample_qty;
    //    dr_sample_pob = c1.getString(c1.getColumnIndex("pob")) + "," + dr_sample_pob;
    //    dr_sample_noc = c1.getString(c1.getColumnIndex("noc")) + "," + dr_sample_noc;
    //    pob+=Float.parseFloat(c1.getString(c1.getColumnIndex("pob")))*Float.parseFloat(c1.getString(c1.getColumnIndex("stk_rate")));
    //    }
    //    //Log.v("javed tab",c1.getString(c1.getColumnIndex("dr_id"))+"\n"+dr_sample_name+"\n"+dr_sample_qty+"\n"+dr_sample_pob);
    //    } while (c1.moveToNext());
    //    }
    //    } finally {
    //    pob_amt=""+pob;
    //    c1.close();
    //    }
    //
    //    c1 = sd.rawQuery("select dr_id,item_name,pob,qty,stk_rate  from " + DOCTOR_ITEM_TABLE + " where dr_id='" + dr_id + "'", null);
    //    try {
    //    if (c1.moveToFirst()) {
    //    do {
    //    if (c1.getString(c1.getColumnIndex("stk_rate")).equals("x")) {
    //    dr_gift_name = c1.getString(c1.getColumnIndex("item_name")) + "," + dr_gift_name;
    //    dr_gift_qty = c1.getString(c1.getColumnIndex("qty")) + "," + dr_gift_qty;
    //
    //    }
    //    //Log.v("javed tab",c1.getString(c1.getColumnIndex("dr_id"))+"\n"+dr_sample_name+"\n"+dr_sample_qty+"\n"+dr_sample_pob);
    //    } while (c1.moveToNext());
    //    }
    //    } finally {
    //    c1.close();
    //    }
    //
    //    } else if (table.equals("chemisttemp")) {
    //    String dr_sample_id = "", dr_gift_id = "";
    //    //Cursor c1 =  sd.rawQuery("select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' ", null);
    //    Cursor c1 = sd.rawQuery("select allitemid,allitemqty,sample,allgiftid,allgiftqty,pob_amt,remark from phdcrchem where chem_id='" + dr_id + "'", null);
    //
    //    try {
    //    if (c1.moveToFirst()) {
    //    do {
    //    dr_sample_id = c1.getString(c1.getColumnIndex("allitemid"));
    //    dr_sample_qty = c1.getString(c1.getColumnIndex("sample"));
    //    dr_sample_pob = c1.getString(c1.getColumnIndex("allitemqty"));
    //
    //    dr_gift_id = c1.getString(c1.getColumnIndex("allgiftid"));
    //    dr_gift_qty = c1.getString(c1.getColumnIndex("allgiftqty"));
    //    pob_amt=c1.getString(c1.getColumnIndex("pob_amt"));
    //    if (!c1.getString(c1.getColumnIndex("remark")).equals("")) {
    //    dr_remark = c1.getString(c1.getColumnIndex("remark"));
    //    }
    //
    //    } while (c1.moveToNext());
    //    }
    //    } finally {
    //    c1.close();
    //    }
    //
    //    String dr_sample_id_list[] = dr_sample_id.split(",");
    //    for (int i = 0; i < dr_sample_id_list.length; i++) {
    //    Cursor c2 = sd.rawQuery("select item_id, item_name,stk_rate from phitem where gift_type='ORIGINAL' and item_id='" + dr_sample_id_list[i] + "'", null);
    //    String saparator=",";
    //    if (i==0){
    //    saparator="";
    //    }
    //
    //    try {
    //    if (c2.moveToFirst()) {
    //    do {
    //    dr_sample_name =  dr_sample_name+ saparator + c2.getString(c2.getColumnIndex("item_name"));
    //    } while (c2.moveToNext());
    //    }
    //    } finally {
    //    c2.close();
    //    }
    //    }
    //
    //    String dr_gift_id_list[] = dr_gift_id.split(",");
    //    for (int i = 0; i < dr_gift_id_list.length; i++) {
    //    Cursor c2 = sd.rawQuery("select item_id, item_name,stk_rate from phitem where gift_type='GIFT' and item_id='" + dr_gift_id_list[i] + "'", null);
    //
    //    String saparator=",";
    //    if (i==0){
    //    saparator="";
    //    }
    //
    //    try {
    //    if (c2.moveToFirst()) {
    //    do {
    //    dr_gift_name = dr_gift_name + saparator + c2.getString(c2.getColumnIndex("item_name"));
    //    } while (c2.moveToNext());
    //    }
    //    } finally {
    //    c2.close();
    //    }
    //    }
    //
    //    }
    //
    //    switch (table) {
    //    case "Expenses":
    //    remark.add(c.getString(c.getColumnIndex("remark")));
    //    attachment=c.getString(c.getColumnIndex("FILE_NAME"));
    //    break;
    //    case "nonListed_call":
    //    dr_name +=" ("+c.getString(c.getColumnIndex("sDocType"))+")";
    //    remark.add(dr_id);
    //
    //    dr_sample_name=c.getString(c.getColumnIndex("iQfl"))+" ("+c.getString(c.getColumnIndex("iSpl"))+")";
    //    dr_sample_qty=c.getString(c.getColumnIndex("sAdd1"));
    //    dr_sample_pob=c.getString(c.getColumnIndex("sMobileNo"));
    //    dr_area=c.getString(c.getColumnIndex("AREA"));
    //    dr_class=c.getString(c.getColumnIndex("CLASS"));
    //    dr_potential=c.getString(c.getColumnIndex("POTENCY_AMT"));
    //    attachment=c.getString(c.getColumnIndex("iSplId"));
    //
    //    break;
    //    case "appraisal":
    //    dr_gift_name =c.getString(c.getColumnIndex("sAPPRAISAL_NAME_STR"));
    //    dr_gift_qty=c.getString(c.getColumnIndex("sGRADE_STR"));
    //    dr_remark="Observation :- "+c.getString(c.getColumnIndex("sOBSERVATION"))+"\nAction Taken - "+c.getString(c.getColumnIndex("sACTION_TAKEN"));
    //    remark.add(dr_remark);
    //    break;
    //    case "tenivia_traker":
    //    dr_remark=c.getString(c.getColumnIndex("REMARK"));
    //    remark.add(dr_remark);
    //    if (dr_remark.equals("")) {
    //    dr_gift_name = c.getString(c.getColumnIndex("QTY_CAPTION")) + "," + c.getString(c.getColumnIndex("AMOUN_CAPTION"));
    //    dr_gift_qty = c.getString(c.getColumnIndex("QTY")) + "," + c.getString(c.getColumnIndex("AMOUNT"));
    //    }
    //    break;
    //    case "phdcrdr_rc":
    //    case "tempdr":
    //    case "chemisttemp":
    //    case "phdcrstk":
    //    if (pob_amt.equals("0") || pob_amt.equals("0.0") || pob_amt.equals(".00") || !Custom_Variables_And_Method.SAMPLE_POB_MANDATORY.equals("N")){
    //    remark.add(dr_remark);
    //    }else{
    //    remark.add("POB amount  \u20B9 "+pob_amt+"\n"+dr_remark);
    //    }
    //    break;
    //
    //    default:
    //    remark.add("");
    //    break;
    //    }
    //    idList.add(dr_id);
    //    nameList.add(dr_name);
    //    timeList.add(dr_time);
    //    sample_name.add(dr_sample_name);
    //    sample_qty.add(dr_sample_qty);
    //    sample_pob.add(dr_sample_pob);
    //    sample_noc.add(dr_sample_noc);
    //
    //    gift_name.add(dr_gift_name);
    //    gift_qty.add(dr_gift_qty);
    //    show_edit_delete_list.add(show_edit_delete);
    //    visible_status.add(show_edit_delete);
    //
    //    dr_area_list.add(dr_area);
    //    dr_class_list.add(dr_class);
    //    dr_potential_list.add(dr_potential);
    //    dr_work_with_list.add(dr_work_with);
    //    attachment_list.add(attachment);
    //
    //    } while (c.moveToNext());
    //    }
    //    } finally {
    //    c.close();
    //    }
    //
    //    if (nameList.size() == 0 && !table.equals("Expenses")) {
    //    idList.add("0");
    //    nameList.add("Yet to make your first Call");
    //    timeList.add("");
    //    sample_name.add("");
    //    sample_qty.add("");
    //    sample_pob.add("");
    //    visible_status.add("0");
    //    remark.add("");
    //
    //    dr_area_list.add("");
    //    dr_class_list.add("");
    //    dr_potential_list.add("");
    //    dr_work_with_list.add("");
    //    attachment_list.add("");
    //
    //    }
    //    Tabs.put("id", idList);
    //    Tabs.put("name", nameList);
    //    Tabs.put("time", timeList);
    //    Tabs.put("sample_name", sample_name);
    //    Tabs.put("sample_qty", sample_qty);
    //
    //    Tabs.put("gift_name", gift_name);
    //    Tabs.put("gift_qty", gift_qty);
    //
    //    Tabs.put("sample_pob", sample_pob);
    //    Tabs.put("sample_noc", sample_noc);
    //    Tabs.put("visible_status", visible_status);
    //    Tabs.put("remark", remark);
    //    Tabs.put("show_edit_delete", show_edit_delete_list);
    //
    //    Tabs.put("class", dr_class_list);
    //    Tabs.put("potential", dr_potential_list);
    //    Tabs.put("area", dr_area_list);
    //    Tabs.put("workwith", dr_work_with_list);
    //    Tabs.put("attach", attachment_list);
    //    return Tabs;
    //
    //    }
    //
    public func  getNotification_count() -> Int{
        let  countQuery = "SELECT  read_status FROM " + CBO_DB_Helper.Notification + " Where read_status=0";
        var cnt = 0
        do {
            let statement = try connection!.prepare(countQuery)
            while statement.next() != nil{
                cnt += 1   }
        }catch{
            print(error)
        }
        return cnt
    }
    //    ////////////////////////////////
    //
    public func deleteMenu() {
        DeleteQry(Table_name: CBO_DB_Helper.MenuControl, WhereClause: "")
    }
    
    public func insert_Notification( Title : String,  msg : String,  logo : String, content :  String,  status : String,  date : String,  time : String) {
        
        var cv = [String : String]()
        cv["Title"] = Title
        cv["msg"] = msg
        cv["logo_url"] = logo
        cv["content_url"] = content
        cv["read_status"] = status
        cv["date"] = date
        cv["time"] = time
        
        insertQry(Table_name : CBO_DB_Helper.Notification , values: cv)
    }
    
    
    public func getNotificationMsg() -> [String : [String]] {
        
        var cv = [String : [String]]()
        var url = "";
        var data = [String : [String]]()
        var Title,des,time,date,status,logo_url,info_url,id : [String]!
        Title = [String]();
        des = [String]()
        time = [String]()
        date = [String]()
        status = [String]()
        logo_url = [String]()
        info_url = [String]()
        id = [String]()
        
        let query = "Select * from " + CBO_DB_Helper.Notification + " order by id desc";
        do {
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                Title.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "Title")]! as! String))
                des.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "msg")]! as! String))
                time.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "time")]! as! String))
                date.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "date")]! as! String))
                status.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "read_status")]! as! String))
                logo_url.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "logo_url")]! as! String))
                info_url.append(try (c[getColumnIndex(statement: statement, Coloumn_Name: "content_url")]! as! String))
                id.append("\(c[try getColumnIndex(statement: statement, Coloumn_Name: "id")]!)")
            }
        } catch{
            print(error)
        }
        data["Title"] = Title
        data["Des"] = des
        data["Time"] = time
        data["Date"] = date
        data["Status"] = status
        data["Logo_url"] = logo_url
        data["Info_url"] = info_url
        data["ID"] = id
        return data;
    }
    public func notificationDeletebyID( id : String) {
        
        if (!id.isEmpty) {
            DeleteQry(Table_name: CBO_DB_Helper.Notification, WhereClause:  "ID =" + id)
        }else{
            DeleteQry(Table_name: CBO_DB_Helper.Notification, WhereClause: "")
        }
    }
    
    public func updateNotificationStatus( id :String ,status : String) {
        var cv = [String : String]()
        cv["read_status"] = status
        updateQry(Table_name: CBO_DB_Helper.Notification, values: cv, WhereClause: "ID =" + id)
    }
    
    
   
    
    //    public func delete_weakOld_Notification( calendar1 : Calendar) {
    //    sd = this.getWritableDatabase();
    //
    //    Calendar calendar2 = Calendar.getInstance();
    //
    //    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy", Locale.getDefault());
    //
    //    //String query = "select id,cast(date as Date) as dat  from " + Notification +" WHERE dat>='"+date+"'";
    //    String query = "select id,date from " + Notification ;
    //    //  String query = "Select * from " + MenuControl;
    //    Cursor c = sd.rawQuery(query, null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    Date date2 = dateFormat.parse(c.getString(c.getColumnIndex("date")));
    //    calendar2.setTime(date2);
    //    if(calendar2.compareTo(calendar1)<1) {
    //    notificationDeletebyID(c.getString(c.getColumnIndex("id")));
    //    //id.add(c.getString(c.getColumnIndex("id")));
    //    Log.v("javed", "Notification deleted successfully " + calendar2.compareTo(calendar1));
    //    }
    //    } while (c.moveToNext());
    //    }
    //    } catch (ParseException e) {
    //    e.printStackTrace();
    //    } finally {
    //    c.close();
    //    }
    //    }
    
    //    public func insert_Approval_count(String approval_menu_code, String approval_count) {
    //    sd = this.getWritableDatabase();
    //    ContentValues cv = new ContentValues();
    //    cv["approval_menu_code", approval_menu_code);
    //    cv["approval_count", approval_count);
    //    sd.insert(Approval_count, null, cv);
    //    /* Log.v("javed","Approval_count inserted successfully");*/
    //
    //    }
    //    public func delete_Approval_count() {
    //    sd = this.getWritableDatabase();
    //    sd.delete(Approval_count, null, null);
    //
    //    }
    //
    //    public String get_Approval_count(String approval_menu_code) {
    //    sd = this.getWritableDatabase();
    //    String  approval_count="0";
    //    String query = "Select * from " + Approval_count +" where approval_menu_code='"+approval_menu_code+"'";
    //    //  String query = "Select * from " + MenuControl;
    //    Cursor c = sd.rawQuery(query, null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    approval_count=c.getString(c.getColumnIndex("approval_count"));
    //
    //    } while (c.moveToNext());
    //    }
    //    }finally {
    //    c.close();
    //    }
    //    return approval_count;
    //    }
    //
    
    public func Save(date : String, owner_name:String, owner_no:String, farmer_attendence:String, group_meeting_place:String, product_detail:String, IH_staff_attendence:String, farmer_sale:String, order_book:String, mRemark:String) {
        
        var cv = [String : Any]()
        cv["date"] = date
        cv["mcc_owner_name"] = owner_name
        cv["Mcc_owner_no"] = owner_no
        cv["farmer_attendence"] = farmer_attendence
        cv["group_meeting_place"] = group_meeting_place
        cv["product_detail"] = product_detail
        cv["IH_staff_attendence"] = IH_staff_attendence
        cv["sale_to_farmer"] = farmer_sale
        cv["order_book_for_mcc"] = order_book
        cv["remark"] = mRemark
        insertQry(Table_name: CBO_DB_Helper.PH_Farmer, values: cv)
        
        
    }
    
    public func insert_Expense( exp_head_id : String, exp_head : String,amount : String, remark : String, FILE_NAME : String, ID : String, time : String) {
        
        DeleteQry(Table_name: CBO_DB_Helper.Expenses, WhereClause: "exp_head_id='"+exp_head_id+"'")
        var cv = [String : Any]()
        cv["exp_head_id"] = exp_head_id
        cv["exp_head"] =  exp_head
        cv["amount"] =  amount
        cv["remark"] =  remark
        cv["FILE_NAME"] = FILE_NAME
        cv["exp_ID"] =  ID
        cv["time"] =  time
        cv["km"] =  "0"
        cv["editable"] =  1
        insertQry(Table_name: CBO_DB_Helper.Expenses, values: cv)
        
    }
    
    public func insert_Expense(othExpense: mOthExpense ){
        
         //getDatabase().delete(getTable(), "exp_head_id='" + othExpense.getExpHead().getId() + "'", null);
        DeleteQry(Table_name: CBO_DB_Helper.Expenses, WhereClause: "exp_head_id='\( othExpense.getExpHead().getId() )'")
        var cv = [String : Any]()
        cv["exp_head_id"] = othExpense.getExpHead().getId()
        cv["exp_head"] =  othExpense.getExpHead().getName()
        cv["amount"] =  othExpense.getAmount()
        cv["remark"] =  othExpense.getRemark()
        cv["FILE_NAME"] = othExpense.getAttachment()
        cv["exp_ID"] =  othExpense.getId()
        cv["time"] =  othExpense.getTime()
        cv["km"] =  othExpense.getKm()
        cv["editable"] =  othExpense.IsEditable() ? 1 : 0
        insertQry(Table_name: CBO_DB_Helper.Expenses, values: cv)

    }
    
    
    public func delete_Expense_withID( exp_ID : String) {
        DeleteQry(Table_name: CBO_DB_Helper.Expenses, WhereClause: "exp_ID='"+exp_ID+"'")
    }
    
    public func delete_Expense() {
        DeleteQry(Table_name: CBO_DB_Helper.Expenses, WhereClause: "")
    }
    
    //
    func get_Expense() -> [[String : String]]{
        var data = [[String : String]]();
        
        let query = "Select * from " + CBO_DB_Helper.Expenses ;
        
        do {
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                var datanum = [String : String]();
                try datanum["exp_head_id"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "exp_head_id")]! as! String)
                try datanum["exp_head"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "exp_head")]! as! String)
                let amt = (c[try getColumnIndex(statement: statement, Coloumn_Name: "amount")]! as! String).isEmpty ? "0": c[try getColumnIndex(statement: statement, Coloumn_Name: "amount")]! as! String
                datanum["amount"] =  amt
                try datanum["remark"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "remark")]! as! String)
                try datanum["FILE_NAME"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "FILE_NAME")]! as! String)
                try datanum["ID"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "exp_ID")]! as! String)
                data.append(datanum);
            }
        } catch{
            print(error)
        }
        
        return data;
    }
    
  
    public func get_Expense(For_DA_TA: eExpanse) -> [mOthExpense] {
          
        
        var data : [mOthExpense] = [mOthExpense]()
        
        let query = "Select * from " + CBO_DB_Helper.Expenses ;

        do {
                let statement = try connection!.prepare(query)
                while let c = statement.next(){
                    
                    let othExpense = mOthExpense()
                    othExpense.setId(id: Int(c[try getColumnIndex(statement: statement, Coloumn_Name: "exp_ID")]! as! String)!)
                        .setAttachment(attachment: c[try getColumnIndex(statement: statement, Coloumn_Name: "FILE_NAME")]! as! String)
                        .setRemark(remark: c[try getColumnIndex(statement: statement, Coloumn_Name: "remark")]! as! String)
                        .setAmount(amount: Double(c[try getColumnIndex(statement: statement, Coloumn_Name: "amount")]! as! String)!)
                        .setKm(km: Double(c[try getColumnIndex(statement: statement, Coloumn_Name: "km")]! as! String)!)
                        .setEditable(edit: c[try getColumnIndex(statement: statement, Coloumn_Name: "editable")]! as! Int64 == 1)
                    
                    
                    let expHead: mExpHead = getEXP_Head(Id: c[try getColumnIndex(statement: statement, Coloumn_Name: "exp_head_id")]! as! String)
                    if (expHead != nil && (For_DA_TA == expHead.getSHOW_IN_TA_DA())) || (expHead != nil && eExpanse.SERVER == expHead.getSHOW_IN_TA_DA() && For_DA_TA == eExpanse.None) {
                        
                        othExpense.setExpHead(expHead: expHead)
                        data.append(othExpense)
                    }
                    
                    
                }

            } catch{
                print(error)
            }

            
            return data;
    }

    //Visual ads download list
    
    public func SaveVisualAdd(itemId : String,itemName : String,fileName : String,downLoadVersion : String,brandId : String,submitYN : String){
        
        var cv = [String : Any]()
        cv["itemId"] = itemId
        cv["itemName"] =  itemName
        cv["fileName"] =  fileName
        cv["downLoadVersion"] =  downLoadVersion
        cv["brandId"] =  brandId
        cv["submitYN"] =  submitYN
        cv["downloadDateTime"] = ""
        insertQry(Table_name: CBO_DB_Helper.VISUAL_ADD_DOWNLOAD, values: cv)
        
    }
    
    public func getListVisualByBrand()  throws -> Statement {
           //Cursor c=sd.rawQuery("select phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id="+MyConnection.DOCTOR_SPL_ID+" order by phitem.item_name", null);
           do{
               return  try connection!.prepare("select VADownload.brandId,VADownload.itemName,VADownload.downLoadVersion,VADownload.downloadDateTime from VADownload");
           }catch{
               print(error)
               throw error
           }
    }
    
    public func getListVisualBySubmitYN()  throws -> Statement {
           //Cursor c=sd.rawQuery("select phitem.item_name,phitem.item_id from phitemspl inner join phitem phitem on phitem.item_id=phitemspl.item_id where phitemspl.dr_spl_id="+MyConnection.DOCTOR_SPL_ID+" order by phitem.item_name", null);
           do{
               return  try connection!.prepare("select VADownload.brandId,VADownload.itemName,VADownload.downLoadVersion from VADownload where submitYN=0");
           }catch{
               print(error)
               throw error
           }
    }
    
    
    public func deleteListVisualData() {
        DeleteQry(Table_name: CBO_DB_Helper.VISUAL_ADD_DOWNLOAD, WhereClause: "")
    }
    
    public func updateListVisualData1( itemName : String, downLoadVersion : String) {
        var cv = [String : Any]()
        cv["downLoadVersion"] = downLoadVersion
        updateQry(Table_name: CBO_DB_Helper.VISUAL_ADD_DOWNLOAD, values: cv, WhereClause:"itemName='" + itemName )
    }
    
    public func updateListVisualData( submitYN :String ,brandId : String, dateTime : String) {
        var cv = [String : String]()
        cv["submitYN"] = submitYN
        if dateTime != "" {
            cv["downloadDateTime"] = dateTime
        }
        
        updateQry(Table_name: CBO_DB_Helper.VISUAL_ADD_DOWNLOAD, values: cv, WhereClause: "brandId ='" + brandId + "'")
    }
    
    
   /* public func ArrayList[mExpHead] getExpense() {
        return get(type: eExpense.None);
    }
    
    public func ArrayList[mExpHead] getExpense(eExpense type) {
            ArrayList<mExpHead> expHeads = new ArrayList<mExpHead>();
    
            String query = "Select * from " + getTable() + " where (EXP_TYPE='"+type.name()+"' )";
            if (type == eExpense.None){
                query =  "Select * from " + getTable();
            }
            Cursor c = getDatabase().rawQuery(query, null);
            try {
                if (c.moveToFirst()) {
                    do {
                        mExpHead expHead=new mExpHead(c.getInt(c.getColumnIndex("FIELD_ID")),
                                c.getString(c.getColumnIndex("FIELD_NAME")))
                                .setEXP_TYPE(eExpense.valueOf(c.getString(c.getColumnIndex("EXP_TYPE"))))
                                .setSHOW_IN_TA_DA(eExpense.valueOf(c.getString(c.getColumnIndex("SHOW_IN_TA_DA"))))
                                .setATTACHYN(c.getInt(c.getColumnIndex("ATTACHYN")))
                                .setDA_ACTION(c.getInt(c.getColumnIndex("DA_ACTION")))
                                .setMANDATORY(c.getInt(c.getColumnIndex("MANDATORY")))
                                .setMAX_AMT(c.getDouble(c.getColumnIndex("MAX_AMT")))
                                .setMasterValidate(c.getInt(c.getColumnIndex("TAMST_VALIDATEYN")));
    
    
    
                        expHeads.add(expHead);
                    } while (c.moveToNext());
                }
            }finally {
                c.close();
            }
    }*/
 
    
    //
    //    public func insert_DOB_DOA(String PA_NAME, String DOB,String DOA, String MOBILE,String TYPE) {
    //    sd = this.getWritableDatabase();
    //    ContentValues cv = new ContentValues();
    //    cv["PA_NAME", PA_NAME);
    //    cv["DOB", DOB);
    //    cv["DOA", DOA);
    //    cv["MOBILE", MOBILE);
    //    cv["TYPE", TYPE);
    //    sd.insert(dob_doa, null, cv);
    //
    //    }
    //
    //    public func delete_DOB_DOA() {
    //    sd = this.getWritableDatabase();
    //    sd.delete(dob_doa, null, null);
    //
    //    }
    //
    //    public  ArrayList<Map<String, String>> get_DOB_DOA(String type) {
    //    ArrayList<Map<String, String>> data = new ArrayList<Map<String, String>>();
    //    sd = this.getWritableDatabase();
    //    String title="PA_NAME";
    //    if (type.equals("D")){
    //    title="DR_NAME";
    //    }
    //    String query = "Select * from " + dob_doa +" where TYPE='"+type+"'";
    //    Cursor c = sd.rawQuery(query, null);
    //    try {
    //    if (c.moveToFirst()) {
    //    do {
    //    Map<String, String> datanum = new HashMap<String, String>();
    //    datanum.put(title,c.getString(c.getColumnIndex("PA_NAME")));
    //    datanum.put("DOB", c.getString(c.getColumnIndex("DOB")));
    //    datanum.put("DOA", c.getString(c.getColumnIndex("DOA")));
    //    datanum.put("MOBILE",c.getString(c.getColumnIndex("MOBILE")));
    //    data.add(datanum);
    //
    //    } while (c.moveToNext());
    //    }
    //    }finally {
    //    c.close();
    //    }
    //    return data;
    //    }
    //
    
    public func insert_NonListed_Call( sDocType : String, sDrName : String ,sAdd1 : String ,sMobileNo
        : String ,sRemark : String ,iSplId : String ,iSpl : String , iQflId : String , iQfl
        : String , iSrno : String , loc : String ,time : String , CLASS : String , POTENCY_AMT : String , AREA : String ) {
        
        var cv = [String : String]()
        cv["sDocType"] = sDocType
        cv["sDrName"] = sDrName
        cv["sAdd1"] = sAdd1
        cv["sMobileNo"] = sMobileNo
        cv["sRemark"] = sRemark
        cv["iSplId"] =  iSplId
        cv["iSpl"] = iSpl
        cv["iQflId"] = iQflId
        cv["iQfl"] = iQfl
        cv["iSrno"] = iSrno
        cv["loc"] = loc
        cv["time"] =  time
        cv["CLASS"] = CLASS
        cv["POTENCY_AMT"] = POTENCY_AMT
        cv["AREA"] = AREA
        insertQry(Table_name: CBO_DB_Helper.NonListed_call, values: cv)
        
    }
    
    
    public func delete_Nonlisted_calls() {
        DeleteQry(Table_name: CBO_DB_Helper.NonListed_call, WhereClause: "")
    }
    
    
    public func delete_Doctor_from_local_all( dr_id: String) {
        
        DeleteQry(Table_name:"tempdr",WhereClause: "dr_id='"+dr_id+"'");
        DeleteQry(Table_name:"phdcrdr_more",WhereClause: "dr_id='"+dr_id+"'");
        DeleteQry(Table_name:"phdcrdr",WhereClause: "dr_id='"+dr_id+"'");
        DeleteQry(Table_name:CBO_DB_Helper.DOCTOR_ITEM_TABLE, WhereClause:"dr_id='"+dr_id+"'");
        delete_DCR_Item(ID: dr_id,item_id: nil,ItemType: nil,Category: "DR");
        
    }
    
    public func delete_Stokist_from_local_all( dr_id : String) {
        
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_stk, WhereClause: "stk_id='"+dr_id+"'")
        // sd.delete("phdcrstk", "stk_id='"+dr_id+"'", null)
        delete_DCR_Item(ID: dr_id,item_id: nil,ItemType: nil,Category: "STK");
    }
    
    public func delete_DoctorRemainder_from_local_all( dr_id : String) {
        
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_Dr_rc, WhereClause: "dr_id='"+dr_id+"'")
        //sd.delete("phdcrdr_rc", "dr_id='"+dr_id+"'", null);
        
    }
    
    public func delete_Chemist_from_local_all( dr_id : String) {
        DeleteQry(Table_name: CBO_DB_Helper.PH_Dcr_chem, WhereClause: "chem_id='"+dr_id+"'")
        DeleteQry(Table_name: CBO_DB_Helper.Chemist_Temp, WhereClause: "chem_id='"+dr_id+"'")
        //    sd.delete("phdcrchem", "chem_id='"+dr_id+"'", null);
        //    sd.delete("chemisttemp", "chem_id='"+dr_id+"'", null);
        delete_DCR_Item(ID: dr_id,item_id: nil,ItemType: nil,Category: "CHEM");
        
    }
    //
    public func insert_Mail( mail_id: Int,  who_id: String, who_name :String, date
        :String, time : String ,is_read :String, category:String, type: String, subject
        :String, remark: String, file_name: String ,file_path :String) {
        var cv = [String : Any]()
        cv["mail_id"] = mail_id
        cv["who_id"] = who_id
        cv["who_name"] = who_name
        cv["date"] = date
        cv["time"] = time
        cv["category"] = category
        cv["type"] = type
        cv["subject"] = subject
        cv["remark"] = remark
        cv["file_name"] = file_name
        cv["file_path"] = file_path
        
        
        
        if (get_Mail(mail_category: category, mail_id: "\(mail_id)").count > 0){
            updateQry(Table_name: CBO_DB_Helper.Mail, values: cv, WhereClause: "mail_id="+"\(mail_id)")
        }else {
            cv["is_read"] = is_read
            insertQry(Table_name: CBO_DB_Helper.Mail, values: cv)
        }
    }
    
    public func update_Mail( mail_id : String, is_read : String) {
        var cv = [String:String]()
        cv["is_read"] = is_read
        updateQry(Table_name: CBO_DB_Helper.Mail, values: cv, WhereClause:"mail_id="+mail_id )
    }
    
    public func   get_Mail( mail_category:String, mail_id:String) -> [[String : String]] {
        var data = [[String: String]]();
        var query = "Select * from " + CBO_DB_Helper.Mail+" where category='"+mail_category+"' order by mail_id DESC" ;
        if (mail_id != ("")){
            query = "Select * from " + CBO_DB_Helper.Mail+" where mail_id='"+mail_id+"' order by mail_id DESC" ;
        }
        
        if (mail_category == ("X")){
            query = "Select * from " + CBO_DB_Helper.Mail+" where id='"+mail_id+"' order by id DESC" ;
        }
        if (mail_category==("d")){
            query = "Select * from " + CBO_DB_Helper.Mail+" where category='"+mail_category+"' order by id DESC" ;
        }
        
        do {
            let statement = try connection!.prepare(query)
            
            while let c = statement.next(){
                var datanum = [String : String]();
                
                try datanum["from"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "who_name")]! as! String)
                try datanum["from_id"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "who_id")]! as! String)
                try datanum["time"] =  (c[getColumnIndex(statement: statement, Coloumn_Name: "time")]! as! String)
                try datanum["sub"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "subject")]! as! String)
                try datanum["date"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "date")]! as! String)
                try datanum["mail_id"] = "\(c[getColumnIndex(statement: statement, Coloumn_Name: "mail_id")]! as! Int64)"
                
                try datanum["id"] = "\(c[getColumnIndex(statement: statement, Coloumn_Name: "id")]! as! Int64)"
                try datanum["category"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "category")]! as! String)
                
                let filename = try (c[getColumnIndex(statement: statement, Coloumn_Name: "file_path")]! as! String).components(separatedBy: ",")
                
                if (filename.count > 0 && !(filename[0].isEmpty)){
                    datanum["FILE_NAME"] = filename[0]
                }else {
                    datanum["FILE_NAME"] = ""
                }
                
                try datanum["REMARK"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "remark")]! as! String)
                try datanum["IS_READ"] = (c[getColumnIndex(statement: statement, Coloumn_Name: "is_read")]! as! String)
                
                
                data.append(datanum);
            }
        }catch{
            print(error)
        }
        
        return data
    }
    
    
    public  func getMaxMailId( mail_category : String) -> String{
        var mail_id = 0
        
        do {
            let statement = try connection!.prepare("SELECT MAX(mail_id) as mail_id FROM "+CBO_DB_Helper.Mail+" where category='"+mail_category+"'")
            if statement.next() != nil{
                while let c = statement.next(){
                    mail_id = Int((c[try getColumnIndex(statement: statement, Coloumn_Name: "mail_id")]!) as! String)!
                }
            }
        }
        catch{
            print(error)
        }
        return String(mail_id)
    }
    
    public func getNoOfUnreadMail( mail_category: String) -> Int{
        var mail_id=0
        
        do {
            let statement = try connection!.prepare("SELECT * FROM "+CBO_DB_Helper.Mail+" where category='"+mail_category+"' and is_read='0'")
            while statement.next() != nil{
                mail_id += 1
            }
        }
        catch{
            print(error)
        }
        return mail_id;
    }
    
    func delete_Mail( mail_id : String) {
        if (mail_id == "") {
            DeleteQry(Table_name: CBO_DB_Helper.Mail, WhereClause: "")
        }else{
            DeleteQry(Table_name: CBO_DB_Helper.Mail, WhereClause: "id='"+mail_id+"'")
        }
    }
    //
    //
    //
    //    //=============================================dcr Appraisal with table================================================================
    //
    public func setDcrAppraisal( PA_ID : String,  PA_NAME  : String, DR_CALL  : String,  DR_AVG  : String, CHEM_CALL  : String
        ,  CHEM_AVG  : String, FLAG  : String,  sAPPRAISAL_ID_STR  : String,  sAPPRAISAL_NAME_STR  : String
        , sGRADE_STR  : String, sGRADE_NAME_STR  : String,  sOBSERVATION  : String,  sACTION_TAKEN  : String) {
        var cv = [String : Any]()
        cv["PA_ID"] =  PA_ID
        cv["PA_NAME"] =  PA_NAME
        cv["DR_CALL"] = DR_CALL
        cv["DR_AVG"] =  DR_AVG
        cv["CHEM_CALL"] =  CHEM_CALL
        cv["CHEM_AVG"] =  CHEM_AVG
        cv["FLAG"] =  FLAG
        cv["sAPPRAISAL_ID_STR"] = sAPPRAISAL_ID_STR
        cv["sAPPRAISAL_NAME_STR"] = sAPPRAISAL_NAME_STR
        cv["sGRADE_STR"] = sGRADE_STR
        cv["sGRADE_NAME_STR"] =  sGRADE_NAME_STR
        cv["sOBSERVATION"] = sOBSERVATION
        cv["sACTION_TAKEN"] = sACTION_TAKEN
        insertQry(Table_name: CBO_DB_Helper.Appraisal, values: cv)
    }
    public func update_Apraisal( pa_id  : String, FLAG  : String,  sAPPRAISAL_ID_STR  : String,  sAPPRAISAL_NAME_STR  : String
        , sGRADE_STR  : String, sGRADE_NAME_STR  : String, sOBSERVATION  : String, sACTION_TAKEN  : String) {
        var cv = [String : Any]()
        cv["FLAG"] =  FLAG
        cv["sAPPRAISAL_ID_STR"] =  sAPPRAISAL_ID_STR
        cv["sAPPRAISAL_NAME_STR"] =   sAPPRAISAL_NAME_STR
        cv["sGRADE_STR"] =   sGRADE_STR
        cv["sGRADE_NAME_STR"] =   sGRADE_NAME_STR
        cv["sOBSERVATION"] =   sOBSERVATION
        cv["sACTION_TAKEN"] =   sACTION_TAKEN
        updateQry(Table_name: CBO_DB_Helper.Appraisal, values: cv,WhereClause: "PA_ID='\(pa_id)")
    }
    
    
    
    // Mark:-  working here
    public  func  get_Appraisal(flag :String , pa_id: String) ->  [[String: String ]]{
        
        var  data = [[String: String]]();
        var query = "Select * from " + CBO_DB_Helper.Appraisal
        if (pa_id != ""){
            query = "Select * from " + CBO_DB_Helper.Appraisal+" where PA_ID='"+pa_id+"'" ;
        }
        if (pa_id == "" && flag != ""){
            query = "Select * from " + CBO_DB_Helper.Appraisal+" where FLAG='"+flag+"'" ;
        }
        do{
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                var datanum = [String : String]();
                try datanum["PA_ID"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"PA_ID")]! as! String)
                try datanum["PA_NAME"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"PA_NAME")]! as! String)
                try datanum["DR_CALL"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"DR_CALL")]! as! String)
                try datanum["DR_AVG"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"DR_AVG")]! as! String)
                try datanum["CHEM_CALL"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"CHEM_CALL")]! as! String)
                try datanum["CHEM_AVG"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"CHEM_AVG")]! as! String)
                try datanum["FLAG"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"FLAG")]! as! String)
                try datanum["sAPPRAISAL_ID_STR"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"sAPPRAISAL_ID_STR")]! as! String)
                try datanum["sAPPRAISAL_NAME_STR"] = (c[getColumnIndex(statement : statement, Coloumn_Name: "sAPPRAISAL_NAME_STR")]! as! String)
                try datanum["sGRADE_STR"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"sGRADE_STR")]! as! String)
                try datanum["sGRADE_NAME_STR"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"sGRADE_NAME_STR")]! as! String)
                try datanum["sOBSERVATION"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"sOBSERVATION")]! as! String)
                try datanum["sACTION_TAKEN"] = (c[getColumnIndex(statement : statement, Coloumn_Name:"sACTION_TAKEN")]! as! String)
                data.append(datanum);
            }
            
        }catch{
            print(error)
        }
        return data;
    }
    
    public func deleteDcrAppraisal() {
        DeleteQry(Table_name: CBO_DB_Helper.Appraisal, WhereClause: "")
    }
    //
    //    ///=================================================exp head==========================================
    
    public func Insert_EXP_Head( FIELD_NAME : String, FIELD_ID : String, MANDATORY : String, DA_ACTION : String,
                                 EXP_TYPE: String, ATTACHYN: String, MAX_AMT: String, TAMST_VALIDATEYN : String) {
        var cv = [String : Any]()
        cv["FIELD_NAME"] = FIELD_NAME
        cv["FIELD_ID"] = FIELD_ID
        cv["MANDATORY"] = MANDATORY
        cv["DA_ACTION"] = DA_ACTION
        
        cv["EXP_TYPE"] = EXP_TYPE
        cv["ATTACHYN"] = ATTACHYN
        cv["MAX_AMT"] = MAX_AMT
        cv["TAMST_VALIDATEYN"] = TAMST_VALIDATEYN
        
        cv["SHOW_IN_TA_DA"] = "0"
        cv["KMYN"] = "N"
        cv["HEADTYPE_GROUP"] = "0"
        
        insertQry(Table_name: CBO_DB_Helper.Expenses_head, values: cv)
    }
    
    
    public func Insert_EXP_Head(expHead : mExpHead) {
        var cv = [String : Any]()
        cv["FIELD_NAME"] = expHead.getName()
        cv["FIELD_ID"] = expHead.getId()
        cv["MANDATORY"] = expHead.getMANDATORY()
        cv["DA_ACTION"] = expHead.getDA_ACTION()
        
        cv["EXP_TYPE"] = expHead.getEXP_TYPE().name()
        cv["ATTACHYN"] = expHead.getATTACHYN()
        cv["MAX_AMT"] = expHead.getMAX_AMT()
        cv["TAMST_VALIDATEYN"] = expHead.getMasterValidate()
        
        cv["SHOW_IN_TA_DA"] = expHead.getSHOW_IN_TA_DA().name();
        cv["KMYN"] = expHead.getKMYN();
        cv["HEADTYPE_GROUP"] =  expHead.getHEADTYPE_GROUP();
        
        insertQry(Table_name: CBO_DB_Helper.Expenses_head, values: cv)
    }
    
    
    func getEXP_Head(Id : String) -> mExpHead{
        var  expHead = mExpHead(id: 0,name: "");
        let query = "Select * from " + CBO_DB_Helper.Expenses_head + " where FIELD_ID='"+Id+"'";
        
        
        do{
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                expHead = mExpHead(id: Int(c[try getColumnIndex(statement : statement, Coloumn_Name: "FIELD_ID")]!  as! String)!,
                                   name: c[try getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]!  as! String)
                    
                    .setEXP_TYPE(EXP_TYPE: eExpanse.valueOf( c[try getColumnIndex(statement : statement, Coloumn_Name: "EXP_TYPE")]!  as! String))
                    .setSHOW_IN_TA_DA(SHOW_IN_TA_DA: eExpanse.valueOf(c[try getColumnIndex(statement: statement, Coloumn_Name: "SHOW_IN_TA_DA")]! as! String))
                    .setATTACHYN(ATTACHYN: Int(c[try getColumnIndex(statement : statement, Coloumn_Name: "ATTACHYN")]!  as! String)!)
                    .setDA_ACTION(DA_ACTION: Int(c[try getColumnIndex(statement : statement, Coloumn_Name: "DA_ACTION")]!  as! String)!)
                    .setMANDATORY(MANDATORY: Int(c[try getColumnIndex(statement : statement, Coloumn_Name: "MANDATORY")]!  as! String)!)
                    .setMAX_AMT(MAX_AMT: c[try getColumnIndex(statement : statement, Coloumn_Name: "MAX_AMT")]!  as! Double)
                    .setKMYN(KMYN: c[try getColumnIndex(statement: statement, Coloumn_Name: "KMYN")]! as! String)
                    .setHEADTYPE_GROUP(HEADTYPE_GROUP: c[try getColumnIndex(statement: statement, Coloumn_Name: "HEADTYPE_GROUP")]! as! String)
                    .setMasterValidate(masterValidate: Int(c[try getColumnIndex(statement : statement, Coloumn_Name: "TAMST_VALIDATEYN")]!  as! String)!)
                
                
            }
        }catch{
            print(error)
        }
        
        return expHead;
    }
    
    
//    public func getExpHead(Id: Int) -> mExpHead{
//           var expHead: mExpHead?  = nil;
//
//           let query = "Select * from " + CBO_DB_Helper.Expenses_head + " where FIELD_ID='" + String(Id) + "'";
//
//               do {
//                   let statement = try connection!.prepare(query)
//                   while let c = statement.next(){
//                       expHead = mExpHead(id: c[try getColumnIndex(statement: statement, Coloumn_Name: "FIELD_ID")]! as! Int, name: c[try getColumnIndex(statement: statement, Coloumn_Name: "FIELD_NAME")]! as! String)
//                       .setEXP_TYPE(EXP_TYPE: eExpanse.valueOf(c[try getColumnIndex(statement: statement, Coloumn_Name: "EXP_TYPE")]! as! String))
//                       .setSHOW_IN_TA_DA(SHOW_IN_TA_DA: eExpanse.valueOf(c[try getColumnIndex(statement: statement, Coloumn_Name: "SHOW_IN_TA_DA")]! as! String))
//
//                       .setATTACHYN(ATTACHYN: c[try getColumnIndex(statement: statement, Coloumn_Name: "ATTACHYN")]! as! Int)
//                       .setDA_ACTION(DA_ACTION: c[try getColumnIndex(statement: statement, Coloumn_Name: "DA_ACTION")]! as! Int)
//                       .setMANDATORY(MANDATORY: c[try getColumnIndex(statement: statement, Coloumn_Name: "MANDATORY")]! as! Int)
//                       .setMAX_AMT(MAX_AMT: c[try getColumnIndex(statement: statement, Coloumn_Name: "MAX_AMT")]! as! Double)
//                       .setKMYN(KMYN: c[try getColumnIndex(statement: statement, Coloumn_Name: "KMYN")]! as! String)
//                       .setHEADTYPE_GROUP(HEADTYPE_GROUP: c[try getColumnIndex(statement: statement, Coloumn_Name: "HEADTYPE_GROUP")]! as! String)
//                       .setMasterValidate(masterValidate: c[try getColumnIndex(statement: statement, Coloumn_Name: "TAMST_VALIDATEYN")]! as! Int)
//
//               }
//
//               } catch{
//                   print(error)
//               }
//
//
//           return expHead!;
//
//       }
    
    
    func get_ExpenseHeadNotAdded(SHOW_IN_TA_DA : eExpanse) -> [DPItem]{
        var  data = [DPItem]();
        let query = "Select * from " + CBO_DB_Helper.Expenses_head  + " LEFT JOIN " + CBO_DB_Helper.Expenses + " ON exp_head_id = FIELD_ID where exp_head_id IS NULL"
        

        var WhereClause = "";

        WhereClause = WhereClause + " AND  SHOW_IN_TA_DA = '"+SHOW_IN_TA_DA.name()+"'";
        
        do{
            let statement = try connection!.prepare(query + WhereClause)
            data.append( DPItem(title: "--Select--", code: ""));
            while let c = statement.next(){
                let datanum = DPItem(title: c[try getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]!  as! String,
                                     code: c[try getColumnIndex(statement : statement, Coloumn_Name: "FIELD_ID")]!  as! String,
                                     type : c[try getColumnIndex(statement : statement, Coloumn_Name: "DA_ACTION")]!  as! String);
                
                data.append(datanum);
            }
        }catch{
            print(error)
        }
        
        return data;
    }
    
    func get_ExpenseHeadNotAdded() -> [DPItem]{
        var  data = [DPItem]();
        let query = "Select * from " + CBO_DB_Helper.Expenses_head  + " LEFT JOIN " + CBO_DB_Helper.Expenses + " ON exp_head_id = FIELD_ID where exp_head_id IS NULL"
        
        do{
            let statement = try connection!.prepare(query)
            data.append( DPItem(title: "--Select--", code: ""));
            while let c = statement.next(){
                let datanum = DPItem(title: c[try getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]!  as! String,
                                     code: c[try getColumnIndex(statement : statement, Coloumn_Name: "FIELD_ID")]!  as! String,
                                     type : c[try getColumnIndex(statement : statement, Coloumn_Name: "DA_ACTION")]!  as! String);
                
                data.append(datanum);
            }
        }catch{
            print(error)
        }
        
        return data;
    }
    
    
    func get_ExpenseTypeAdded(typeStr : String) -> [[String: String]]{
        var  data = [[String: String]]();
        let query = "Select * from " + CBO_DB_Helper.Expenses + " LEFT JOIN " + CBO_DB_Helper.Expenses_head  + " ON exp_head_id = FIELD_ID where EXP_TYPE ='" + typeStr + "'";
        
        
        do{
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                var datanum = [String : String]();
                try datanum["PA_NAME"] = c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]! as! String
                try datanum["PA_ID"] = c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_ID")]!  as! String
                data.append(datanum);
            }
        }catch{
            print(error)
        }
        
        return data;
    }
    
    public func delete_EXP_Head() {
        DeleteQry(Table_name: CBO_DB_Helper.Expenses_head, WhereClause: "")
    }
    
    func get_mandatory_pending_exp_head() -> [[String: String]]{
        var  data = [[String: String]]();
        
        let query = "Select * from " + CBO_DB_Helper.Expenses_head + " where MANDATORY='1' and  FIELD_ID NOT IN(SELECT exp_head_id FROM "+CBO_DB_Helper.Expenses+")";
        //String query = "Select * from " + Expenses_head + " LEFT JOIN "+Expenses+" ON exp_head_id=FIELD_ID where MANDATORY='1' and exp_head_id != FIELD_ID" ;
        do{
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                var datanum = [String : String]();
                try datanum["PA_NAME"] = c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]! as! String
                try datanum["PA_ID"] = c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_ID")]!  as! String
                data.append(datanum);
            }
        }catch{
            print(error)
        }
        
        return data;
    }
    
    
    func get_DA_ACTION_exp_head() -> [[String: String]]{
        var  data = [[String: String]]();
        
        let query = "Select * from " + CBO_DB_Helper.Expenses_head + " where DA_ACTION='1' and  FIELD_ID IN(SELECT exp_head_id FROM "+CBO_DB_Helper.Expenses+")";
        
        do{
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                var datanum = [String : String]();
                try datanum["PA_NAME"] = c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]! as! String
                try datanum["PA_ID"] = c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_ID")]!  as! String
                data.append(datanum);
            }
        }catch{
            print(error)
        }
        
        return data;
    }
    //
    //    ///================================================tenivia traker=============================================
    //
    //    public func Insert_tenivia_traker(String DR_ID, String DR_NAME,String QTY
    //    ,String AMOUNT, String QTY_CAPTION,String ITEM_ID,String AMOUN_CAPTION, String TIME,String REMARK) {
    //    sd = this.getWritableDatabase();
    //    ContentValues cv = new ContentValues();
    //    cv["DR_ID", DR_ID);
    //    cv["DR_NAME", DR_NAME);
    //    cv["QTY", QTY);
    //    cv["AMOUNT", AMOUNT);
    //    cv["QTY_CAPTION", QTY_CAPTION);
    //    cv["ITEM_ID", ITEM_ID);
    //    cv["AMOUN_CAPTION", AMOUN_CAPTION);
    //    cv["TIME", TIME);
    //    cv["REMARK", REMARK);
    //    sd.insert(Tenivia_traker, null, cv);
    //    }
    //
    
    
    public func Insert_tenivia_traker( DR_ID : String, DR_NAME : String,  QTY
        : String, AMOUNT: String,  QTY_CAPTION: String, ITEM_ID: String,  AMOUN_CAPTION: String, TIME: String, REMARK: String) {
        
        var cv = [String : String]()
        cv["DR_ID"] =  DR_ID
        cv["DR_NAME"] =  DR_NAME
        cv["QTY"] =  QTY
        cv["AMOUNT"] =  AMOUNT
        cv["QTY_CAPTION"] =  QTY_CAPTION
        cv["ITEM_ID"] =  ITEM_ID
        cv["AMOUN_CAPTION"] =  AMOUN_CAPTION
        cv["TIME"] =  TIME
        cv["REMARK"] =  REMARK
        insertQry(Table_name:CBO_DB_Helper.Tenivia_traker, values: cv);
        if (DR_ID != ("-1")){
            delete_tenivia_traker(DR_ID: "-1");
        }
    }
    
    public func Update_tenivia_traker( DR_ID : String, DR_NAME : String,  QTY
        : String, AMOUNT: String,  QTY_CAPTION: String, ITEM_ID: String,  AMOUN_CAPTION: String, TIME: String, REMARK: String) {
        var cv = [String : String]()
        cv["DR_ID"] =  DR_ID
        cv["DR_NAME"] =  DR_NAME
        cv["QTY"] =  QTY
        cv["AMOUNT"] =  AMOUNT
        cv["QTY_CAPTION"] =  QTY_CAPTION
        cv["ITEM_ID"] =  ITEM_ID
        cv["AMOUN_CAPTION"] =  AMOUN_CAPTION
        cv["TIME"] =  TIME
        cv["REMARK"] =  REMARK
        updateQry(Table_name:CBO_DB_Helper.Tenivia_traker, values: cv, WhereClause: "DR_ID ='" + DR_ID+"'");
    }
    
    public func delete_tenivia_traker( DR_ID : String) {
        DeleteQry(Table_name: CBO_DB_Helper.Tenivia_traker , WhereClause: "DR_ID ='" + DR_ID+"'")
    }
    
    public func delete_tenivia_traker() {
        DeleteQry(Table_name: CBO_DB_Helper.Tenivia_traker , WhereClause: "")
    }
    //
    //
    //    ///=================================================exp head==========================================
    //
    public func delete_Doctor_Call_Remark() {
        DeleteQry(Table_name: CBO_DB_Helper.Doctor_Call_Remark, WhereClause: "")
    }
    //
    
    
    func get_Doctor_Call_Remark() -> [String]{
        return get_Call_Status_Remark(type: "R");
    }
    
    func get_Doctor_Call_Status_List() -> [String]{
        return get_Call_Status_Remark(type: "S");
    }
    
    func get_Call_Status_Remark(type : String) -> [String]{
        var  data = [String]();
        
        let query = "Select * from " + CBO_DB_Helper.Doctor_Call_Remark + " where type='" + type + "'";
        do{
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                try data.append( c[getColumnIndex(statement : statement, Coloumn_Name: "FIELD_NAME")]! as! String)
            }
        }catch{
            print(error)
        }
        
        if (data.count == 0){
            data.append("Other");
        }
        return data;
    }
    
    public func insertDoctorCallRemark( item_id : String,  item_name : String, type : String) {
        var cv = [String : String]()
        cv["FIELD_NAME"] =  item_name
        cv["FIELD_ID"] =  item_id
        cv["TYPE"] =  type
        insertQry(Table_name: CBO_DB_Helper.Doctor_Call_Remark, values: cv)
    }
    //
    //
    public func DropDatabase() {
        let fm = FileManager.default
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
        do{
            let url = "\(dbPath!)/\(CBO_DB_Helper.DATABASE_NAME).sqite3"
            
            try fm.removeItem(atPath: url)
            UserDefaults.standard.set(0, forKey: "db_Version")
            CBO_DB_Helper.Instance = nil
        } catch {
            NSLog("Error deleting file: (url)")
        }
        ;
    }
    //
    //
    //    //========================================================================================================
    //
    //
    public func insertLat_Long_Reg( DCS_ID : String ,  LAT_LONG : String , DCS_TYPE : String , DCS_ADD : String , DCS_INDES : String) {
        var cv = [String: Any]()
        cv["DCS_ID"] =  DCS_ID
        cv["LAT_LONG"] =  LAT_LONG
        cv["DCS_TYPE"] =  DCS_TYPE
        cv["DCS_ADD"] =  DCS_ADD
        cv["DCS_INDES"] =  DCS_INDES
        cv["UPDATED"] =  "0"
        
        insertQry(Table_name: CBO_DB_Helper.Lat_Long_Reg, values: cv)
        
    }
    
    public func updatedLat_Long_Reg( DCS_ID : String) {
        var cv = [String: Any]()
        cv["UPDATED"] =  "1"
        updateQry(Table_name: CBO_DB_Helper.Lat_Long_Reg, values: cv, WhereClause: "DCS_ID ='" + DCS_ID+"'")
        
    }
    
    public func delete_Lat_Long_Reg() {
        DeleteQry(Table_name: CBO_DB_Helper.Lat_Long_Reg, WhereClause: "" )
    }
    
    
    public  func get_Lat_Long_Reg(updated : String? = "0") -> [[String: String]] {
        // default value is zero as there is no nead to update it again.... on the server
        var  data = [[String :String]]()
        
        do{
            
            let statement = try connection!.prepare("select * from " + CBO_DB_Helper.Lat_Long_Reg + " where updated='" + updated! + "'")
            
            while let c = statement.next(){
                var datanum = [String : String]()
                datanum["DCS_ID"] = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "DCS_ID")] as? String)
                
                datanum["LAT_LONG"] = try c[getColumnIndex(statement: statement , Coloumn_Name:  "LAT_LONG")] as? String
                datanum["DCS_TYPE"] = try (c[getColumnIndex(statement: statement , Coloumn_Name:  "DCS_TYPE")] as? String)
                datanum["DCS_ADD"] = try c[getColumnIndex(statement: statement , Coloumn_Name:  "DCS_ADD")] as? String
                datanum["DCS_INDES"] = try c[getColumnIndex(statement: statement , Coloumn_Name:  "DCS_INDES")] as? String
                data.append(datanum)
            }
        }catch{
            print(error)
        }
        
        return data;
    }
    
    //
    //
    //
    //
    ////        func InsertContact(name:String,address:String,city:String,zipCode:String ,  phone : String)  {
    ////            var ContantValues = [String :  String ]()
    ////
    ////                ContantValues["NAME"] = name
    ////                ContantValues["ADDRESS"] = address
    ////                ContantValues["CITY"] = city
    ////                ContantValues["ZIP_CODE"] = zipCode
    ////                ContantValues["PHONE"] = phone
    ////
    ////            insertQry(Table_name: CBO_DB_Helper.Contacts, values: ContantValues)
    ////
    ////        }
    //
    ////        func UpdatetContact(name:String,address:String,city:String,zipCode:String ,  phone : String)  {
    ////            var ContantValues = [String :  String ]()
    ////
    ////            ContantValues["NAME"] = name
    ////            ContantValues["ADDRESS"] = address
    ////            ContantValues["CITY"] = city
    ////            ContantValues["ZIP_CODE"] = zipCode
    ////            ContantValues["PHONE"] = phone
    ////
    ////            updateQry(Table_name: CBO_DB_Helper.Contacts, values: ContantValues, WhereClause: "id = 1" )
    ////
    ////        }
    ////
    ////
    ////        func DeleteContact(name:String,address:String,city:String,zipCode:String ,  phone : String)  {
    ////            var ContantValues = [String :  String ]()
    ////
    ////            ContantValues["NAME"] = name
    ////            ContantValues["ADDRESS"] = address
    ////            ContantValues["CITY"] = city
    ////            ContantValues["ZIP_CODE"] = zipCode
    ////            ContantValues["PHONE"] = phone
    ////
    ////            updateQry(Table_name: CBO_DB_Helper.Contacts, values: ContantValues, WhereClause: "id = 1" )
    ////
    ////        }
    ////
    //
    //    }
    //
    //
    //
    //
    
    
    
    
    
    
    
    
    
    ///------------------------------------------------dairy tables----------------------------------------------
    //    String DAIRY_TABLE = "CREATE TABLE " + PH_DAIRY+ " ( id integer primary key,DAIRY_ID integer,DAIRY_NAME text,DOC_TYPE text,LAST_VISIT_DATE text,DR_LAT_LONG text,DR_LAT_LONG2 text,DR_LAT_LONG3 text)";
    //    String DAIRY_PERSON_TABLE = "CREATE TABLE " + PH_DAIRY_PERSON+ " ( id integer primary key,DAIRY_ID integer,PERSON_ID integer,PERSON_NAME text)";
    //    String DAIRY_REASON_TABLE = "CREATE TABLE " + PH_DAIRY_REASON+ " ( id integer primary key,PA_ID integer,PA_NAME text)";
    
    
    public func insert_phdairy( DAIRY_ID : Int, DAIRY_NAME : String,  DOC_TYPE : String, LAST_VISIT_DATE : String , DR_LAT_LONG : String ,DR_LAT_LONG2 : String,  DR_LAT_LONG3 : String) {
        
        
        var cv = [String : Any]()
        cv["DAIRY_ID"] = DAIRY_ID
        cv["DAIRY_NAME"] =  DAIRY_NAME
        cv["DOC_TYPE"] = DOC_TYPE
        cv["LAST_VISIT_DATE"] = LAST_VISIT_DATE
        cv["DR_LAT_LONG"] = DR_LAT_LONG
        cv["DR_LAT_LONG2"] = DR_LAT_LONG2
        cv["DR_LAT_LONG3"] = DR_LAT_LONG3
        insertQry(Table_name: CBO_DB_Helper.PH_DAIRY, values: cv)
    }
    
    
    public func getphdairy( DOC_TYPE : String) throws -> Statement {
        do{
            return  try connection!.prepare("select PHDAIRY.DAIRY_ID,PHDAIRY.DAIRY_NAME,PHDAIRY.LAST_VISIT_DATE,DR_LAT_LONG,DR_LAT_LONG2,DR_LAT_LONG3, CASE WHEN IFNull(PHDAIRY_DCR.DAIRY_ID,0) >0 THEN 1 ELSE 0 END AS CALLYN from PHDAIRY LEFT OUTER JOIN PHDAIRY_DCR  ON PHDAIRY.DAIRY_ID=PHDAIRY_DCR.DAIRY_ID  where PHDAIRY.DOC_TYPE='\(DOC_TYPE)'");
        }catch{
            print(error)
            throw error
        }
    }
    
    
    public  func get_phdairy( DOC_TYPE : String)  -> [[String : String]] {
        
        var data = [[String : String]]()
        
        do {
            
            let query = "select PHDAIRY.DAIRY_ID,PHDAIRY.DAIRY_NAME,PHDAIRY.LAST_VISIT_DATE,DR_LAT_LONG,DR_LAT_LONG2,DR_LAT_LONG3, CASE WHEN IFNull(PHDAIRY_DCR.DAIRY_ID,0) >0 THEN 1 ELSE 0 END AS CALLYN from PHDAIRY LEFT OUTER JOIN PHDAIRY_DCR  ON PHDAIRY.DAIRY_ID=PHDAIRY_DCR.DAIRY_ID  where PHDAIRY.DOC_TYPE=''\(DOC_TYPE)'"
            
            let  statement  = try connection!.prepare(query)
            
            while let c = statement.next() {
                var datanum = [String :String]()
                
                datanum["DAIRY_ID"] = try String(describing: c[getColumnIndex(statement: statement, Coloumn_Name: "DAIRY_ID")])
                datanum["DAIRY_NAME"] = try String(describing: c[getColumnIndex(statement: statement, Coloumn_Name: "DAIRY_NAME")])
                datanum["LAST_VISIT_DATE"] = try String(describing: c[getColumnIndex(statement: statement, Coloumn_Name: "LAST_VISIT_DATE")])
                datanum["DR_LAT_LONG"] = try String(describing: c[getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG")])
                datanum["DR_LAT_LONG2"] = try String(describing: c[getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG2")])
                datanum["DR_LAT_LONG3"] = try String(describing: c[getColumnIndex(statement: statement, Coloumn_Name: "DR_LAT_LONG3")])
                
                data.append(datanum);
            }
        } catch{
            print(error)
        }
        return data;
    }
    
    
    public func delete_phdairy() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_DAIRY , WhereClause: "")
    }
    
    
    public func insert_phdairy_person( DAIRY_ID : Int , PERSON_ID :Int,  PERSON_NAME : String) {
        
        var cv = [String : Any]()
        cv["DAIRY_ID "] =  DAIRY_ID
        cv["PERSON_ID"] = PERSON_ID
        cv["PERSON_NAME"] = PERSON_NAME
        insertQry(Table_name: CBO_DB_Helper.PH_DAIRY_PERSON , values: cv)
    }
    
    public func get_phdairy_person( DAIRY_ID : String ) throws -> Statement {
        do{
            return  try connection!.prepare("select * from " + CBO_DB_Helper.PH_DAIRY_PERSON + " where DAIRY_ID='"+DAIRY_ID+"'")
        }catch{
            print(error)
            throw error
        }
        
    }
    
    public func delete_phdairy_person() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_DAIRY_PERSON , WhereClause: "")
        //    sd = this.getWritableDatabase();
        //    sd.delete(PH_DAIRY_PERSON, null, null);
    }
    
    public func insert_phdairy_reason(  PA_ID : Int,  PA_NAME : String) {
        var cv = [String :Any]()
        cv["PA_ID"] = PA_ID
        cv["PA_NAME"] = PA_NAME
        insertQry(Table_name: CBO_DB_Helper.PH_DAIRY_REASON, values: cv)
        //        long l= sd.insert(PH_DAIRY_REASON, null, cv);
        
    }
    
    public func get_phdairy_reason() -> [String] {
        var data = [String]()
        
        do {
            let query = "Select * from " + CBO_DB_Helper.PH_DAIRY_REASON ;
            let  statement  = try connection!.prepare(query)
            while let c = statement.next(){
                data.append( try c[getColumnIndex(statement: statement, Coloumn_Name: "PA_NAME")] as! String)
            }
            
        }catch{
            print(error)
        }
        if (data.count == 0){
            data.append("Other")
        }
        return data;
    }
    
    
    public func delete_phdairy_reason() {
        DeleteQry(Table_name:  CBO_DB_Helper.PH_DAIRY_REASON, WhereClause: "")
        //    sd = this.getWritableDatabase();
        //    sd.delete(PH_DAIRY_REASON, null, null);
    }
    
    //     String DAIRY_DCR_TABLE = "CREATE TABLE "+PH_DAIRY_DCR +" ( id integer primary key,DAIRY_ID text,DOC_TYPE text,DAIRY_NAME text,
    // visit_time text,batteryLevel text,dr_latLong text,dr_address text,dr_remark text,updated text,dr_km text,srno text,
    // person_name text,person_id text,pob_amt text,allitemid text,allitemqty text,sample text,allgiftid text,allgiftqty text,file text,LOC_EXTRA text)";
    
    public func  insert_phdairy_dcr( DAIRY_ID : String, DAIRY_NAME : String ,DOC_TYPE : String ,  visit_time : String , DR_LAT_LONG : String , batteryLevel : String,  dr_address: String , dr_remark : String ,  dr_km : String,  srno : String , person_name : String , person_id : String,  pob_amt : String,  allitemid : String , allitemqty : String ,sample: String , allgiftid : String , allgiftqty : String , file :String , LOC_EXTRA : String , IS_INTRESTED : String, Ref_latlong : String ) {
        var cv = [String : String]()
        
        cv["DAIRY_ID"] = DAIRY_ID
        cv["DAIRY_NAME"] = DAIRY_NAME
        cv["DOC_TYPE"] = DOC_TYPE
        cv["visit_time"] = visit_time
        cv["dr_latLong"] = DR_LAT_LONG
        cv["batteryLevel"] = batteryLevel
        cv["dr_address"] = dr_address
        
        cv["dr_remark"] = dr_remark
        cv["updated"] = "0"
        cv["dr_km"] = dr_km
        cv["srno"] = srno
        cv["person_name"] = person_name
        cv["person_id"] = person_id
        cv["pob_amt"] = pob_amt
        
        cv["allitemid"] = allitemid
        cv["allitemqty"] = allitemqty
        cv["sample"] = sample
        cv["allgiftid"] = allgiftid
        cv["allgiftqty"] = allgiftqty
        cv["file"] = file
        cv["LOC_EXTRA"] = LOC_EXTRA
        cv["IS_INTRESTED"] = IS_INTRESTED
        cv["Ref_latlong"] = Ref_latlong
        
        insertQry(Table_name: CBO_DB_Helper.PH_DAIRY_DCR, values: cv)
        
        delete_DCR_Item(ID: DAIRY_ID,item_id: nil,ItemType: nil,Category: "DAIRY");
        insert_DCR_Item(ID: DAIRY_ID,ArrITEM_ID: allitemid,ArrQTY: sample,ItemType: "SAMPLE",Category: "DAIRY");
        insert_DCR_Item(ID: DAIRY_ID,ArrITEM_ID: allgiftid,ArrQTY: allgiftqty,ItemType: "GIFT",Category: "DAIRY");
    }
    
    
    public func  update_phdairy_dcr(DAIRY_ID : String,DAIRY_NAME : String , DOC_TYPE :String , dr_remark : String , person_name : String,  person_id : String,  pob_amt : String,  allitemid : String,  allitemqty : String, sample : String , allgiftid : String ,  allgiftqty :  String,  file : String , IS_INTRESTED : String) {
        var cv = [String : String]()
        
        cv["DAIRY_ID" ] = DAIRY_ID
        cv["DAIRY_NAME"] = DAIRY_NAME
        cv["DOC_TYPE"] = DOC_TYPE
        //cv["visit_time", visit_time);
        //cv["dr_latLong", DR_LAT_LONG);
        //cv["batteryLevel", batteryLevel);
        //cv["dr_address", dr_address);
        
        cv["dr_remark"] = dr_remark
        cv["updated"] = "0"
        //cv["dr_km", dr_km);
        // cv["srno", srno);
        if(person_id != "") {
            cv["person_name"] =  person_name
            cv["person_id"] = person_id
        }
        
        if(allitemid != "" || dr_remark != "") {
            cv["pob_amt"] = pob_amt
            
            cv["allitemid"] = allitemid
            cv["allitemqty"] = allitemqty
            cv["sample"] = sample
        }
        
        if(allgiftid != "" || dr_remark != "") {
            cv["allgiftid"] = allgiftid
            cv["allgiftqty"] = allgiftqty
        }
        cv["file"] = file
        cv["IS_INTRESTED"] = IS_INTRESTED
        //cv["LOC_EXTRA", LOC_EXTRA);
        
        updateQry(Table_name: CBO_DB_Helper.PH_DAIRY_DCR , values: cv, WhereClause: "DAIRY_ID =" + DAIRY_ID)
        
        delete_DCR_Item(ID: DAIRY_ID,item_id: nil,ItemType: nil,Category: "DAIRY");
        insert_DCR_Item(ID: DAIRY_ID,ArrITEM_ID: allitemid,ArrQTY: sample,ItemType: "SAMPLE",Category: "DAIRY");
        insert_DCR_Item(ID: DAIRY_ID,ArrITEM_ID: allgiftid,ArrQTY: allgiftqty,ItemType: "GIFT",Category: "DAIRY");
        
    }
    
    public func updatedphdairy_dcr( DAIRY_ID : String) {
        var cv = [String : String]()
        cv["UPDATED"] = "1"
        updateQry(Table_name: CBO_DB_Helper.PH_DAIRY_DCR, values: cv, WhereClause: "DAIRY_ID =" + DAIRY_ID )
    }
    
    public func   get_phdairy_dcr( updated : String? = nil) -> [[String : String]] {
        var data = [[String :String]]()
        var query = ""
        if (updated == nil) {
            query = "select * from " + CBO_DB_Helper.PH_DAIRY_DCR
        }else{
            query = "select * from " + CBO_DB_Helper.PH_DAIRY_DCR + " where UPDATED='" + updated! + "'";
        }
        
        do {
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                var datanum = [String : String]()
                
                
                datanum["DAIRY_ID"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "DAIRY_ID")]!)
                datanum["DAIRY_NAME"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "DAIRY_NAME")]!)
                datanum["DOC_TYPE"]  = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "DOC_TYPE")]!)
                datanum["visit_time"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "visit_time")]!)
                datanum["dr_latLong"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "dr_latLong")]!)
                
                datanum["batteryLevel"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "batteryLevel")]!)
                datanum["dr_address"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "dr_address")]!)
                datanum["dr_remark"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "dr_remark")]!)
                datanum["updated"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "updated")]!)
                datanum["dr_km"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "dr_km")]!)
                datanum["srno"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "srno")]!)
                
                datanum["person_name"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "person_name")]!)
                datanum["person_id"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "person_id")]!)
                datanum["pob_amt"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "pob_amt")]!)
                datanum["allitemid"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "allitemid")]!)
                datanum["allitemqty"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "allitemqty")]!)
                
                datanum["sample"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "sample")]!)
                datanum["allgiftid"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "allgiftid")]!)
                datanum["allgiftqty"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "allgiftqty")]!)
                datanum["file"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "file")]!)
                datanum["LOC_EXTRA"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "LOC_EXTRA")]!)
                datanum["IS_INTRESTED"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "IS_INTRESTED")]!)
                datanum["Ref_latlong"] = try String(describing : c[getColumnIndex(statement: statement, Coloumn_Name: "Ref_latlong")]!)
                
                data.append(datanum)
            }
        } catch{
            print(error)
        }
        return data;
    }
    
    public func getCountphdairy_dcr( DOC_TYPE : String) -> Int{
        
        var result = 0
        let query = "SELECT COUNT(*) AS c from " + CBO_DB_Helper.PH_DAIRY_DCR + " where DOC_TYPE ='" + DOC_TYPE + "'" ;
        
        
        do {
            let statement = try connection!.prepare(query)
            while let c = statement.next(){
                result = try Int (c[getColumnIndex(statement: statement, Coloumn_Name: "c")] as! Int64)
            }
            
        }catch{
            print(error)
        }
        
        return  result;
    }
    
    
    
    
    
    
    public func delete_phdairy_dcr(DAIRY_ID : String?) {
        
        if (DAIRY_ID == nil) {
            
            DeleteQry(Table_name: CBO_DB_Helper.PH_DAIRY_DCR, WhereClause: "")
            //            sd.delete(PH_DAIRY_DCR, null, null);
            delete_DCR_Item(ID: nil,item_id: nil,ItemType: nil,Category: "DAIRY");
        }else{
            DeleteQry(Table_name: CBO_DB_Helper.PH_DAIRY_DCR, WhereClause:"DAIRY_ID ='"+DAIRY_ID!+"'" )
            //            sd.delete(PH_DAIRY_DCR, "DAIRY_ID ='"+DAIRY_ID+"'", null);
            delete_DCR_Item(ID: DAIRY_ID,item_id: nil,ItemType: nil,Category: "DAIRY");
        }
    }
    
    
    public func insert_Item_Stock(  ITEM_ID : String,  STOCK_QTY : Int) {
        
        var cv = [String : Any]()
        cv["STOCK_QTY"] = STOCK_QTY
        cv["ITEM_ID"] = ITEM_ID
        insertQry(Table_name: CBO_DB_Helper.PH_ITEM_STOCK_DCR, values: cv)
    }
    
    public func delete_Item_Stock() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_ITEM_STOCK_DCR, WhereClause: "")
    }
    
    public func insert_STk_Item( STK_ID : String , ITEM_ID :String,  RATE : String) {
        
        var cv = [String : Any]()
        cv["STK_ID "] =  STK_ID
        cv["ITEM_ID"] = ITEM_ID
        cv["RATE"] = RATE
        insertQry(Table_name: CBO_DB_Helper.PH_STK_ITEM_RATE , values: cv)
    }
    
    public func delete_STk_Item() {
        DeleteQry(Table_name: CBO_DB_Helper.PH_STK_ITEM_RATE, WhereClause: "")
    }
    
    
    public func delete_DCR_Item( ID : String?, item_id : String?, ItemType : String?, Category : String?) {
        
        var whereClause = "";
        
        if(ID != nil){
            whereClause =  "CategoryID = '" + ID! + "'";
        }
        if(ItemType != nil){
            if(!whereClause.isEmpty){
                whereClause = whereClause + " AND ";
            }
            whereClause =  whereClause +  "Category = '" + Category! + "'";
        }
        if(item_id != nil){
            if(!whereClause.isEmpty){
                whereClause = whereClause + " AND ";
            }
            whereClause =  whereClause +  "ITEM_ID = '" + item_id! + "'";
        }
        
        if(ItemType != nil){
            if(!whereClause.isEmpty){
                whereClause = whereClause + " AND ";
            }
            whereClause =  whereClause + "ItemType = '" + ItemType! + "'";
        }
        DeleteQry(Table_name: CBO_DB_Helper.PH_DCR_ITEM, WhereClause: whereClause)
        
    }
    
    
    public func insert_DCR_Item( ID : String,  ArrITEM_ID : String,  ArrQTY : String, ItemType : String,  Category : String) {
        var item_id : [String] = ArrITEM_ID.components(separatedBy: ",");
        var Qty : [String] = ArrQTY.components(separatedBy: ",");
        
        for i in 0 ..< item_id.count {
            var cv = [String : String]()
            cv["CategoryID"] = ID
            cv["QTY"] = Qty[i]
            cv["ITEM_ID"] = item_id[i]
            cv["ItemType"] = ItemType
            cv["Category"] = Category
            insertQry(Table_name: CBO_DB_Helper.PH_DCR_ITEM, values: cv)
            
        }
    }
    
    
}
