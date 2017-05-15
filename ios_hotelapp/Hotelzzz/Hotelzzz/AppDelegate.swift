//
//  AppDelegate.swift
//  Hotelzzz
//
//  Created by Steve Johnson on 3/21/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Shared
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /// Places
        GMSPlacesClient.provideAPIKey("AIzaSyCfS9kYz0mAyr7K7tiBu7YWvJUZjotXjLk")
        
        /// Window setup
        AppDelegate.appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        
        /// Initial Transition
        SearchRouter.initialTransition()
        
        return true
    }
}
