//
//  AppDelegate.swift
//  Roam
//
//  Created by Joshua Johnson on 3/11/25.
//

import GooglePlaces

// https://developer.apple.com/documentation/uikit/uiapplicationdelegate/application(_:didfinishlaunchingwithoptions:)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSPlacesClient.provideAPIKey("AIzaSyC3jlrYdQX610LLqcvmNoVZxMU1-8BzZzU")
        print("AppDelegate's didFinishLaunchingWithOptions is running")
        return true
    }
}
    