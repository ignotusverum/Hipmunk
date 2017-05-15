//
//  UIViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Title
    func setTitle(_ titleText: String, color: UIColor = UIColor.white) {
        
        let label = UILabel()
        label.attributedText = titleText.generateTitle(color)
        
        label.sizeToFit()
        self.navigationItem.titleView = label
    }
}

