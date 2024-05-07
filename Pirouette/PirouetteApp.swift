//
//  PirouetteApp.swift
//  Pirouette
//
//  Created by Ihor Dolhalov on 15.01.2024.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import UserNotifications
import FirebaseMessaging
import FirebaseFirestore


let screen = UIScreen.main.bounds // повертає розмір екрана поточного девайса


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
 FirebaseApp.configure()
      Messaging.messaging().delegate = self
      UNUserNotificationCenter.current().delegate = self
      
      UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
              if granted {
                  print("User notifications are allowed.")
              } else {
                  print("User notifications are not allowed.")
      } }
      application.registerForRemoteNotifications()
      application.applicationIconBadgeNumber = 0
            
          return true
  }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
    private func alertView(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
               alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               
               // Get the topmost visible view controller to present the alert
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let topViewController = windowScene?.windows.first(where: { $0.isKeyWindow })?.rootViewController {
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive method is called")
        let userInfo = response.notification.request.content.userInfo
        if let userInfo = userInfo as? [String: Any],
           let aps = userInfo["aps"] as? [String: Any],
           let alert = aps["alert"] as? [String: Any],
           let title = alert["title"] as? String,
           let message = alert["body"] as? String {
                           
            print("Title: \(title)")
            print("Body: \(message)")
           
            alertView(title: title, message: message)
        
         } else {
             print("Title and message could not be retrieved")
         }

    }
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("willPresent method is called")
        let content = notification.request.content
        let title = content.title
        let message = content.body
        
        alertView(title: title, message: message)
        

    }
    
    
}


extension AppDelegate: MessagingDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
        if let fcmToken = fcmToken  {
            deviceToken = fcmToken}
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

@main
struct PirouetteApp: App {
    
    // register app delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var scenePhase

    
    var body: some Scene {
        WindowGroup {
            
         if let user = AuthService.shared.currentUser {
                if user.uid == adminID || user.uid == admin2ID {
                    AdminOrderView()
                } else {
                    let viewModel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewModel)
               
                }
            } else {
                AuthView()
            }
        }
        .onChange(of: scenePhase) { newPhase in
                   if newPhase == .active {
                       // Clear badge count when app becomes active
                       UIApplication.shared.applicationIconBadgeNumber = 0
                   }
          
          //  EmptyView()
               }
     
          
        
    }
}

