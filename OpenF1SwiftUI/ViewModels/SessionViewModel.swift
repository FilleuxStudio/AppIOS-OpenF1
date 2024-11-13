//
//  SessionViewModel.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

extension Date {
    static var currentYear: Int {
        return Calendar.current.component(.year, from: Date())
    }
}

class SessionsViewModel: ObservableObject {
    @Published var sessions: [Session] = []
        @Published var isLoadingSessions = true
        private let apiService = APIService()
    
    func fetchSessions(year: String, countryCode: String) {
        //guard let yearInt = Int(year) else { return }
        
        apiService.fetchSessions(year: Int(year) ?? Int(Date.currentYear), country_code: countryCode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sessions):
                    self?.sessions = sessions
                    self?.isLoadingSessions = false  // Update loading state
                case .failure(let error):
                    print("Error fetching sessions: \(error)")
                    self?.isLoadingSessions = false  // Update even on error
                }
            }
        }
    }
    
    func fetchSessionsAll() {
        apiService.fetchSessionsDateNow(year: Int(Date.currentYear)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let sessions):
                    self?.sessions = sessions
                    self?.isLoadingSessions = false  // Update loading state
                case .failure(let error):
                    print("Error fetching sessions: \(error)")
                    self?.isLoadingSessions = false  // Update even on error
                }
            }
        }
    }
}

