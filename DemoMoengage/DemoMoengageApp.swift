//
//  DemoMoengageApp.swift
//  DemoMoengage
//
//  Created by Tahreem on 06/10/21.
//

import SwiftUI
import MoEngage

@main
struct DemoMoengageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MOMessagingDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //TODO: Add your MoEngage App ID
        let yourMoEAppID = "F6NH0Z5JWO8VC1CB4HNLA6AS" // tahreem demo app
        var sdkConfig = MOSDKConfig.init(appID: yourMoEAppID)
        sdkConfig.appGroupID = "group.com.tahreem.DemoMoengageTestAppGroup"
        
        //For registering for remote notification
        let categoriesForiOS10 = self.getCategories()
        MoEngage.sharedInstance().registerForRemoteNotification(withCategories: categoriesForiOS10, withUserNotificationCenterDelegate: self)
        
        //MoEngage.sharedInstance().registerForRemoteNotification(withCategories: nil, withUserNotificationCenterDelegate: self)
        
        // Set the delegate
        MOMessaging.sharedInstance().messagingDelegate = self
        
        // Separate initialization methods for Dev and Prod initializations
#if DEBUG
        MoEngage.sharedInstance().initializeTest(with: sdkConfig, andLaunchOptions: launchOptions)
#else
        MoEngage.sharedInstance().initializeLive(with: sdkConfig, andLaunchOptions: launchOptions)
#endif
        MoEngage.sharedInstance().appStatus(INSTALL)
        MoEngage.enableSDKLogs(true)
        MoEngage.sharedInstance().trackLocale()
        
        return true
    }
    
    //MARK:- Deeplinks Processing
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        MoEngage.sharedInstance().processURL(url)
        //rest of the implementation
        return true
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb ,
           let incomingURL = userActivity.webpageURL{
            MoEngage.sharedInstance().processURL(incomingURL)
        }
        //rest of the implementation
        return true;
    }
    
    
    //Remote notification Registration callback methods
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //Call only if MoEngageAppDelegateProxyEnabled is NO
        MoEngage.sharedInstance().setPushToken(deviceToken)
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //Call only if MoEngageAppDelegateProxyEnabled is NO
        MoEngage.sharedInstance().didFailToRegisterForPush()
    }
    
    
    // MARK:- UserNotifications Framework callback method
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //Call only if MoEngageAppDelegateProxyEnabled is NO
        MoEngage.sharedInstance().userNotificationCenter(center, didReceive: response)
        
        //Custom Handling of notification if Any
        //        let pushDictionary = response.notification.request.content.userInfo
        //        print(response.notification.request.content.userInfo)
        //        print(pushDictionary)
        
        completionHandler();
    }
    
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //This is to only to display Alert and enable notification sound
        completionHandler([.sound, .badge, .banner, .list])
        print(notification.request.content.userInfo)
        
    }
    
    
    // MARK:- Remote notification received callback method for iOS versions below iOS10
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        //Call only if MoEngageAppDelegateProxyEnabled is NO
        MoEngage.sharedInstance().didReceieveNotificationinApplication(application, withInfo: userInfo)
        print(userInfo)
        
    }
    
    
    //MARK:- Notification Extension
    
    // Notification Clicked Callback
    func notificationClicked(withScreenName screenName: String?, andKVPairs kvPairs: [AnyHashable : Any]?) {
        if let screenName = screenName {
            print("Navigate to Screen:\(screenName)")
        }
        
        if let actionKVPairs = kvPairs {
            print("Selected Action KVPair:\(actionKVPairs)")
        }
    }
    
    // Notification Clicked Callback with Push Payload
    func notificationClicked(withScreenName screenName: String?, kvPairs: [AnyHashable : Any]?, andPushPayload userInfo: [AnyHashable : Any]) {
        
        print("Push Payload: \(userInfo)")
        
        if let screenName = screenName {
            print("Navigate to Screen:\(screenName)")
        }
        
        if let actionKVPairs = kvPairs {
            print("Selected Action KVPair:\(actionKVPairs)")
        }
    }
    
    //Example to define categories
    //This method gives categories for iOS version 10.0 and above
    @available(iOS 10.0, *)
    func getCategories() -> Set<UNNotificationCategory>{
        
        let acceptAction = UNNotificationAction.init(identifier: "ACCEPT_IDENTIFIER", title: "Accept", options: .authenticationRequired)
        let declineAction = UNNotificationAction.init(identifier: "DECLINE_IDENTIFIER", title: "Decline", options: .destructive)
        let maybeAction = UNNotificationAction.init(identifier: "MAYBE_IDENTIFIER", title: "May Be", options: .foreground)
        
        let inviteCategory = UNNotificationCategory.init(identifier: "INVITE_CATEGORY", actions: [acceptAction,declineAction,maybeAction], intentIdentifiers: [], options: .customDismissAction)
        let declineCategory = UNNotificationCategory.init(identifier: "INVITE_CATEGORY", actions: [declineAction], intentIdentifiers: [], options: .customDismissAction)
        let categoriesSet = Set.init([inviteCategory, declineCategory])
        
        return categoriesSet;
    }
}
