//
//  TabbedView.swift
//  DemoMoengage
//
//  Created by Tahreem on 13/10/21.
//

import SwiftUI
import MoEngage
import MOGeofence

struct TabbedView: View {
    
    var body: some View {
        TabView {
            AllItemsView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.dash")
                        Text("All Items")
                    }
                }
            ProfileView()
                .tabItem {
                    VStack{
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                }
        }
        .toolbar {
            Button("Notifications"){
                //do something
            }
        }
        .onAppear {
            MOGeofenceHandler.sharedInstance()?.startGeofenceMonitoring()
            
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
