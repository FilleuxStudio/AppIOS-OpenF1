//
//  Meeting.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class Meeting: Codable {
    let circuitKey: Int
    let circuitShortName: String
    let countryCode: String
    let countryKey: Int
    let countryName: String
    let dateStart: Date
    let gmtOffset: String
    let location: String
    let meetingKey: Int
    let meetingName: String
    let meetingOfficialName: String
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case circuitKey = "circuit_key"
        case circuitShortName = "circuit_short_name"
        case countryCode = "country_code"
        case countryKey = "country_key"
        case countryName = "country_name"
        case dateStart = "date_start"
        case gmtOffset = "gmt_offset"
        case location
        case meetingKey = "meeting_key"
        case meetingName = "meeting_name"
        case meetingOfficialName = "meeting_official_name"
        case year
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        circuitKey = try container.decode(Int.self, forKey: .circuitKey)
        circuitShortName = try container.decode(String.self, forKey: .circuitShortName)
        countryCode = try container.decode(String.self, forKey: .countryCode)
        countryKey = try container.decode(Int.self, forKey: .countryKey)
        countryName = try container.decode(String.self, forKey: .countryName)
        
        let dateString = try container.decode(String.self, forKey: .dateStart)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = formatter.date(from: dateString) {
            dateStart = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .dateStart, in: container, debugDescription: "Date string does not match expected format")
        }
        
        gmtOffset = try container.decode(String.self, forKey: .gmtOffset)
        location = try container.decode(String.self, forKey: .location)
        meetingKey = try container.decode(Int.self, forKey: .meetingKey)
        meetingName = try container.decode(String.self, forKey: .meetingName)
        meetingOfficialName = try container.decode(String.self, forKey: .meetingOfficialName)
        year = try container.decode(Int.self, forKey: .year)
    }
}
