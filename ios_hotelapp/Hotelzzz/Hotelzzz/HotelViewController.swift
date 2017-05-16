//
//  HotelViewController.swift
//  Hotelzzz
//
//  Created by Steve Johnson on 3/22/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Foundation

struct Hotel {
    
    var id: Int?
    var name: String?
    var address: String?
    var imageURLString: String?
    
    var price: Int?
    
    init(json: JSON) {
        
        price = json["price"].int
        
        guard let hotelJSON = json["hotel"].json else {
            return
        }
        
        id = hotelJSON["id"].int
        imageURLString = hotelJSON["imageURL"].string
        name = hotelJSON["name"].string
        address = hotelJSON["address"].string
    }
}

class HotelViewController: UIViewController {
    
    /// Hotel
    var hotel: Hotel
    
    /// Image View
    lazy var imageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    /// Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Address Info
    lazy var addressInfoLabel: UILabel = {
       
        let label = UILabel(frame: .zero)
        
        label.numberOfLines = 0
        label.textColor = UIColor.black
        
        return label
    }()
    
    // MARK: - Custom init
    init(json: JSON) {
        
        self.hotel = Hotel(json: json)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = hotel.name ?? "Hotel"
        let price = hotel.price?.toString ?? ""
        
        setTitle("\(name) $\(price)")
        
        /// Custom UI
        customInit()
        
        /// Setup constraints
        updateViewConstraints()
    }
    
    func customInit() {
        
        view.backgroundColor = UIColor.white
        
        /// Image View
        view.addSubview(imageView)
        
        /// Address info
        view.addSubview(addressInfoLabel)
        
        /// Image load
        imageView.downloadImageFrom(link: hotel.imageURLString ?? "", contentMode: .scaleAspectFit)
        
        /// Address
        addressInfoLabel.text = hotel.address
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    override func updateViewConstraints() {
        
        imageView.snp.makeConstraints { maker in
            maker.top.equalTo(5)
            maker.height.equalTo(320)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        addressInfoLabel.snp.makeConstraints { maker in
            maker.top.equalTo(imageView.snp.bottom).offset(10)
            maker.height.equalTo(100)
            maker.left.equalTo(20)
            maker.width.equalTo(100)
        }
        
        super.updateViewConstraints()
    }
}
