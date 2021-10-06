//
//  ContentView.swift
//  DemoMoengage
//
//  Created by Tahreem on 06/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var isSheet = false
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onTapGesture {
                isSheet = true
            }
            .sheet(isPresented: $isSheet) {
                Text("Sheet")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
