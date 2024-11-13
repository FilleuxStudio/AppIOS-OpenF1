//
//  SessionsView.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//
import SwiftUI

struct SessionsView: View {
    @State private var year = "2024"
    @State private var countryCode = "BEL"
    @StateObject private var viewModel = SessionsViewModel()
    
    var body: some View {
        VStack {
            TopBar()
            
            HStack {
                TextField("Year", text: $year)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                TextField("Country Code", text: $countryCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.uppercase)
            }
            .padding()
            
            Button("Valider") {
                viewModel.fetchSessions(year: year, countryCode: countryCode)
            }
            .padding()
            
            List(viewModel.sessions, id: \.sessionName) { session in
                SessionRow(session: session)
            }
            
            Spacer()
            BottomBar(currentView: "Sessions")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .environment(\.navigationTitle, "Sessions")
    }
}

struct SessionRow: View {
    let session: Session
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(session.sessionName)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text(session.sessionType)
                    .font(.subheadline)
                    .padding(5)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(5)
            }
            
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.red)
                Text(session.location)
                    .font(.subheadline)
            }
            
            HStack {
                Image(systemName: "calendar")
                    .foregroundColor(.green)
                Text("\(String(session.year))")
                    .font(.subheadline)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Session ID")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(String(session.sessionKey))")
                        .font(.subheadline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Meeting ID")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(String(session.meetingKey))")
                        .font(.subheadline)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
