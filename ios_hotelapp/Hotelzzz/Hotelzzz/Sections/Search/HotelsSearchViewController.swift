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

    /// Location search view
    lazy var placeSearchView: PlaceSearchView = {
       
        let placeSearchView = PlaceSearchView(state: .inputDisabled)
        return placeSearchView
    }()
    
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
        
        /// Place search view
        view.addSubview(placeSearchView)
        
        /// Setup constraints
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        
        /// Place search setup
        placeSearchView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(65)
            maker.width.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}
