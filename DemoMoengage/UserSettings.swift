//
//  UserSettings.swift
//  DemoMoengage
//
//  Created by Tahreem on 25/10/21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var loggedIn : Bool {
        didSet {
            UserDefaults.standard.set(loggedIn, forKey: "loggedIn")
        }
    }
   
    
    
    init() {
        self.loggedIn = UserDefaults.standard.object(forKey: "username") as? Bool ?? false
    }
    
}
