//
//  User.swift
//  Erun
//
//  Created by Saad Qureshi on 28/04/2021.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let username: String
    let imageUrlString: String?
    let email: String
    
    var joinedEvents: JoinedEvents?
    var imageUrl: URL? {
        URL(string: imageUrlString ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case imageUrlString = "image_url"
    }
    
    struct JoinedEvents: Codable {
        let eventIds: [String]
        var events: [EventDetails]?
    }
}
