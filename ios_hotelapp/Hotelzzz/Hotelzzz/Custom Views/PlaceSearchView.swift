//
//  PlaceSearchView.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import SnapKit

/// Controls input actions
enum PlaceSearchViewState {
    
    case inputEnabled
    case inputDisabled
}

class PlaceSearchView: UIView, PlaceSearchViewProtocol {

    /// Icon
    lazy var imageView: UIImageView = {
       
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    /// Title label
    lazy var titleLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        
        return label
    }()
    
    /// Divider view
    lazy var dividerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.alpha = 0.3
        
        return view
    }()
    
    /// Text Input
    lazy var textInput: UITextField = {
       
        let textField = UITextField(frame: .zero)
                
        textField.textColor = UIColor.defaultColor
        textField.font = UIFont.AvenirNextRegular(size: 14)
        
        textField.tintColor = UIColor.black
        textField.contentVerticalAlignment = .center
        
        /// No capitalization
        textField.autocapitalizationType = .none
        
        /// Keyboard appearance
        textField.keyboardAppearance = .dark
        
        /// Disable auto correction
        textField.autocorrectionType = .no
        
        /// Text did change
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        return textField
    }()
    
    /// Input state
    var state: PlaceSearchViewState
    
    /// Closure for detecting when view is tapped
    private var viewTapped: (()->())?
    
    /// Closure for detecting when called textDidChange
    private var textDidChange: ((String?)->())?
    
    // MARK: - Initialization
    init(state: PlaceSearchViewState) {
        
        self.state = state
        super.init(frame: .zero)
        
        /// Custom initialization
        customInit()
        
        /// Actions setup
        setupUI(for: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInit() {
        
        /// Text input
        textInput.attributedText = generatePlaceholder()
        textInput.isUserInteractionEnabled = state == .inputEnabled
        
        /// Icon image
        imageView.image = generateIcon()
        
        /// Title label
        titleLabel.attributedText = generateTitle()
        
        /// Adding subviews
        addSubview(imageView)
        addSubview(textInput)
        addSubview(titleLabel)
        addSubview(dividerView)
        
        setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        /// Icon image view
        imageView.snp.makeConstraints { maker in
            maker.centerY.equalTo(self)
            maker.left.equalTo(10)
            maker.width.equalTo(20)
            maker.height.equalTo(20)
        }
        
        /// Title label
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(10)
            maker.right.equalTo(self)
            maker.left.equalTo(imageView.snp.right).offset(10)
        }
        
        /// Text input
        textInput.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom)
            maker.bottom.equalTo(self).offset(-15)
            maker.right.equalTo(self)
            maker.left.equalTo(imageView.snp.right).offset(10)
        }

        /// Divider view
        dividerView.snp.makeConstraints { maker in
            maker.bottom.equalTo(self).offset(-1)
            maker.left.equalTo(self)
            maker.right.equalTo(self)
            maker.height.equalTo(1)
        }
    }
    
    /// Setup UI based on state
    func setupUI(for state: PlaceSearchViewState) {
        
        /// Disabled input state
        if state == .inputDisabled {
            
            /// Handle tap
            addTapGesture { gesture in
                self.viewTapped?()
            }
            
            return
        }
    }
    
    /// Function to handle closure in parent
    func viewTapped(_ completion: (()->())?) {
        
        /// Completion handler
        viewTapped = completion
    }

    /// Text did change
    func textDidChange(_ completion: ((String?)->())?) {
        
        /// Completion handler
        textDidChange = completion
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        textDidChange?(textField.text)
    }
}
