//
//  PlaceSearchViewprotocol.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Foundation

protocol PlaceSearchViewProtocol {
    
    /// Icon Image View
    var imageView: UIImageView { get set }
    
    /// Title Label
    var titleLabel: UILabel { get set }
    
    /// Text input
    var textInput: UITextField { get set }
}

extension PlaceSearchViewProtocol {
    
    /// Generators
    /// Generates default placeholder for text field
    func generatePlaceholder()-> NSAttributedString? {
        
        /// Default copy
        let placeholder = "Search"
        
        /// Placeholder Params
        let params: [String: Any] = [NSForegroundColorAttributeName: UIColor.defaultColor, NSFontAttributeName: UIFont.AvenirNextRegular(size: 14)]
        
        return NSAttributedString(string: placeholder, attributes: params)
    }
    
    /// Generate default icon
    func generateIcon()-> UIImage {
        return #imageLiteral(resourceName: "placeholder")
    }
    
    /// Generate title
    func generateTitle()-> NSAttributedString? {
        
        /// Default copy
        let text = "Location"
        
        /// Placeholder Params
        let params: [String: Any] = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.AvenirNextRegular(size: 8)]
        
        return NSAttributedString(string: text, attributes: params)
    }
}
