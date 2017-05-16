//
//  SortingViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/16/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

protocol SortingViewControllerDelegate {
    func selectSorting(_ sorting: Soring)
}

class SortingViewController: UIViewController {
    
    var delegate: SortingViewControllerDelegate?
    
    /// Table view
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SortingTableViewCell.self, forCellReuseIdentifier: "\(SortingTableViewCell.self)")
        
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

extension SortingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let cell = tableView.cellForRow(at: indexPath) as! SortingTableViewCell
        delegate?.selectSorting(cell.sorting)
        popVC()
    }
}

extension SortingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Soring.allValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SortingTableViewCell.self)") as! SortingTableViewCell
        
        cell.sorting = Soring.allValues[indexPath.row]
        
        return cell
    }
}
