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
            ZStack{
                Color("moBlue")
                    .ignoresSafeArea()
            VStack{
                
                Image("moLogo")
                    .resizable()
                    .scaledToFit()
                
                Button(action: {
                    isSheet = true
                    let currentConfig = MoEngage.sharedInstance().getDefaultSDKConfiguration()
                    currentConfig?.analyticsDisablePeriodicFlush = true
                    MoEngage.sharedInstance().update(currentConfig!)
                }, label: {
                    Text("Click to flush the analytics")
                        .foregroundColor(.white)
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
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                    
                    NavigationLink(destination: TabbedView(), isActive: $loginSuccess) {
                        Button {
                            if !userEmail.isEmpty{
                                MoEngage.sharedInstance().setUserUniqueID(userEmail)
                                loginSuccess = true
                            }else{
                                showAlert = true
                            }
                        } label: {
                            HStack{
                                Spacer()
                                Text("Login")
                                    .foregroundColor(.white)
                                Spacer()
                            }.padding()
                                .background(Color.blue)
                                .cornerRadius(10)
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
        .onAppear {
            MoEngage.sharedInstance().resetUser()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
