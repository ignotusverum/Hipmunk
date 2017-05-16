//
//  JSON.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/16/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import SwiftyJSON

extension JSON {
    public var json: JSON? {
        
        switch self.type {
        case .dictionary: return JSON(object)
        default: return nil
        }
    }
}
