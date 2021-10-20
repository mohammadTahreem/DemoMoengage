//
//  TabbedView.swift
//  DemoMoengage
//
//  Created by Tahreem on 13/10/21.
//

import SwiftUI

struct TabbedView: View {
    var body: some View {
        TabView {
            AllItemsView()
                .tabItem {
                    Text("All Items")
                }
            ProfileView()
                .tabItem {
                    Text("Profile")
                }
        }
        
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
