//
//  TeamRadioView.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//
import SwiftUI
import AVKit

struct TeamRadioView: View {
    @State private var date = "2024-02-29"
       @State private var driverNumber = "4"
       @StateObject private var viewModel = TeamRadioViewModel()
       @State private var audioPlayer: AVPlayer?
    
    var body: some View {
        VStack {
           TopBar()
            
            HStack {
                TextField("Date (YYYY-MM-DD)", text: $date)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .keyboardType(.numberPad)
                           .onChange(of: date) { newValue in
                               date = formatDateString(newValue)
                           }
                            
                            TextField("Driver Number", text: $driverNumber)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        .padding()
            
            Button("Valider") {
                viewModel.fetchTeamRadio(date: date, driverNumber: Int(driverNumber) ?? 11)
            }
            .padding()
            
            List(viewModel.teamRadios) { radio in
                           TeamRadioRow(radio: radio, audioPlayer: $audioPlayer)
                       }
            
            Spacer()
            BottomBar(currentView: "TeamRadio")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .environment(\.navigationTitle, "Team Radio")
    }
    private func formatDateString(_ input: String) -> String {
            let numbers = input.filter { $0.isNumber }
            var formatted = ""
            
            for (index, number) in numbers.enumerated() {
                if index == 4 || index == 6 {
                    formatted += "-"
                }
                formatted += String(number)
                if formatted.count == 10 {
                    break
                }
            }
            
            return formatted
        }
}

struct TeamRadioRow: View {
    let radio: TeamRadio
    @Binding var audioPlayer: AVPlayer?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Driver 🏎#\(radio.driverNumber)")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text(formatDate(radio.date))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Button(action: {
                playAudio(url: radio.recordingURL)
            }) {
                HStack {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.blue)
                    Text("Play Audio")
                        .foregroundColor(.blue)
                }
            }
            
            Divider()
            
            HStack {
                Text("Session ID: \(String(radio.sessionKey))")
                Spacer()
                Text("Meeting ID: \(String(radio.meetingKey))")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        if let date = formatter.date(from: dateString) {
            formatter.dateFormat = "MMM d, yyyy HH:mm:ss"
            return formatter.string(from: date)
        }
        return dateString
    }
    
    private func playAudio(url: String) {
        guard let url = URL(string: url) else { return }
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
}
