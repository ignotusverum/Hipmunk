//
//  FilteringViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/16/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

protocol FilteringViewControllerDelegate {
    func selectFiltering(low: Filtering, high: Filtering?)
}

class FilteringViewController: UIViewController {

    var delegate: FilteringViewControllerDelegate?
    
    /// Table view
    lazy var tableView: UITableView = {
       
        let tableView = UITableView(frame: .zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FilteringTableViewCell.self, forCellReuseIdentifier: "\(FilteringTableViewCell.self)")
        
        return tableView
    }()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle("Filters")
        
        /// Custom init
        customInit()
    }
    
    func customInit() {
        
        /// Table view
        view.addSubview(tableView)
        
        updateViewConstraints()
    }

    override func updateViewConstraints() {
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(view)
            maker.bottom.equalTo(view)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        super.updateViewConstraints()
    }
}

extension FilteringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let cell = tableView.cellForRow(at: indexPath) as! FilteringTableViewCell
        delegate?.selectFiltering(low: cell.filteringLow, high: cell.filteringHigh)
        popVC()
    }
}

extension FilteringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Filtering.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(FilteringTableViewCell.self)") as! FilteringTableViewCell
        
        cell.filteringLow = Filtering.low
        cell.filteringHigh = Filtering.medium
        
        if indexPath.row == 1 {
            cell.filteringLow = Filtering.medium
            cell.filteringHigh = Filtering.high
        }
        else if indexPath.row == 2 {
            cell.filteringLow = Filtering.high
            cell.filteringHigh = nil
        }
        
        return cell
    }
}
