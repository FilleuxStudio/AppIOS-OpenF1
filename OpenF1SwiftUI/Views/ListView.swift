//
//  ListView.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import SwiftUI

struct ListView: View {
    @State private var session: Int? = nil
    @State private var isLoadingData = true
    @State private var showingCarData = false
    @State private var selectedDriver: Driver?
    @StateObject private var driversViewModel = F1ViewModel()
    @StateObject private var sessionViewModel = SessionsViewModel()
    //   let drivers: [Driver]
    
    var body: some View {
        //        HStack {
        //            TextField("Session", text: $session)
        //                .textFieldStyle(RoundedBorderTextFieldStyle())
        //                .keyboardType(.numberPad)
        //        }
        //        .padding()
        //
        //        Button("Valider") {
        //            driversViewModel.fetchDriver(session: session)
        //        }
        //        .padding()
        //
        ////        List{
        ////            ForEach(Array(drivers.enumerated()), id: \.offset) {
        ////                index, driver in DriverRow(driver: driver)
        ////            }
        ////        }
        //
        //        List(driversViewModel.drivers, id: \.driverNumber) { driver in
        //            DriverRow(driver: driver)
        //        }
        
        /*VStack {
         HStack {
         Picker("Session", selection: $session) {
         Text("Sélectionnez une session").tag(nil as Int?)
         ForEach(sessionViewModel.sessions, id: \.sessionKey) { session in
         Text("\(session.sessionName) - \(session.circuitShortName)")
         .tag(session.sessionKey as Int?)
         }
         }
         
         .pickerStyle(MenuPickerStyle())
         .frame(maxWidth: .infinity)
         .onChange(of: session) { newValue in
         if let selectedSession = newValue {
         print("Session sélectionnée : \(selectedSession)")
         session = newValue
         } else {
         print("Aucune session sélectionnée")
         }
         }
         
         Button("Valider") {
         if let sessionKey = session {
         driversViewModel.fetchDriver(session: String(sessionKey))
         }
         }
         
         }
         .padding()
         
         
         List(driversViewModel.drivers, id: \.driverNumber) { driver in
         DriverRow(driver: driver)
         .onTapGesture {
         selectedDriver = driver
         showingCarData = true
         }
         }
         
         }
         .onAppear {
         sessionViewModel.fetchSessionsAll()
         if let firstSession = sessionViewModel.sessions.first {
         session = firstSession.sessionKey
         }
         isLoadingData = false
         }
         .onChange(of: session) { newValue in
         //            if let sessionKey = newValue {
         //                print("Session sélectionnée : \(sessionKey)")
         //                driversViewModel.fetchDriver(session: String(sessionKey))
         //            }
         if let sessionKey = newValue {
         print("Session sélectionnée : \(sessionKey)")
         isLoadingData = true  // Begin loading
         driversViewModel.fetchDriver(session: String(sessionKey))
         }
         }
         .onReceive(driversViewModel.$drivers) { _ in
         isLoadingData = false  // Set loading to false once drivers are fetched
         }
         .sheet(isPresented: $showingCarData) {
         if let sessionKey = session, let driver = selectedDriver {
         CarDataView(driver: driver, sessionKey: sessionKey)
         } else {
         Text("Unable to display car data. Please ensure a driver and session are selected.")
         }
         }
         }*/
        VStack {
            HStack {
                // Picker pour sélectionner la session
                Picker("Session", selection: $session) {
                    Text("Sélectionnez une session").tag(nil as Int?)
                    ForEach(sessionViewModel.sessions, id: \.sessionKey) { session in
                        Text("\(session.sessionName) - \(session.circuitShortName)")
                            .tag(session.sessionKey as Int?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                
                Button("Valider") {
                    // Appel de la fonction fetchDriver lorsque l'utilisateur appuie sur "Valider"
                    if let sessionKey = session {
                        isLoadingData = true  // Activer l'indicateur de chargement
                        driversViewModel.fetchDriver(session: String(sessionKey))
                        print("Fetching drivers for session: \(sessionKey)")
                    }
                }
            }
            .padding()
            
            // Affichage de l'indicateur de chargement pendant le chargement des données
            if isLoadingData {
                ProgressView("Chargement des pilotes...")
                    .padding()
            } else {
                // Liste des pilotes
                List(driversViewModel.drivers, id: \.driverNumber) { driver in
                    DriverRow(driver: driver)
                        .onTapGesture {
                            selectedDriver = driver
                            showingCarData = true
                        }
                }
            }
        }
        .onAppear {
            // Chargement initial des sessions au démarrage de la vue
            sessionViewModel.fetchSessionsAll()
        }
        .onChange(of: driversViewModel.drivers) { _ in
            // Lorsque les données des pilotes sont mises à jour, désactiver l'indicateur de chargement
            isLoadingData = false
        }
        .sheet(isPresented: Binding(
            get: { showingCarData && session != nil && selectedDriver != nil },
            set: { showingCarData = $0 }
        )) {
            if let sessionKey = session, let driver = selectedDriver {
                CarDataView(driver: driver, sessionKey: sessionKey)
            } else {
                Text("Impossible d'afficher les données du pilote. Sélectionnez une session et un pilote.")
            }
        }
    }
}

struct DriverRow: View {
    let driver: Driver
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: driver.headshotURL ?? "https://www.vecteezy.com/free-vector/no-photo")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(driver.broadcastName ?? "")
                    .font(.headline)
                Text("Number: \(driver.driverNumber ?? 0)")
                    .font(.subheadline)
                Text(driver.fullName ?? "")
                    .font(.subheadline)
                Text(driver.teamName ?? "")
                    .font(.subheadline)
                    .foregroundColor(Color(hex: driver.teamColour ?? "F000"))
            }
        }
        .padding(.vertical, 8)
    }
}

