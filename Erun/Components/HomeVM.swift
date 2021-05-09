//
//  HomeVM.swift
//  Erun
//
//  Created by Saad Qureshi on 09/05/2021.
//

import Foundation
import Combine

class HomeVM: ObservableObject {
    private let eventsService: EventsServiceProtocol
    var cancellables = Set<AnyCancellable>()
    
    @Published var events = [Event]()
    
    init() {
        eventsService = EventsService()
    }
    
    func onAppear() {

    }
}
