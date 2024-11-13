//
//  Session.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

class Session: Codable {
    let circuitKey: Int
    let circuitShortName: String
    let countryCode: String
    let countryKey: Int
    let countryName: String
    let dateEnd: Date
    let dateStart: Date
    let gmtOffset: String
    let location: String
    let meetingKey: Int
    let sessionKey: Int
    let sessionName: String
    let sessionType: String
    let year: Int
    
    enum CodingKeys: String, CodingKey {
        case circuitKey = "circuit_key"
        case circuitShortName = "circuit_short_name"
        case countryCode = "country_code"
        case countryKey = "country_key"
        case countryName = "country_name"
        case dateEnd = "date_end"
        case dateStart = "date_start"
        case gmtOffset = "gmt_offset"
        case location
        case meetingKey = "meeting_key"
        case sessionKey = "session_key"
        case sessionName = "session_name"
        case sessionType = "session_type"
        case year
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        circuitKey = try container.decode(Int.self, forKey: .circuitKey)
        circuitShortName = try container.decode(String.self, forKey: .circuitShortName)
        countryCode = try container.decode(String.self, forKey: .countryCode)
        countryKey = try container.decode(Int.self, forKey: .countryKey)
        countryName = try container.decode(String.self, forKey: .countryName)
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        let dateEndString = try container.decode(String.self, forKey: .dateEnd)
        dateEnd = dateFormatter.date(from: dateEndString) ?? Date()
        
        let dateStartString = try container.decode(String.self, forKey: .dateStart)
        dateStart = dateFormatter.date(from: dateStartString) ?? Date()
        
        gmtOffset = try container.decode(String.self, forKey: .gmtOffset)
        location = try container.decode(String.self, forKey: .location)
        meetingKey = try container.decode(Int.self, forKey: .meetingKey)
        sessionKey = try container.decode(Int.self, forKey: .sessionKey)
        sessionName = try container.decode(String.self, forKey: .sessionName)
        sessionType = try container.decode(String.self, forKey: .sessionType)
        year = try container.decode(Int.self, forKey: .year)
    }
}
