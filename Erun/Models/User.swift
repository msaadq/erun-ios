//
//  User.swift
//  Erun
//
//  Created by Saad Qureshi on 05/05/2021.
//

import Foundation

struct User: Codable, Identifiable {
    let id: ID
    let name: String
    let imageUrl: URL?
    let dob: Date?
    let email: String?
    let erunScore: Double?
    
    var joinedEvents: [ID]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, dob, email
        case imageUrl = "image_url"
        case erunScore = "erun_score"
    }
}

