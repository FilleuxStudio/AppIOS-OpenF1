//
//  Driver.swift
//  OpenF1SwiftUI
//
//  Created by etudiant on 17/09/2024.
//

import Foundation

struct Driver: Codable, Hashable {
    let broadcastName: String
    let countryCode: String
    let driverNumber: Int
    let firstName: String
    let fullName: String
    let headshotURL: String
    let lastName: String
    let meetingKey: Int
    let nameAcronym: String
    let sessionKey: Int
    let teamColour: String
    let teamName: String
    
    enum CodingKeys: String, CodingKey {
        case broadcastName = "broadcast_name"
        case countryCode = "country_code"
        case driverNumber = "driver_number"
        case firstName = "first_name"
        case fullName = "full_name"
        case headshotURL = "headshot_url"
        case lastName = "last_name"
        case meetingKey = "meeting_key"
        case nameAcronym = "name_acronym"
        case sessionKey = "session_key"
        case teamColour = "team_colour"
        case teamName = "team_name"
    }
}
