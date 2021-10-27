//
//  InboxView.swift
//  DemoMoengage
//
//  Created by Tahreem on 25/10/21.
//

import SwiftUI
import MOMessaging
import MOMessaging

struct InboxView: View {
    @State var inboxMessages : [MOInboxModel] = []
    @State var unreadCount : Int?
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView{
                    ForEach(inboxMessages, id: \.self){ message in
                        HStack{
                            Spacer()
                            
                            Text(message.notificationBody!)
                                .onTapGesture {
                                    MOInbox .markNotificationClicked(withCampaignID: message.campaignID)
                                    unreadCount = MOInbox.getUnreadNotifictionCount()
                                }
                            Spacer()
                        }
                        .font(.body)
                        .foregroundColor(.blue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                    }
                }
                Spacer()
            }
            .navigationBarTitle("Inbox", displayMode: .inline)
            .toolbar(content: {
                HStack{
                    ZStack{
                        
                        Image(systemName: "bell")
                            .imageScale(.large)
                            .padding()
                            .foregroundColor(.blue)
                        Text("\(unreadCount ?? 0)")
                            .foregroundColor(Color.red)
                            .offset(x: 15, y: 0)
                    }
                    Button {
                        MOInbox.removeMessages()
                        inboxMessages.removeAll()
                    } label: {
                        Image(systemName: "xmark.bin")
                    }
                }
            })
        }
        .onAppear {
            MOInbox.getMessagesWithCompletionBlock { (messages) in
                if let messages = messages{
                    self.inboxMessages = messages
                    print(inboxMessages)
                }
            }
            unreadCount = MOInbox.getUnreadNotifictionCount()
            print(unreadCount!)
        }
        .onDisappear {
            inboxMessages.removeAll()
        }
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView()
    }
}
