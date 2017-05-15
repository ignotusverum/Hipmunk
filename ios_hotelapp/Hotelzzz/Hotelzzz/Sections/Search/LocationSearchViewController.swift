//
//  LocationSearchViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import GooglePlaces

protocol LocationSearchViewDelegate {
    
    func placeSearchDidChange(_ text: String?)
}

class LocationSearchViewController: UIViewController {

    /// Delegate
    var delegate: LocationSearchViewDelegate?
    
    /// Location search view
    lazy var placeSearchView: PlaceSearchView = {
        
        let view = PlaceSearchView(state: .inputEnabled)
        
        return view
    }()
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Handle text input
        placeSearchView.textDidChange({ text in
            
            /// Passing text
            self.delegate?.placeSearchDidChange(text)
        })
        
        /// Setup UI
        setupUI()
        
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
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        /// Title
        setTitle("Select Location")
        
        /// Place search
        view.addSubview(placeSearchView)
    }
    
    // MARK: - Google places handle autocomplete
    func handleAutocomplete() {
        placeSearchView.textDidChange { text in
            /// Safety check
            guard let text = text else {
                return
            }
            
            /// Handle autocomplete
            GMSPlacesClient.shared().autocompleteQuery(text, bounds: nil, filter: nil, callback: { (prediction, error) in
                
                /// Safetcy check
                guard let prediction = prediction else {
                    print("Error")
                    print(error?.localizedDescription ?? "")
                    return
                }
                
                print(prediction)
            })
        }
    }
}
