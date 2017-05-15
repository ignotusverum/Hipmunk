//
//  HotelsSearchViewController.swift
//  Hotelzzz
//
//  Created by Vladislav Zagorodnyuk on 5/14/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import SnapKit

class HotelsSearchViewController: UIViewController {

    /// Collection View
    lazy var collectionView: UICollectionView = {
        
//        let layout = TMAddCreditCardPaymentCollectionViewLayout()
//        
//        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        
//        collectionView.dataSource = self
//        collectionView.backgroundColor = UIColor.clear
//        collectionView.register(TMAddCreditCardPaymentCollectionViewCell.self, forCellWithReuseIdentifier: "\(TMAddCreditCardPaymentCollectionViewCell.self)")
//        collectionView.register(TMScanCreditCardPaymentCollectionViewCell.self, forCellWithReuseIdentifier: "\(TMScanCreditCardPaymentCollectionViewCell.self)")
//        
//        return collectionView
        
        return UICollectionView()
    }()
    
    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Setup UI
    }
    
    private func setupUI() {
        
        /// Title
        setTitle("Search Hotels")
        
        /// Collection View
        view.addSubview(collectionView)
        
        /// Layout - Collection view
        collectionView.snp.makeConstraints { maker-> Void in
            maker.height.equalTo(view)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
            maker.top.equalTo(view)
        }
    }
}
