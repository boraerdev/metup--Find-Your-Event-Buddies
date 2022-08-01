//
//  metapApp.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {

    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}


@main
struct metapApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        FirebaseApp.configure()
    }
    
    @StateObject var vm = AuthService()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.environmentObject(vm)
        }
    }
}
