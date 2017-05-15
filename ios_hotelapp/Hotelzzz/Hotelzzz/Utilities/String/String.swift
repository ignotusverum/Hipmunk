//
//  String.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Foundation
import EZSwiftExtensions

extension String {
    
    func generateTitle(_ color: UIColor = UIColor.black)-> NSAttributedString {
        
        let attributedString = NSMutableAttributedString.initWithString(self, lineSpacing: 5.0, aligntment: .center)
        
        attributedString.addAttribute(NSKernAttributeName, value: UIFont.AvenirNextRegular(size: 17), range: NSRange(location: 0, length: length))
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSRange(location: 0, length: length))
        attributedString.addAttribute(NSKernAttributeName, value: 2.0, range: NSRange(location: 0, length: length))
        
        return attributedString
    }
}

extension NSMutableAttributedString {
    
    static func initWithString(_ string: String, lineSpacing: CGFloat, aligntment: NSTextAlignment)-> NSMutableAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = aligntment
        
        let attrsDict : NSDictionary =  [NSParagraphStyleAttributeName : paragraphStyle]
        
        return NSMutableAttributedString(string: string, attributes: attrsDict as? [String : AnyObject])
    }
}

