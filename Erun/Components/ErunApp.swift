//
//  ErunApp.swift
//  Erun
//
//  Created by Saad Qureshi on 27/04/2021.
//

import SwiftUI
import Firebase

@main
struct ErunApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
