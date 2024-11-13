//
//  CarData.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class CarData: Codable {
    let brake: Int
    let date: Date
    let driverNumber: Int
    let drs: Int
    let meetingKey: Int
    let nGear: Int
    let rpm: Int
    let sessionKey: Int
    let speed: Int
    let throttle: Int
    
    enum CodingKeys: String, CodingKey {
        case brake
        case date
        case driverNumber = "driver_number"
        case drs
        case meetingKey = "meeting_key"
        case nGear = "n_gear"
        case rpm
        case sessionKey = "session_key"
        case speed
        case throttle
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        brake = try container.decode(Int.self, forKey: .brake)
        
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let decodedDate = formatter.date(from: dateString) {
            date = decodedDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match expected format")
        }
        
        driverNumber = try container.decode(Int.self, forKey: .driverNumber)
        drs = try container.decode(Int.self, forKey: .drs)
        meetingKey = try container.decode(Int.self, forKey: .meetingKey)
        nGear = try container.decode(Int.self, forKey: .nGear)
        rpm = try container.decode(Int.self, forKey: .rpm)
        sessionKey = try container.decode(Int.self, forKey: .sessionKey)
        speed = try container.decode(Int.self, forKey: .speed)
        throttle = try container.decode(Int.self, forKey: .throttle)
    }
}
