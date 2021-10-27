//
//  TabbedView.swift
//  DemoMoengage
//
//  Created by Tahreem on 13/10/21.
//

import SwiftUI
import MoEngage
import MOGeofence
import MOInApp

struct TabbedView: View {
    
    @State var openInbox = false
    
    var body: some View {
        NavigationView{
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
            .toolbar{
                LogoutView(openInbox: $openInbox, count: MOInbox.getUnreadNotifictionCount())
            }
            .navigationTitle("All items")
            .onAppear {
                
                MOInApp.sharedInstance().show()
                MOGeofenceHandler.sharedInstance()?.startGeofenceMonitoring()
                MOInbox.getUnreadNotifictionCount()
                
                func locManager(_ locationManager: CLLocationManager!, didEnter region: CLRegion!) {
                    print("GeoFence Entered")
                }
                func locManager(_ locationManager: CLLocationManager!, didExitRegion region: CLRegion!) {
                    print("GeoFence Exit")
                }
                MOInApp.sharedInstance().setCurrentInAppContexts(["Home","CategoriesScreen"])

                MOInApp.sharedInstance().showNudge(at: NudgePositionTop)
            }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
