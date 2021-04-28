//
//  Event.swift
//  Erun
//
//  Created by Saad Qureshi on 28/04/2021.
//

import Foundation

struct EventDetails: Codable, Identifiable {
    let id: String
    let organizerId: String
    let imageUrlString: String?
    let title: String
    let description: String
    let duration: Int
    let startTime: Date
    let creationTime: Date
    let participantCount: Int
    let isSpotlighted: Bool
    
    var eventParticipants: EventParticipants?
    var imageUrl: URL? {
        URL(string: imageUrlString ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, duration
        case organizerId = "organizer_id"
        case imageUrlString = "image_url"
        case startTime = "start_time"
        case creationTime = "creation_time"
        case participantCount = "participant_count"
        case isSpotlighted = "is_spotlighted"
    }
    
    struct EventParticipants: Codable {
        let participantsIds: [String]
        var users: [User]?
    }
}

struct EventState: Codable {
    let id: String
    let startTime: Date
    let duration: Int
    let warmupDuration: Int
    var leaderBoard: [LeaderBoardItem]
    
    enum CodingKeys: String, CodingKey {
        case id, duration
        case startTime = "start_time"
        case warmupDuration = "warmup_duration"
        case leaderBoard = "leader_board"
    }
    
    struct LeaderBoardItem: Codable {
        let userId: String
        let name: String
        var distance: Float
        var rank: Int
        var hasCompleted: Bool
    }
}

