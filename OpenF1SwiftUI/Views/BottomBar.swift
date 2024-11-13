//
//  BottomBar.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation
import SwiftUI

struct BottomBar: View{
    var currentView: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View{
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button("Driver"){
                    presentationMode.wrappedValue.dismiss()
                }.padding().background(currentView == "Driver" ? Color.white : Color.clear).foregroundColor(currentView == "Driver" ? .black : .white).cornerRadius(10)
                Spacer()
                NavigationLink(destination: SessionsView()){
                    Text("Session")
                        .padding()
                        .background(currentView == "Sessions" ? Color.white : Color.clear).foregroundColor(currentView == "Sessions" ? .black : .white).cornerRadius(10)
                }
                Spacer()
                NavigationLink(destination: TeamRadioView()){
                    Text("Team Radio")
                        .padding()
                        .background(currentView == "TeamRadio" ? Color.white : Color.clear).foregroundColor(currentView == "TeamRadio" ? .black : .white).cornerRadius(10)
                }
                Spacer()
            }
        }
        .padding().background(Color.black).foregroundColor(.white).frame(height: 60)
    }

}
