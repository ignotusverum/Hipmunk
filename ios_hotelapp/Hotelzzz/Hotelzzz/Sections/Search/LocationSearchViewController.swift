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
    
    func placeSearchDidChange(_ text: NSAttributedString?)
}

class LocationSearchViewController: UIViewController {

    /// Delegate
    var delegate: LocationSearchViewDelegate?
    
    /// Keyboard height
    var kHeight: CGFloat = 258
    
    /// Datasource
    var datasource: [NSAttributedString] = []
    
    /// Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Table view
    lazy var tableView: UITableView = {
       
        let tableView = UITableView(frame: .zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        /// Custom cells
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: "\(LocationTableViewCell.self)")
        
        return tableView
    }()
    
    /// Location search view
    lazy var placeSearchView: PlaceSearchView = {
        
        let view = PlaceSearchView(state: .inputEnabled)
        
        return view
    }()
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Setup UI
        setupUI()
        
        /// Setup constraints
        updateViewConstraints()
        
        /// Handle autocomplete
        handleAutocomplete()
        
        /// Start typig
        placeSearchView.textInput.text = ""
        placeSearchView.textInput.becomeFirstResponder()
        
        /// Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func updateViewConstraints() {
        
        /// Place search setup
        placeSearchView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(65)
            maker.width.equalTo(view)
        }
        
        /// Table view layout
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(70)
            maker.bottom.equalTo(view).offset(-kHeight + 44)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
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
        /// Table view
        view.addSubview(tableView)
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
                
                /// Update datasource
                self.datasource = prediction.map { $0.attributedFullText }
                self.tableView.reloadData()
            })
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            kHeight = keyboardSize.height
            self.updateViewConstraints()
        }
    }
}

// MARK: - Table view datasource
extension LocationSearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(LocationTableViewCell.self)", for: indexPath)
        
        cell.textLabel?.attributedText = datasource[indexPath.row]
        return cell
    }
}

// MARK: - Table view delegate
extension LocationSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let text = cell?.textLabel?.attributedText
        
        /// Set text
        placeSearchView.textInput.attributedText = text
        
        /// Passing data to previous controller
        delegate?.placeSearchDidChange(text)
        
        /// Pop
        popVC()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
