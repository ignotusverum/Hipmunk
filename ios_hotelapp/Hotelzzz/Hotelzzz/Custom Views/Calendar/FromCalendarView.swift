//
//  FromCalendarView.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

class FromCalendarView: UIView, CalendarViewProtocol {

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
    
    /// Icon image view
    lazy var imageView: UIImageView? = {
        
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = #imageLiteral(resourceName: "calendar")
        
        return imageView
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
        titleLabel.attributedText = generateTitle("Check In")
        
        /// Adding subviews
        addSubview(imageView!)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        
        /// Icon image view
        imageView!.snp.makeConstraints { maker in
            maker.centerY.equalTo(self)
            maker.left.equalTo(15)
            maker.width.equalTo(15)
            maker.height.equalTo(15)
        }
        
        /// Title label
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(20)
            maker.right.equalTo(self)
            maker.left.equalTo(imageView!.snp.right).offset(30)
        }
        
        /// Descriptoin input
        descriptionLabel.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(5)
            maker.bottom.equalTo(self)
            maker.right.equalTo(self)
            maker.left.equalTo(imageView!.snp.right).offset(30)
        }
        
        super.updateConstraints()
    }
}
