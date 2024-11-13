//
//  CarDataViewModel.swift
//  OpenF1SwiftUI
//
//  Created by dimitri on 16/10/2024.
//

import Foundation

class CarDataViewModel: ObservableObject {
    @Published var carData: [CarData] = []
        @Published var isLoading = false
        @Published var error: String?
    private let apiService = APIService()

    func fetchCarData(driverNumber: Int, sessionKey: Int) {
        isLoading = true
        print("Fetching car data for driver \(driverNumber) in session \(sessionKey)")
        apiService.fetchCarData(driverNumber: driverNumber, sessionKey: sessionKey, minSpeed: 125) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let carData):
                    self?.carData = carData
                    print(carData)
                case .failure(let error):
                    print("Error fetching Car data: \(error)")
                    self?.error = error.localizedDescription
                }
            }
        }
    }
}
