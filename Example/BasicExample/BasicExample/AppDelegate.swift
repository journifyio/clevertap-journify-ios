//
//  AppDelegate.swift
//  IOSApp
//
//  Created by bendnaiba on 1/9/23.
//

import UIKit
import Journify
import CleverTapSDK
import CleverTapDestination

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        let configuration = Configuration(writeKey: "wk_2XbifnJkpoeglGtcwODv9Yw8aGy")
            .trackApplicationLifecycleEvents(true)
            .flushInterval(10)
        Journify.setup(with: configuration)
        let cleverTapDestination = CleverTapDestination(accountID: "TEST-58K-8RK-7W7Z", token: "TEST-32b-3b5", region: "mec1")
        Journify.shared().add(plugin: cleverTapDestination)

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
        Journify.shared().registeredForRemoteNotifications(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("Executed Analytics didReceiveRemoteNotification")
        Journify.shared().receivedRemoteNotification(userInfo: userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Executed Analytics didReceiveRemoteNotification")
        Journify.shared().receivedRemoteNotification(userInfo: userInfo)
    }


}

