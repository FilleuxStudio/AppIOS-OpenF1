//
//  F1ViewModel.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class F1ViewModel: ObservableObject{
    @Published var drivers: [Driver] = []
    private let apiService = APIService()
    
    func fetchData(){
        apiService.fetchDrivers(sessionKey: 9465) {
            [weak self] result in switch result{
            case .success(let drivers):
                DispatchQueue.main.async {
                    self?.drivers = drivers
                }
            case .failure(let error):
                print("Error fetching drivers : \(error)")
            }
        }
    }
}
