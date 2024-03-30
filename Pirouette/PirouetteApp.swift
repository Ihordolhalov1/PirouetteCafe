//
//  PirouetteApp.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 15.01.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

let screen = UIScreen.main.bounds // повертає розмір екрана поточного девайса


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("FireBase is connected")
    return true
  }
}


@main
struct PirouetteApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            
            if let user = AuthService.shared.currentUser {
                if user.uid == adminID {
                    AdminOrderView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewModel) }
            } else {
                AuthView()
            }
        }
    }
    func setupQuickAction() {}
}

