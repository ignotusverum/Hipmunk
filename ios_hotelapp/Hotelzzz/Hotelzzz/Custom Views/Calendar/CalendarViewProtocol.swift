//
//  CalendarViewProtocol.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Foundation

/// Controls input actions
enum CalendarViewState {
    
    case selectionEnabled
    case selectionDisabled
}

protocol CalendarViewProtocol {
    
    /// date
    var date: Date { get set }
    
    /// Title
    var titleLabel: UILabel { get set }
    
    /// Description Label
    var descriptionLabel: UILabel { get set }
    
    /// Icon Image View
    var imageView: UIImageView? { get set }
}

extension CalendarViewProtocol {
    
    /// Generate initial dates
    func generateInitialDate()-> Date {
        return Date()
    }
    
    func dateToString()-> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM EEEE"
        
        return dateFormatter.string(from: date)
    }
    
    func generateTitle(_ title: String)-> NSAttributedString {
        
        /// Title Params
        let params: [String: Any] = [NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.AvenirNextRegular(size: 8)]
        
        return NSAttributedString(string: title, attributes: params)
    }
    
    func generateDescription(_ string: String)-> NSAttributedString {
        
        /// Title Params
        let params: [String: Any] = [NSForegroundColorAttributeName: UIColor.defaultColor, NSFontAttributeName: UIFont.AvenirNextRegular(size: 12)]
        
        return NSAttributedString(string: string, attributes: params)
    }
}
