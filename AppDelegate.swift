//≥//
//  AppDelegate.swift
//  CBO Mobile Reporting
//
//  Created by rahul sharma on 04/12/17.
//  Copyright © 2017 rahul sharma. All rights reserved.



import UIKit
import CoreData
import Firebase
import FirebaseCore
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let gcmMessageIDKey = "gcm.message_id"
    private var topWindow: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    private var customVariablesAndMethods : Custom_Variables_And_Method!
    
    var backgroundSessionCompletionHandler : (() -> Void)?
   
    
    var user : mUser? = nil
    var dcr : mDCR? = nil
    
    public func refressUser(){
        user = nil
        dcr = nil
        getUser()
    }
    public func getUser() -> mUser{
        if (user != nil) {
            if (user?.getID().trimmingCharacters(in: .whitespacesAndNewlines) != ("0")
                && user?.getCompanyCode().trimmingCharacters(in: .whitespacesAndNewlines) != ("")) {
                return user!;
            }
        }
        
        
        let cbohelp = CBO_DB_Helper.shared
        
        user =  mUser(ID: cbohelp.getPaid(), companyCode: cbohelp.getCompanyCode())
            .setDCRId(DCRId: cbohelp.getDCR_ID_FromLocal())
            .setName(name: cbohelp.getPaName())
            .setHQ(HQ: cbohelp.getHeadQtr())
            .setDesgination(desgination: cbohelp.getDESIG())
            .setDesginationID(desginationID: cbohelp.getPUB_DESIG())
            .setLocation(location: Custom_Variables_And_Method.getInstance().getObject(context: nil,key: "currentBestLocation_Validated" ));
        //getDEVICE_ID();
        
        
        updateUser();
        return user!;
    }
    
    public func updateUser(){
        if (user?.getID().trimmingCharacters(in: .whitespacesAndNewlines) != ("0")
            && user?.getCompanyCode().trimmingCharacters(in: .whitespacesAndNewlines) != ("")) {
            //userDB.insert(user);
        }
    }
    
    public func getDCR() -> mDCR{
        if (dcr != nil){
            return dcr!;
        }
        
        dcr = mDCR();
        
        return dcr!;
    }
    
    
    
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        topWindow?.rootViewController = CustomUIViewController()
        topWindow?.windowLevel = UIWindowLevelAlert + 1
        customVariablesAndMethods = Custom_Variables_And_Method.getInstance()

       
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            //UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        
        application.registerForRemoteNotifications()
        
        
        //UINavigationBar.appearance().barStyle = .blackOpaque
        
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self,
//                                       selector: #selector(AppDelegate.sayHello),
//                                       name: .dataDownloadCompleted,
//                                       object: nil)
//
//        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
//        if statusBar.responds(to: #selector(setter: UIView.backgroundColor)){
//            statusBar.backgroundColor = AppColorClass.colorPrimaryDark
//        }
        
        var statusBarView: UIView?

        if #available(iOS 13.0, *) {
            let tag = 987654321
            if let statusBar = UIApplication.shared.keyWindow?.viewWithTag(tag) {
                statusBarView = statusBar
            } else {
                let statusBar = UIView(frame: UIApplication.shared.statusBarFrame)
                statusBar.tag = tag
                UIApplication.shared.keyWindow?.addSubview(statusBar)
                statusBarView = statusBar
            }
        } else {
            statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
        }
         statusBarView?.backgroundColor = AppColorClass.colorPrimaryDark
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        getUser()
        return true
    }
    
    func connectToFCM(){
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)
    }
    
    
     func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //print(userInfo)
        
        print("Received data message: \(userInfo)")
        var msgBody  = userInfo["body"] as! String
        msgBody = "{\"body\" :" + msgBody + "}"
        
        _ =  MyFirebaseMessagingService(msg: msgBody)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        InstanceID.instanceID().setAPNSToken(deviceToken, type:InstanceIDAPNSTokenType.sandbox)
//        InstanceID.instanceID().setAPNSToken(deviceToken, type:InstanceIDAPNSTokenType.prod)
        print("APNs token retrieved: \(deviceToken)")
        
//        InstanceID.instanceID().setAPNSToken(
//                deviceToken as Data,
//                type:.unknown)
        
         Messaging.messaging().apnsToken = deviceToken
    }
    
   
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
//        application.registerForRemoteNotifications()
        
        var bgTask = 0
            let app = UIApplication.shared
            bgTask = app.beginBackgroundTask(expirationHandler: {() -> Void in
                app.endBackgroundTask(bgTask)
        })
        
        Messaging.messaging().shouldEstablishDirectChannel = false
//        connectToFCM()
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
         backgroundSessionCompletionHandler = completionHandler
        print("handleEventsForBackgroundURLSession")
    }
    

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
         connectToFCM()
//      Messaging.messaging().shouldEstablishDirectChannel = true
        application.applicationIconBadgeNumber = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
         // Messaging.messaging().shouldEstablishDirectChannel = true
        connectToFCM()
        print("im in active state")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


   
   
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "CBO_Mobile_Reporting")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        print(userInfo)
//        UIApplication.shared.applicationIconBadgeNumber += 1
//        completionHandler([.alert , .badge, .sound])
//    }
//
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        print(userInfo)
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//        print(userInfo)
//    }
//
//}
// [END ios_10_message_handling]



//var applicationStateString: String {
//    if UIApplication.shared.applicationState == .active {
//        return "active"
//    } else if UIApplication.shared.applicationState == .background {
//        return "background"
//    }else {
//        return "inactive"
//    }
//}
//
//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//    // iOS10+, called when presenting notification in foreground
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) willPresentNotification: \(userInfo)")
//        //TODO: Handle foreground notification
//        completionHandler([.alert])
//    }
//
//    // iOS10+, called when received response (default open, dismiss or custom action) for a notification
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        NSLog("[UserNotificationCenter] applicationState: \(applicationStateString) didReceiveResponse: \(userInfo)")
//        //TODO: Handle background notification
//        completionHandler()
//    }
//}
extension AppDelegate : MessagingDelegate {
    
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        customVariablesAndMethods.setDataInTo_FMCG_PREFRENCE( key: "GCMToken", value: fcmToken)
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        var msgBody  = remoteMessage.appData["body"] as! String
        msgBody = "{\"body\" :" + msgBody + "}"

       _ =  MyFirebaseMessagingService(msg: msgBody)

    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        //        let newToken = InstanceID.instanceID().token()
        //        connectToFCM()
        customVariablesAndMethods.setDataInTo_FMCG_PREFRENCE( key: "GCMToken", value: fcmToken)
    }

}



extension Notification.Name {
    static let dataDownloadCompleted = Notification.Name(
        rawValue: "dataDownloadCompleted")
}



