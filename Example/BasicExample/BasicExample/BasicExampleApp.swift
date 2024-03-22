//
//  BasicExampleApp.swift
//  BasicExample
//
//  Created by Bendnaiba on 3/20/23.
//

import SwiftUI

@main
struct BasicExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
