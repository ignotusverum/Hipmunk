//
//  HotelsSearchViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import SnapKit
import GooglePlaces

class HotelsSearchViewController: UIViewController {

    /// Places
    var placesClient: GMSPlacesClient
    
    /// Calendar view
    lazy var calendarInputView: CalendarContainerView = {
        
        let view = CalendarContainerView(state: .selectionDisabled)
        return view
    }()
    
    /// Location search view
    lazy var placeSearchView: PlaceSearchView = {
       
        let view = PlaceSearchView(state: .inputDisabled)
        return view
    }()
    
    /// Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Initialization
    init() {
        
        placesClient = GMSPlacesClient.shared()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Setup UI
        setupUI()
        
        /// Handle transition
        placeSearchView.viewTapped({

            /// Presend places controller
            let placesVC = LocationSearchViewController()
            
            placesVC.delegate = self
            self.pushVC(placesVC)
        })
        
        /// Handle calendar transition
        calendarInputView.viewTapped { 
            /// Calendar VC
            let calendarVC = CalendarViewController()
            
            self.pushVC(calendarVC)
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        /// Background color
        view.backgroundColor = UIColor.white
        
        /// Title
        setTitle("Search Hotels")
        
        /// Place search view
        view.addSubview(placeSearchView)
        
        /// Calendar view
        view.addSubview(calendarInputView)
        
        /// Setup constraints
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        
        /// Place search setup
        placeSearchView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(65)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        calendarInputView.snp.makeConstraints { maker in
            maker.top.equalTo(placeSearchView.snp.bottom)
            maker.height.equalTo(65)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: - Google places - handle current place
    func handleCurrentPlace() {
        
        /// Try to fetch current place
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            
            /// Safety check
            guard let place = placeLikelihoodList?.likelihoods.first?.place else {
                print("Pick Place error: \(error?.localizedDescription ?? "")")
                return
            }
            
            /// Set place name
            self.placeSearchView.textInput.text = place.name
        })
    }
}

extension HotelsSearchViewController: LocationSearchViewDelegate {
    func placeSearchDidChange(_ text: NSAttributedString?) {
        placeSearchView.textInput.attributedText = text
    }
}
