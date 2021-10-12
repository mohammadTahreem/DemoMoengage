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

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
                //TODO: Add your MoEngage App ID
            let yourMoEAppID = "F6NH0Z5JWO8VC1CB4HNLA6AS"
            var sdkConfig = MOSDKConfig.init(appID: yourMoEAppID)
            
                // Separate initialization methods for Dev and Prod initializations
            #if DEBUG
                MoEngage.sharedInstance().initializeTest(with: sdkConfig, andLaunchOptions: launchOptions)
            #else
                MoEngage.sharedInstance().initializeLive(with: sdkConfig, andLaunchOptions: launchOptions)
            #endif
        MoEngage.sharedInstance().appStatus(INSTALL)
        MoEngage.enableSDKLogs(true)
      //Rest of the implementation of method
      //-------
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

    //MARK:- Methods Deprecated from iOS9

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        MoEngage.sharedInstance().processURL(url)
        //rest of the implementation
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        MoEngage.sharedInstance().processURL(url)
        //rest of the implementation
        return true
    }
    
}
