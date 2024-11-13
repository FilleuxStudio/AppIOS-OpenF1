//
//  SessionViewModel.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class SessionsViewModel: ObservableObject {
    @Published var sessions: [Session] = []
    private let apiService = APIService()
    
    func fetchSessions(year: String, countryCode: String) {
        //guard let yearInt = Int(year) else { return }
        
        apiService.fetchSessions(year: Int(year) ?? 2024, country_code: countryCode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sessions):
                    self?.sessions = sessions
                case .failure(let error):
                    print("Error fetching sessions: \(error)")
                    // Handle error, maybe show an alert to the user
                }
            }
        }
    }
}

