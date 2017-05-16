//
//  FilteringTableViewCell.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/16/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

class FilteringTableViewCell: UITableViewCell {
    
    var filteringLow: Filtering!
    var filteringHigh: Filtering?
    
    override var reuseIdentifier: String? {
        return "\(FilteringTableViewCell.self)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let lowString = filteringLow.rawValue.toString
        let highString = filteringHigh?.rawValue.toString ?? ""
        
        textLabel?.text = "$\(lowString) - \(highString)"
    }
}
