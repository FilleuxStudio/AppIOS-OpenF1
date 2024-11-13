//
//  ContentView.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = F1ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TopBar()
                //                    ListView(drivers: viewModel.drivers)
                ListView()
                Spacer()
                BottomBar(currentView: "Driver")
            }
            .navigationBarHidden(true)
            .environment(\.navigationTitle, "F1 News")
        }
        .onAppear {
            viewModel.fetchDriver(session: "")
        }
    }
}
