//
//  SearchRouter.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Foundation

class SearchRouter {
    
    /// Initial transition
    class func initialTransition(completed: @escaping ([UIViewController])-> Void = {_ in }) {
        
        /// Create Search Controller
        let searchVC = HotelsSearchViewController()
        
        /// Navigation controller
        let navigationVC = UINavigationController(rootViewController: searchVC)
        navigationVC.navigationBar.isTranslucent = false
        navigationVC.navigationBar.barTintColor = UIColor(red: 63.0/255.0, green: 172.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        
        /// Handle transition
        RouteHandler.transitionToController(navigationVC) {
            completed([searchVC])
        }
    }
}
