//
//  ProfileView.swift
//  DemoMoengage
//
//  Created by Tahreem on 11/10/21.
//

import SwiftUI
import MoEngage

struct ProfileView: View {
    
    @State var userEmailChange = ""
    @State var userName = ""
    @State var userlastName = ""
    @State var userFirstName = ""
    @State var mobileNumber = ""
    @State var showAlert = false
    var body: some View {
        VStack{
        TextField("User email change", text: $userEmailChange)
                .alert(isPresented: $showAlert, content:{
                        Alert(title: Text("Add new email"), dismissButton: .cancel())
                })
                .padding()
                .background(Color.white)
                .shadow(radius: 10)
            Button("Change email"){
                if !userEmailChange.isEmpty{
                    MoEngage.sharedInstance().setAlias(userEmailChange)
                }else{
                    showAlert = true
                }
            }
            
            TextField("User Name", text: $userName)
                .padding()
                .background(Color.white)
                .shadow(radius: 10)
            TextField("User last name", text: $userlastName)
                .padding()
                .background(Color.white)
                .shadow(radius: 10)
            TextField("User first name", text: $userFirstName)
                .padding()
                .background(Color.white)
                .shadow(radius: 10)
            TextField("User mobile name", text: $mobileNumber)
                .padding()
                .background(Color.white)
                .shadow(radius: 10)
            
            Button("Update details"){
                MoEngage.sharedInstance().setUserName(userName)
                MoEngage.sharedInstance().setUserLastName(userlastName)
                MoEngage.sharedInstance().setUserFirstName(userFirstName)
                MoEngage.sharedInstance().setUserMobileNo(mobileNumber)
            }
            
        }
        .padding()
        .onDisappear {
            MoEngage.sharedInstance().resetUser()
        }
        .navigationTitle(Text("Profile"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    /*
     MoEngage.sharedInstance().setUserName(userName)
     MoEngage.sharedInstance().setUserLastName(userLastname)
     MoEngage.sharedInstance().setUserFirstName(userFirstName)
     MoEngage.sharedInstance().setUserEmailID(userEmailID)
     MoEngage.sharedInstance().setUserMobileNo(userPhoneNo)
     MoEngage.sharedInstance().setUserGender(MALE) //Use UserGender enumerator for this
     MoEngage.sharedInstance().setUserDateOfBirth(userBirthdate)//userBirthdate should be a Date instance
     MoEngage.sharedInstance().setUserLocationLatitude(userLocationLat, andLongitude: userLocationLng)
     */
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
