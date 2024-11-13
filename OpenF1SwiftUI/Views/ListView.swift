//
//  ListView.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import SwiftUI

struct ListView: View {
    let drivers: [Driver]
    
    var body: some View {
        List{
            ForEach(Array(drivers.enumerated()), id: \.offset) {
                index, driver in DriverRow(driver: driver)
            }
        }
    }
}

struct DriverRow: View {
    let driver: Driver
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: driver.headshotURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(driver.broadcastName)
                    .font(.headline)
                Text("Number: \(driver.driverNumber)")
                    .font(.subheadline)
                Text(driver.fullName)
                    .font(.subheadline)
                Text(driver.teamName)
                    .font(.subheadline)
                    .foregroundColor(Color(hex: driver.teamColour))
            }
        }
        .padding(.vertical, 8)
    }
}
