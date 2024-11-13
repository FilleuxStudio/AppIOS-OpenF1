//
//  TopBar.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//
import Foundation
import SwiftUI

struct TopBar: View{
    @Environment(\.navigationTitle) var title
    var body: some View
    {
        ZStack{
            Rectangle().fill(Color(hex: "#af0034")).edgesIgnoringSafeArea(.top)
            Text(title).font(.title).fontWeight(.bold).foregroundColor(.white)
            
        }.frame(height:80)
    }
}
