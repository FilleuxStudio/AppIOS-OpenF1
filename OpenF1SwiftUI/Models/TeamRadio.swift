//
//  TeamRadio.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class TeamRadio: Codable, Identifiable {    
    let id = UUID()  // Ajoutez ceci
    let date: String
    let driverNumber: Int
    let meetingKey: Int
    let recordingURL: String
    let sessionKey: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case driverNumber = "driver_number"
        case meetingKey = "meeting_key"
        case recordingURL = "recording_url"
        case sessionKey = "session_key"
    }
    
    /*required init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     
     let dateString = try container.decode(String.self, forKey: .date)
     let formatter = ISO8601DateFormatter()
     formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
     if let decodedDate = formatter.date(from: dateString) {
     date = decodedDate
     } else {
     throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match expected format")
     }
     
     driverNumber = try container.decode(Int.self, forKey: .driverNumber)
     meetingKey = try container.decode(Int.self, forKey: .meetingKey)
     recordingURL = try container.decode(URL.self, forKey: .recordingURL)
     sessionKey = try container.decode(Int.self, forKey: .sessionKey)
     }*/
}
