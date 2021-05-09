//
//  UserService.swift
//  Erun
//
//  Created by Saad Qureshi on 08/05/2021.
//

import Foundation
import Combine
import FirebaseAuth

enum UserState: CaseIterable {
    case new
    case existing
}

// MARK: Service Protocol
protocol UserServiceProtocol {
    func signIn(username: ID) -> AnyPublisher<UserState, APIError>
    func signUp(user: User) -> AnyPublisher<Void, APIError>
    func verifyUser(token: ID) -> AnyPublisher<User, APIError>
    func isUserLoggedIn() -> Bool
}

// MARK: Mock Service
final class MockUserService: UserServiceProtocol {
    func signIn(username: ID) -> AnyPublisher<UserState, APIError> {
        Just(UserState.allCases.randomElement() ?? .existing)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func signUp(user: User) -> AnyPublisher<Void, APIError> {
        Just(())
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func verifyUser(token: ID) -> AnyPublisher<User, APIError> {
        Just(MockDataGenerator.users["msaadq"] as! User)
            .setFailureType(to: APIError.self)
            .eraseToAnyPublisher()
    }
    
    func isUserLoggedIn() -> Bool {
        true
    }
}
