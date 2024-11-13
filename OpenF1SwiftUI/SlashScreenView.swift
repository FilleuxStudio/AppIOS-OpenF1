//
//  SlashScreenView.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import SwiftUI

struct SlashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive{
            ContentView()
        }else{
            ZStack{
                    Image("HDWallpaper")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
        }
    }
}

struct SlashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SlashScreenView()
    }
}
