//
//  LogoutView.swift
//  DemoMoengage
//
//  Created by Tahreem on 25/10/21.
//

import SwiftUI
import MoEngage

struct LogoutView: View {
    @Binding var openInbox : Bool
    @EnvironmentObject var settings: UserSettings
    @State var count : Int
    var body: some View {
        HStack{
            
            Button {
                openInbox.toggle()
            } label: {
                ZStack{
                    
                Image(systemName: "bell")
                    .imageScale(.large)
                    .padding()
                    Text("\(count)")
                        .foregroundColor(Color.red)
                        .offset(x: 15, y: 0)
                }
            }.sheet(isPresented: $openInbox) {
                InboxView()
                    .onAppear {
                        count = MOInbox.getUnreadNotifictionCount()
                    }
                    .onDisappear {
                            count = MOInbox.getUnreadNotifictionCount()
                    }
            }
            
            Button {
                settings.loggedIn = false
                MoEngage.sharedInstance().resetUser()
            } label: {
                Image(systemName: "arrow.left.square")
                    .imageScale(.large)
                    .padding()
            }
            
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView(openInbox: .constant(false), count: 10)
    }
}
