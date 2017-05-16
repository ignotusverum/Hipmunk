//
//  CalendarContainerView.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

class CalendarContainerView: UIView {
    
    /// State
    var state: CalendarViewState {
        didSet {
            
            fromView.state = state
            toView.state = state
        }
    }
    
    var fromDate: Date {
        get {
            return fromView.date
        }
        set {
            
            fromView.date = newValue
        }
    }
    
    var toDate: Date {
        get {
            return toView.date
        }
        set {
            
            toView.date = newValue
        }
    }
    
    /// Divider view
    lazy var dividerView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.gray
        view.alpha = 0.3
        
        return view
    }()
    
    /// Closure for detecting when view is tapped
    private var viewTapped: (()->())?

    /// From View
    lazy var fromView: FromCalendarView = {
       
        let view = FromCalendarView(state: self.state, date: Date())
        return view
    }()
    
    /// To View
    lazy var toView: ToCalendarView = {
        
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        
        let view = ToCalendarView(state: self.state, date: nextDay!)
        return view
    }()
    
    init(state: CalendarViewState) {
        
        self.state = state
        
        super.init(frame: .zero)
        
        /// Custom init
        customInit()
        
        setupUI(for: state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Init
    func customInit() {
        
        backgroundColor = UIColor.white
        
        /// Subviews
        addSubview(fromView)
        addSubview(toView)
        
        addSubview(dividerView)
        
        setNeedsUpdateConstraints()
    }
    
    /// Setup UI based on state
    func setupUI(for state: CalendarViewState) {
        
        /// Disabled input state
        if state == .selectionDisabled {
            
            /// Handle tap
            addTapGesture { gesture in
                self.viewTapped?()
            }
            
            return
        }
    }
    
    /// Function to handle closure in parent
    func viewTapped(_ completion: (()->())?) {
        
        /// Completion handler
        viewTapped = completion
    }
    
    override func updateConstraints() {
        /// Layout
        fromView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.bottom.equalTo(self)
            maker.right.equalTo(snp.centerX)
            maker.left.equalTo(self)
        }
        
        toView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.bottom.equalTo(self)
            maker.right.equalTo(self)
            maker.left.equalTo(snp.centerX)
        }
        
        /// Divider view
        dividerView.snp.makeConstraints { maker in
            maker.bottom.equalTo(self).offset(-5)
            maker.top.equalTo(self).offset(5)
            maker.width.equalTo(1)
            maker.right.equalTo(snp.centerX).offset(-1)
        }
        
        super.updateConstraints()
    }
}
