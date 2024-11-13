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
            HStack {
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        Text("Driver")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    }
                }
                .background(currentView == "Driver" ? Color.white : Color.clear)
                .foregroundColor(currentView == "Driver" ? .black : .white)
                .cornerRadius(10)
                
                Spacer()
                
                NavigationLink(destination: SessionsView()) {
                    ZStack {
                        Text("Session")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    }
                }
                .background(currentView == "Sessions" ? Color.white : Color.clear)
                .foregroundColor(currentView == "Sessions" ? .black : .white)
                .cornerRadius(10)
                
                Spacer()
                
                NavigationLink(destination: TeamRadioView()) {
                    ZStack {
                        Text("Team Radio")
                            .multilineTextAlignment(.center) // Aligne le texte au centre (horizontale)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                    }
                }
                .background(currentView == "TeamRadio" ? Color.white : Color.clear)
                .foregroundColor(currentView == "TeamRadio" ? .black : .white)
                .cornerRadius(10)
                
                Spacer()
            }
        }
        .padding().background(Color.black).foregroundColor(.white).frame(height: 60)
    }
    
}
