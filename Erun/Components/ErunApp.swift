//
//  ErunApp.swift
//  Erun
//
//  Created by Saad Qureshi on 04/05/2021.
//

import SwiftUI
import Firebase

@main
struct ErunApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Setting up Firebase")
        FirebaseApp.configure()
        
        return true
    }
}

