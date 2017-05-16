//
//  CalendarViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/15/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import Koyomi

protocol CalendarViewControllerDelegate {
    func datesSelected(fromDate: Date, toDate: Date)
}

class CalendarViewController: UIViewController {

    var selectedDates: [Date] = [] {
        didSet {
            
            let toDate = selectedDates.first ?? Date()
            let fromDate = selectedDates.last ?? Date()
            
            /// Causing weird UI Bug
            calendarView.select(date: toDate, to: fromDate)
            
            calendarInputView.toDate = toDate
            calendarInputView.fromDate = fromDate
        }
    }
    
    /// Delegate
    var delegate: CalendarViewControllerDelegate?
    
    /// Calendar input view
    lazy var calendarInputView: CalendarContainerView = {
        
        let view = CalendarContainerView(state: .selectionDisabled)
        return view
    }()
    
    /// Button 
    lazy var selectButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.layer.cornerRadius = 8
        button.setTitle("Select", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundColor(UIColor.orange, forState: .normal)
        
        button.addTarget(self, action: #selector(onSelect(_:)), for: .touchUpInside)
        
        return button
    }()
    
    /// Calendar View
    lazy var calendarView: Koyomi = {
       
        let view = Koyomi(frame: .zero, sectionSpace: 1, cellSpace: 0, inset: .zero, weekCellHeight: 25)
        
        view.circularViewDiameter = 0.2
        view.calendarDelegate = self
        view.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
        view.style = .standard
        view.dayPosition = .center
        view.selectionMode = .sequence(style: .background)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        /// Background color
        view.backgroundColor = UIColor.white
        
        /// Title
        setTitle("Select Dates")
        
        /// Calendar view
        view.addSubview(calendarView)
        calendarView.select(date: calendarInputView.fromDate, to: calendarInputView.toDate)
        
        /// Calendar input view
        view.addSubview(calendarInputView)
        
        /// Select button
        view.addSubview(selectButton)
        
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
            maker.top.equalTo(calendarInputView.snp.bottom).offset(15)
            maker.height.equalTo(300)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        /// Select button
        selectButton.snp.makeConstraints { maker in

            maker.centerX.equalTo(view.snp.centerX)
            maker.bottom.equalTo(-60)
            maker.width.equalTo(180)
            maker.height.equalTo(60)
        }
        
        super.updateViewConstraints()
    }
    
    // MARK: - Actions
    func onSelect(_ sender: UIButton) {
        delegate?.datesSelected(fromDate: calendarInputView.fromDate, toDate: calendarInputView.toDate)
        
        popVC()
    }
}

extension CalendarViewController: KoyomiDelegate {
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        
        let date = date ?? Date()
        let toDate = toDate ?? Date()
        
        calendarInputView.fromDate = date
        calendarInputView.toDate = date < toDate ? toDate : date
        
        return true
    }
}
