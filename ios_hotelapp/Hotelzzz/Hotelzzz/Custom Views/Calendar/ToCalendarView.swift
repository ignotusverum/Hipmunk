//
//  ToCalendarView.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

class ToCalendarView: UIView, CalendarViewProtocol {
    
    /// Icon Image View
    var imageView: UIImageView? = nil

    var state: CalendarViewState
    
    /// date
    var date: Date {
        didSet {
            /// Generate description
            descriptionLabel.attributedText = generateDescription(dateToString())
        }
    }
    
    /// Title
    lazy var titleLabel: UILabel = {
        
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        return label
    }()
    
    /// Description Label
    lazy var descriptionLabel: UILabel = {
        
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        return label
    }()

    init(state: CalendarViewState, date: Date) {
        
        self.state = state
        self.date = date
        super.init(frame: .zero)
        
        /// Custom init
        customInit()
        
        /// Generate description
        descriptionLabel.attributedText = generateDescription(dateToString())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Init
    func customInit() {
        
        /// Background color
        backgroundColor = UIColor.white
        
        /// Title
        titleLabel.attributedText = generateTitle("Check Out")
        
        /// Adding subviews
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        /// Title label
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(20)
            maker.right.equalTo(self)
            maker.left.equalTo(15)
        }
        
        /// Descriptoin input
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(25).offset(5)
            maker.bottom.equalTo(self)
            maker.right.equalTo(self)
            maker.left.equalTo(15)
        }

        super.updateConstraints()
    }
}
