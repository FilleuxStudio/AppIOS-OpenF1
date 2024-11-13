//
//  TeamRadioViewModel.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class TeamRadioViewModel: ObservableObject {
    @Published var teamRadios: [TeamRadio] = []
    private let apiService = APIService()
    
    func fetchTeamRadio(date: String, driverNumber: Int) {
        apiService.fetchTeamRadio(date: date, driverNumber: driverNumber) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let teamRadios):
                    self?.teamRadios = teamRadios  // Notez le 's' à la fin
                case .failure(let error):
                    print("Error fetching team radio: \(error)")
                    // Handle error, maybe show an alert to the user
                }
            }
        }
    }
}
