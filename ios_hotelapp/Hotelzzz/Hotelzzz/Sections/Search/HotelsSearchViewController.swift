//
//  HotelsSearchViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import SnapKit

class HotelsSearchViewController: UIViewController {

    /// Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Setup UI
        setupUI()
    }
    
    private func setupUI() {
        
        /// Background color
        view.backgroundColor = UIColor.white
        
        /// Title
        setTitle("Search Hotels")
    }
}
