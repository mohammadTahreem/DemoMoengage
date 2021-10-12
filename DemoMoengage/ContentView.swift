//
//  ContentView.swift
//  DemoMoengage
//
//  Created by Tahreem on 06/10/21.
//

import SwiftUI
import MoEngage

struct ContentView: View {
    
    @State var isSheet = false
    @State var userEmail = ""
    @State var loginSuccess = false
    @State var showAlert = false
    var body: some View {
        NavigationView{
            VStack{
                Button(action: {
                    isSheet = true
                    let currentConfig = MoEngage.sharedInstance().getDefaultSDKConfiguration()
                    currentConfig?.analyticsDisablePeriodicFlush = true
                    MoEngage.sharedInstance().update(currentConfig!)
                }, label: {
                    Text("Click to flush the analytics")
                })
                       
                    
                    .sheet(isPresented: $isSheet) {
                        Text("Analytics flushed")
                            .font(.title)
                            .shadow(radius: 10)
                    }
                    .alert( isPresented: $showAlert, content: {
                        Alert(title: Text("Email missing"), message: Text("Please add an email"), dismissButton: .cancel())
                    })
                    
                
                VStack{
                    TextField("email", text: $userEmail)
                        .padding()
                        .background(Color.white)
                        .shadow(radius: 10)
                    
                    
                    NavigationLink(destination: ProfileView(), isActive: $loginSuccess) {
                        Button("Login"){
                            if !userEmail.isEmpty{
                            loginSuccess = true
                            MoEngage.sharedInstance().setUserUniqueID(userEmail)
                            }else{
                                showAlert = true
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    userEmail = ""
                })
                .padding()
                .navigationBarTitle(Text("Reset User"))
                .navigationBarHidden(true)
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
