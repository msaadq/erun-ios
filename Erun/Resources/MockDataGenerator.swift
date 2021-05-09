//
//  MockDataGenerator.swift
//  Erun
//
//  Created by Saad Qureshi on 09/05/2021.
//

import Foundation
import FirebaseDatabase

struct MockDataGenerator {
    static func updateMockDatabase() {
        let ref = Database.database().reference().child("mock")
        ref.setValue(MockDataGenerator.database)
    }
    
    static let database: [String: Any] = [
        "event_details": event_details,
        "all_events": all_events,
        "spotlight_events": spotlight_events,
        "users": users,
        "event_states": event_states,
        "joined_events": joined_events,
    ]
    
    static let event_details: [String: Any] = [
        "event_123":
        Event(id: "event_123", title: "Event 123", duration: 2700, subtitle: "For everyone", startTime: Calendar.current.date(byAdding: .day, value: 6, to: Date()) ?? Date(), participantCount: 3, minScore: 0, isSpotlighted: true, imageUrl: URL(string: "https://picsum.photos/200")!, description: "for few", creationTime: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(), organizer: nil, warmupDuration: 300, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary(),
        "event_456":
        Event(id: "event_456", title: "Event 456", duration: 2700, subtitle: "For few", startTime: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(), participantCount: 2, minScore: 1.2, isSpotlighted: false, imageUrl: URL(string: "https://picsum.photos/200")!, description: "for few", creationTime: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), organizer: nil, warmupDuration: 300, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary(),
        "event_789":
        Event(id: "event_789", title: "Event 789", duration: 1800, subtitle: "Exclusive", startTime: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(), participantCount: 1, minScore: 1, isSpotlighted: true, imageUrl: URL(string: "https://picsum.photos/200")!, description: "for few", creationTime: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(), organizer: nil, warmupDuration: 300, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary()
    ]

    static let all_events: [String: Any] = [
        "event_123":
            Event(id: "event_123", title: "Event 123", duration: 2700, subtitle: "For everyone", startTime: (Calendar.current.date(byAdding: .day, value: 6, to: Date()) ?? Date()), participantCount: 3, minScore: 0, isSpotlighted: true, imageUrl: URL(string: "https://picsum.photos/200")!, description: nil, creationTime: nil, organizer: nil, warmupDuration: nil, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary(),
        "event_456":
            Event(id: "event_456", title: "Event 456", duration: 2700, subtitle: "For few", startTime: Calendar.current.date(byAdding: .day, value: 5, to: Date()) ?? Date(), participantCount: 2, minScore: 1.2, isSpotlighted: false, imageUrl: URL(string: "https://picsum.photos/200")!, description: nil, creationTime: nil, organizer: nil, warmupDuration: nil, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary(),
        "event_789":
        Event(id: "event_789", title: "Event 789", duration: 1800, subtitle: "Exclusive", startTime: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(), participantCount: 1, minScore: 1, isSpotlighted: true, imageUrl: URL(string: "https://picsum.photos/200")!, description: nil, creationTime: nil, organizer: nil, warmupDuration: nil, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary()
    ]

    static let spotlight_events: [String: Any] = [
        "event_123":
        Event(id: "event_123", title: "Event 123", duration: 2700, subtitle: "For everyone", startTime: Calendar.current.date(byAdding: .day, value: 6, to: Date()) ?? Date(), participantCount: 3, minScore: 0, isSpotlighted: true, imageUrl: URL(string: "https://picsum.photos/200")!, description: nil, creationTime: nil, organizer: nil, warmupDuration: nil, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary(),
        "event_789":
        Event(id: "event_789", title: "Event 789", duration: 1800, subtitle: "Exclusive", startTime: Calendar.current.date(byAdding: .day, value: 4, to: Date()) ?? Date(), participantCount: 1, minScore: 1, isSpotlighted: true, imageUrl: URL(string: "https://picsum.photos/200")!, description: nil, creationTime: nil, organizer: nil, warmupDuration: nil, participants: nil, joinedByCurrentUser: nil, image: nil, state: nil).toDictionary()
    ]

    static let users: [String: Any] = [
        "msaadq":
            User(id: "msaadq", name: "Saad Qureshi", imageUrl: URL(string: "https://picsum.photos/200")!, dob: Date(), email: "msaadq94@gmail.com", erunScore: 0.0, joinedEvents: nil).toDictionary(),
        "faixan":
        User(id: "faixan", name: "Faizan Arshad", imageUrl: URL(string: "https://picsum.photos/200")!, dob: Date(), email: "faixan@gmail.com", erunScore: 0.5, joinedEvents: nil).toDictionary(),
        "muali":
        User(id: "muali", name: "Ali Muneeb", imageUrl: URL(string: "https://picsum.photos/200")!, dob: Date(), email: "muali@gmail.com", erunScore: 2.6, joinedEvents: nil).toDictionary(),
        "jared":
        User(id: "jared", name: "Jared Rogers", imageUrl: URL(string: "https://picsum.photos/200")!, dob: Date(), email: "jared@gmail.com", erunScore: 6.1, joinedEvents: nil).toDictionary(),
        "muda":
        User(id: "muda", name: "Mudassir Ahmed", imageUrl: URL(string: "https://picsum.photos/200")!, dob: Date(), email: "muda@gmail.com", erunScore: 4.1, joinedEvents: nil).toDictionary()
    ]

    static let event_states: [String: Any] = [
        "event_123":
            EventState(isCompleted: false, leaderBoard: []).toDictionary(),
        "event_456":
            EventState(isCompleted: false, leaderBoard: []).toDictionary(),
        "event_789":
            EventState(isCompleted: false, leaderBoard: []).toDictionary()
    ]

    static let joined_events = [
        "msaadq": ["event_123", "event_456"],
        "faixan": [],
        "muali": ["event_123"],
        "muda": [ "event_123", "event_789", "event_456"],
    ]
}

