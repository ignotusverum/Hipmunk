//
//  SortingTableViewCell.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/16/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

class SortingTableViewCell: UITableViewCell {
    
    var sorting: Soring!
    
    override var reuseIdentifier: String? {
        return "\(SortingTableViewCell.self)"
    }
}
