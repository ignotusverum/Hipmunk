//
//  AppDelegate.swift
//  Hotelzzz
//
//  Created by Steve Johnson on 3/21/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Shared
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /// Global navigation bar color
        UINavigationBar.appearance().barTintColor = UIColor(red: 63.0/255.0, green: 172.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        
        return true
    }
}
