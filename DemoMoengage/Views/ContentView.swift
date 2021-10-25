//
//  ContentView.swift
//  DemoMoengage
//
//  Created by Tahreem on 06/10/21.
//

import SwiftUI
import MoEngage

struct ContentView: View {
    
    
    @EnvironmentObject var settings: UserSettings
    
    
    var body: some View {
        
        if settings.loggedIn {
            TabbedView()
        }else{
            if UserDefaults.standard.bool(forKey: "loggedIn") == true {
                TabbedView()
            }else{
                LoginView()
            }
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
