//
//  CarDataView.swift
//  OpenF1SwiftUI
//
//  Created by dimitri on 16/10/2024.
//

import Foundation
import SwiftUI

struct CarDataView: View {
    var driver: Driver
    let sessionKey: Int
    @StateObject private var viewModel = CarDataViewModel()

    var body: some View {
        VStack {
            Text("\(driver.fullName ?? "") - Car Data")
                .font(.title)
                .padding()

            if viewModel.isLoading {
                ProgressView("Loading car data...")
            } else if let error = viewModel.error {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            } else if viewModel.carData.isEmpty {
                Text("No car data available for this driver in this session.")
            } else {
                List(viewModel.carData) { data in
                    VStack(alignment: .leading) {
                        Text("Speed: \(data.speed) km/h")
                        Text("RPM: \(data.rpm)")
                        Text("Gear: \(data.nGear)")
                        Text("DRS: \(data.drs)")
                        Text("Throttle: \(data.throttle)%")
                        Text("Brake: \(data.brake)%")
                    }
                }
            }
        }
        .onAppear {
            print("CarDataView appeared for driver \(driver.driverNumber ?? 1) in session \(sessionKey)")
            viewModel.fetchCarData(driverNumber: driver.driverNumber ?? 1, sessionKey: sessionKey)
        }
    }
}


