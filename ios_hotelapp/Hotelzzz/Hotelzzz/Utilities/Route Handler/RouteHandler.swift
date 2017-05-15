//
//  RouteHandler.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Foundation

class RouteHandler {
    
    // Shared handler
    static let sharedHandler = RouteHandler()
    
    // MARK: - Initialization
    class func registerDeepLinkHanderWithUrl(_ deepLinkURL: String) { }
    
    // Root controller transition
    class func transitionToController(_ viewController: UIViewController, completed: @escaping () -> Void = {}) {
        
        let appDelegate = AppDelegate.appDelegate
        UIView.transition(with: appDelegate.window!, duration: 0.2, options: .transitionCrossDissolve, animations: { () -> Void in
            
            let oldState = UIView.areAnimationsEnabled
            
            UIView.setAnimationsEnabled(false)
            
            appDelegate.window!.rootViewController = viewController
            appDelegate.window!.makeKeyAndVisible()
            
            UIView.setAnimationsEnabled(oldState)
            
        }) { finished in
            
            completed()
        }
    }
    
    // MARK: - Transition logic
    class func presentNavViewController(_ viewController: UIViewController?) {
        
        guard let viewController = viewController else {
            return
        }
        
        transitionToController(viewController)
    }
    
    class func presentViewController(_ viewController: UIViewController?) {
        
        guard let viewController = viewController else {
            return
        }
        
        let appDelegate = AppDelegate.appDelegate
        appDelegate.window?.rootViewController?.presentVC(viewController)
    }
}
