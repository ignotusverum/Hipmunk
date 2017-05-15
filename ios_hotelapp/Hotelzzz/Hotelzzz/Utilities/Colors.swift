//
//  Colors.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func ColorRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)-> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    /// Default color
    open class var defaultColor: UIColor {
        return ColorRGB(63, green: 172, blue: 236, alpha: 1)
    }
}
