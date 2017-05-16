//
//  CalendarViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Koyomi

class CalendarViewController: UIViewController {

    /// Calendar input view
    lazy var calendarInputView: CalendarContainerView = {
        
        let view = CalendarContainerView(state: .selectionDisabled)
        return view
    }()
    
    /// Calendar View
    lazy var calendarView: Koyomi = {
       
        let view = Koyomi(frame: .zero, sectionSpace: 1, cellSpace: 0, inset: .zero, weekCellHeight: 25)
        
        view.circularViewDiameter = 0.2
        view.calendarDelegate = self
        view.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
        view.style = .standard
        view.dayPosition = .center
        view.selectionMode = .sequence(style: .semicircleEdge)
        view.selectedStyleColor = UIColor(red: 203/255, green: 119/255, blue: 223/255, alpha: 1)
        view
            .setDayFont(size: 14)
            .setWeekFont(size: 10)
        
        return view
    }()
    
    /// Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        /// Background color
        view.backgroundColor = UIColor.white
        
        /// Title
        setTitle("Select Dates")
        
        /// Calendar view
        view.addSubview(calendarView)
        
        /// Calendar input view
        view.addSubview(calendarInputView)
        
        /// Setup constraints
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        
        calendarInputView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(65)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        /// Place search setup
        calendarView.snp.makeConstraints { maker in
            maker.top.equalTo(calendarInputView.snp.bottom)
            maker.height.equalTo(view.snp.centerX)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}

extension CalendarViewController: KoyomiDelegate {
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        print("You Selected: \(date!)")
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        print(dateString)
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        
        return true
    }
}
