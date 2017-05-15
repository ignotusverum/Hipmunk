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
        navigationVC.navigationBar.barTintColor = UIColor.defaultColor
        
        /// Handle transition
        RouteHandler.transitionToController(navigationVC) {
            completed([searchVC])
        }
    }
}
