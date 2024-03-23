//
//  AppDelegate.swift
//  SwiftExample
//
//  Created by Mohammed on 2/7/23.
//

import UIKit
import Journify
import CleverTapSDK
import CleverTapDestination

@main
class AppDelegate: NSObject, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
            (granted, error) in
            if (granted) {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Executed Analytics didRegisterForRemoteNotificationsWithDeviceToken")
        Journify.shared().registeredForRemoteNotifications(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Executed Analytics didReceiveRemoteNotification")
        Journify.shared().receivedRemoteNotification(userInfo: userInfo)
    }
}

