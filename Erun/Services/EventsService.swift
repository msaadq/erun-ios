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
    func observeEventState(for eventID: ID) -> AnyPublisher<EventState, APIError>
    
    // MARK: - User Operations
    func updateMembership(for eventID: ID, with joined: Bool) -> AnyPublisher<Void, APIError>
    func updateCurrentLeaderBoard(with leaderBoard: [LeaderBoardItem]) -> AnyPublisher<Void, APIError>
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
        let eventIds: [String] = MockDataGenerator.joined_events[userID]!
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
    
    func observeEventState(for eventID: ID) -> AnyPublisher<EventState, APIError> {
        Just(MockDataGenerator.event_states[eventID] as! EventState)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func updateMembership(for eventID: ID, with joined: Bool) -> AnyPublisher<Void, APIError> {
        Just(())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func updateCurrentLeaderBoard(with leaderBoard: [LeaderBoardItem]) -> AnyPublisher<Void, APIError> {
        Just(())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
}
