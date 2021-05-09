//
//  Event.swift
//  Erun
//
//  Created by Saad Qureshi on 05/05/2021.
//

import Foundation

struct Event: Codable, Identifiable {
    let id: ID
    let title: String
    let duration: Int
    let subtitle: String
    let startTime: Date
    let participantCount: Int
    let minScore: Double
    let isSpotlighted: Bool
    let imageUrl: URL?
    let description: String?
    let creationTime: Date?
    let organizer: User?
    let warmupDuration: Int?
    let participants: [User]?
    
    var joinedByCurrentUser: Bool?
    var image: Data?
    var state: EventState?
    
    enum CodingKeys: String, CodingKey {
        case id, title, duration, subtitle, description, organizer, participants
        case startTime = "start_time"
        case participantCount = "participant_count"
        case minScore = "min_score"
        case isSpotlighted = "is_spotlighted"
        case imageUrl = "image_url"
        case creationTime = "creation_time"
        case warmupDuration = "warmup_duration"
    }
}

struct EventState: Codable {
    var isCompleted: Bool
    var leaderBoard: [LeaderBoardItem]
    
    enum CodingKeys: String, CodingKey {
        case isCompleted = "is_completed"
        case leaderBoard = "leader_board"
    }
}

struct LeaderBoardItem: Codable {
    let userId: ID
    let name: String
    var distance: Float
    var rank: Int
    var hasCompleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, distance, rank
        case userId = "user_id"
        case hasCompleted = "has_completed"
    }
}

