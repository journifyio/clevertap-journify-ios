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
        
        //Enable debug mode
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        Journify.debugLogsEnabled = true
        
        //Setup Journify
        let configuration = Configuration(writeKey: "Your_Key")
            .trackApplicationLifecycleEvents(true)
            .flushInterval(10)
        Journify.setup(with: configuration)
        
        //Setup cleverTapDestination
        let cleverTapDestination = CleverTapDestination(accountID: "Your_Account_ID", token: "Your_Account_Token", region: "Your_Region")
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

