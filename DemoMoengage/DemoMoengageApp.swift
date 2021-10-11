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
}
