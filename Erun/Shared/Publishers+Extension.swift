//
//  Publishers+Extension.swift
//  Erun
//
//  Created by Saad Qureshi on 05/05/2021.
//

import Combine
import FirebaseAuth
import FirebaseDatabase

enum APIError: LocalizedError {
    case networkError(description: String)
    case serverError(description: String)
    case decodeError(description: String)
    case genericError(description: String)
}

// MARK: - Additional Publishers for Firebase Networking
extension Publishers {
    // MARK: - Auth Publisher
    struct AuthPublisher: Publisher {
        typealias Output = User?
        typealias Failure = Never
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, User? == S.Input {
            let authSubscription = Subscriptions.AuthSubscription(subscriber: subscriber)
            subscriber.receive(subscription: authSubscription)
        }
    }
    
    // MARK: - Event State Publisher
    struct DatabasePublisher<T: Codable>: Publisher {
        typealias Output = T
        typealias Failure = APIError
        
        private let childPath: String
        
        init(childPath: String) {
            self.childPath = childPath
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, APIError == S.Failure, T == S.Input {
            let databaseSubscription = Subscriptions.DatabaseSubscription(subscriber: subscriber, childPath: childPath)
            subscriber.receive(subscription: databaseSubscription)
        }
    }
}

// MARK: - Private Subscriptions to facilitate the Publishers
fileprivate extension Subscriptions {
    class AuthSubscription<S: Subscriber>: Subscription where S.Input == User?, S.Failure == Never {
        private var subscriber: S?
        private var handler: AuthStateDidChangeListenerHandle?
        
        init(subscriber: S) {
            self.subscriber = subscriber
            handler = Auth.auth().addStateDidChangeListener { auth, user in
                _ = subscriber.receive(nil)
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
    
    class DatabaseSubscription<S: Subscriber, T: Codable>: Subscription where S.Input == T, S.Failure == APIError {
        private var subscriber: S?
        private var handler: DatabaseHandle?
        
        init(subscriber: S, childPath: String) {
            self.subscriber = subscriber
            handler = Database.database().reference().child(childPath).observe(DataEventType.value) { (snapshot) in
                if let eventState = snapshot.value as? T {
                    _ = subscriber.receive(eventState)
                } else {
                    subscriber.receive(completion: .failure(.decodeError(description: "Invalid event state")))
                }
            }
        }
        
        func request(_ demand: Subscribers.Demand) {}
        func cancel() {
            subscriber = nil
            handler = nil
        }
    }
}

// MARK: - Example Usage
class DatabaseTest: ObservableObject {
    func getEventState(eventID: Int) -> AnyPublisher<EventState, APIError> {
        let eventStatePath = "event_state/\(eventID)"
        return Publishers.DatabasePublisher<EventState>(childPath: eventStatePath)
            .eraseToAnyPublisher()
    }
}
