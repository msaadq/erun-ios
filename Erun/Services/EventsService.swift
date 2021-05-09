//
//  EventsService.swift
//  Erun
//
//  Created by Saad Qureshi on 08/05/2021.
//

import Foundation
import Combine
import FirebaseDatabase

typealias ID = String

// MARK: Service Protocol
protocol EventsServiceProtocol {
    // MARK: - Events Information
    func observeSpotlightEvents() -> AnyPublisher<[Event], APIError>
    func observeAllEvents() -> AnyPublisher<[Event], APIError>
    func observeMyEvents(for userID: ID) -> AnyPublisher<[Event], APIError>
    func observeEventDetails(for eventId: ID) -> AnyPublisher<Event, APIError>
    func observeEventState(for eventId: ID) -> AnyPublisher<EventState, APIError>
    
    // MARK: - User Operations
    func updateMembership(of user: User, for eventId: ID, with joined: Bool) -> AnyPublisher<Void, APIError>
    func updateCurrentLeaderBoard(for eventId: ID, with leaderBoard: [LeaderBoardItem]) -> AnyPublisher<Void, APIError>
}

// MARK: Events Service
final class EventsService: EventsServiceProtocol {
    private let ref = Database.database().reference().child("mock")
    
    func observeSpotlightEvents() -> AnyPublisher<[Event], APIError> {
        Publishers.DatabasePublisher<[String: Event]>(childPath: "mock/spotlight_events")
            .compactMap { Array($0.values) }
            .eraseToAnyPublisher()
    }
    
    func observeAllEvents() -> AnyPublisher<[Event], APIError> {
        Publishers.DatabasePublisher<[String: Event]>(childPath: "mock/all_events")
            .compactMap { Array($0.values) }
            .eraseToAnyPublisher()
    }
    
    func observeMyEvents(for userID: ID) -> AnyPublisher<[Event], APIError> {
        Publishers.DatabasePublisher<[String: Bool]>(childPath: "mock/joined_events/\(userID)")
            .map { dict in
                dict.keys.filter { dict[$0]! }
            }
            .flatMap { eventIds -> AnyPublisher<[Event], APIError> in
                let publishers = eventIds
                    .map { Publishers.DatabasePublisher<Event>(childPath: "mock/all_events/\($0)") }
                
                return Publishers.MergeMany(publishers)
                    .collect(publishers.count)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func observeEventDetails(for eventId: ID) -> AnyPublisher<Event, APIError> {
        Publishers.DatabasePublisher<Event>(childPath: "mock/event_details/\(eventId)")
            .eraseToAnyPublisher()
    }
    
    func observeEventState(for eventId: ID) -> AnyPublisher<EventState, APIError> {
        Publishers.DatabasePublisher<EventState>(childPath: "event_states/\(eventId)")
            .eraseToAnyPublisher()
    }
    
    func updateMembership(of user: User, for eventId: ID, with joined: Bool) -> AnyPublisher<Void, APIError> {
        ref.child("joined_events/\(user.id)/\(eventId)").setValue(joined)
        ref.child("event_details/\(eventId)/participants/\(user.id)").setValue(user.toDictionary())
        
        return Just(()).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
    
    func updateCurrentLeaderBoard(for eventId: ID, with leaderBoard: [LeaderBoardItem]) -> AnyPublisher<Void, APIError> {
        ref.child("event_states/\(eventId)/leader_board").childByAutoId().setValue(leaderBoard)
        
        return Just(()).setFailureType(to: APIError.self).eraseToAnyPublisher()
    }
}


// MARK: Mock Service
final class MockEventsService: EventsServiceProtocol {
    func observeSpotlightEvents() -> AnyPublisher<[Event], APIError> {
        Just(MockDataGenerator.spotlight_events.values.map { $0 as! Event })
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func observeAllEvents() -> AnyPublisher<[Event], APIError> {
        Just(MockDataGenerator.all_events.values.map { $0 as! Event })
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func observeMyEvents(for userID: ID) -> AnyPublisher<[Event], APIError> {
        let eventIds: [String] = MockDataGenerator.joined_events[userID] as! [String]
        var events = [Event]()
        for eventId in eventIds {
            events.append(MockDataGenerator.all_events[eventId] as! Event)
        }
        
        return Just(events)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func observeEventDetails(for eventId: ID) -> AnyPublisher<Event, APIError> {
        Just(MockDataGenerator.event_details[eventId] as! Event)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func observeEventState(for eventId: ID) -> AnyPublisher<EventState, APIError> {
        Just(MockDataGenerator.event_states[eventId] as! EventState)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func updateMembership(of user: User, for eventId: ID, with joined: Bool) -> AnyPublisher<Void, APIError> {
        Just(())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func updateCurrentLeaderBoard(for eventId: ID, with leaderBoard: [LeaderBoardItem]) -> AnyPublisher<Void, APIError> {
        Just(())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
