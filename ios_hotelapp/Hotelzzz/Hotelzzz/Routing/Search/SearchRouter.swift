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
        navigationVC.navigationBar.tintColor = UIColor.white
        
        let backImage = #imageLiteral(resourceName: "BackArrow")
        
        navigationVC.navigationBar.backIndicatorImage = backImage
        navigationVC.navigationBar.backIndicatorTransitionMaskImage = backImage
        
        /*** If needed Assign Title Here ***/
        searchVC.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        /// Handle transition
        RouteHandler.transitionToController(navigationVC) {
            completed([searchVC])
        }
    }
}
