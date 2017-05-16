//
//  SearchViewController.swift
//  Hotelzzz
//
//  Created by Steve Johnson on 3/22/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
import Foundation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-mm-dd"
    return formatter
}()

private func jsonStringify(_ obj: [AnyHashable: Any]) -> String {
    let data = try! JSONSerialization.data(withJSONObject: obj, options: [])
    return String(data: data, encoding: .utf8)!
}

/// Soring enum
enum Soring: String {
    case name = "name"
    case priceAscend = "priceAscend"
    case priceDescend = "priceDescend"
    
    static var allValues: [Soring] = [.name, .priceAscend, .priceDescend]
}

/// Filtering enum
enum Filtering: Int {
    case low = 230
    case medium = 290
    case high = 340
    
    static var allValues: [Filtering] = [.low, .medium, .high]
}

/// JS Calls enum
enum JSCalls: String {
    case apiReady = "API_READY"
    case searchReady = "HOTEL_API_SEARCH_READY"
    case hotelResults = "HOTEL_API_RESULTS_READY"
    case hotelSelected = "HOTEL_API_HOTEL_SELECTED"
}

class SearchViewController: UIViewController {

    /// Sorting enum
    var sorting: Soring?
    
    /// Filtering
    var priceLow: Filtering?
    var priceHigh: Filtering?
    
    /// Status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /// Search struct
    struct Search {
        let location: String
        let dateStart: Date
        let dateEnd: Date

        var asJSONString: String {
            return jsonStringify([
                "location": location,
                "dateStart": dateFormatter.string(from: dateStart),
                "dateEnd": dateFormatter.string(from: dateEnd)
            ])
        }
    }

    fileprivate var _searchToRun: Search?

    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect.zero, configuration: {
            let config = WKWebViewConfiguration()
            config.userContentController = {
                let userContentController = WKUserContentController()

                // DECLARE YOUR MESSAGE HANDLERS HERE
                userContentController.add(self, name: JSCalls.apiReady.rawValue)
                userContentController.add(self, name: JSCalls.searchReady.rawValue)
                userContentController.add(self, name: JSCalls.hotelResults.rawValue)
                userContentController.add(self, name: JSCalls.hotelSelected.rawValue)

                return userContentController
            }()
            return config
        }())
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self

        return webView
    }()
    
    // MARK: - Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Title setup
        setTitle("Hotel Search")
        
        /// Custom init
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        
        /// Background color
        view.backgroundColor = UIColor.white
        
        /// Web view
        view.addSubview(webView)
        
        /// Setup constraints
        updateViewConstraints()
        
        /// Navigation setup
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(onSort(_:)))
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(onFilter(_:)))
        
        navigationItem.rightBarButtonItems = [sortButton, filterButton]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    override func updateViewConstraints() {
        
        /// Place search setup
        webView.snp.makeConstraints { maker in
            maker.top.equalTo(view)
            maker.bottom.equalTo(view)
            maker.left.equalTo(view)
            maker.right.equalTo(view)
        }
        
        super.updateViewConstraints()
    }

    /// Search
    func search(location: String, dateStart: Date, dateEnd: Date) {
        _searchToRun = Search(location: location, dateStart: dateStart, dateEnd: dateEnd)
        self.webView.load(URLRequest(url: URL(string: "http://hipmunk.github.io/hipproblems/ios_hotelapp/")!))
    }
    
    // MARK: - Actions
    func onSort(_ sender: UIBarButtonItem) {
        
        let sortingVC = SortingViewController()
        
        sortingVC.delegate = self
        pushVC(sortingVC)
    }
    
    func onFilter(_ sender: UIBarButtonItem) {
        
        let filterVC = FilteringViewController()
        
        filterVC.delegate = self
        pushVC(filterVC)
    }
}

// MARK: - FilteringViewControllerDelegate
extension SearchViewController: FilteringViewControllerDelegate {
    func selectFiltering(low: Filtering, high: Filtering?) {
        
        let lowString = low.rawValue.toString
        let highString = high?.rawValue.toString ?? ""

        webView.evaluateJavaScript("window.JSAPI.setHotelFilters({priceMin: \(lowString), priceMax: \(highString)})", completionHandler: nil)
    }
}

// MARK: - Sorring delegate
extension SearchViewController: SortingViewControllerDelegate {
    func selectSorting(_ sorting: Soring) {
        webView.evaluateJavaScript("window.JSAPI.setHotelSort(\(sorting.rawValue))", completionHandler: nil)
    }
}

// MARK: - WKScriptMessageHandler
extension SearchViewController: WKScriptMessageHandler {
    /// User content handler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        switch message.name {
        case JSCalls.hotelResults.rawValue:
            
            /// Json result
            let json = JSON(message.body)
            
            /// Safety check
            guard let array = json["results"].array else {
                return
            }
            
            setTitle("🎉 \(array.count) Hotels Found 🎉")
            
        case JSCalls.apiReady.rawValue:
            guard let searchToRun = _searchToRun else { fatalError("Tried to load the page without having a search to run") }
            
            webView.evaluateJavaScript("window.JSAPI.runHotelSearch(\(searchToRun.asJSONString))", completionHandler: nil)
        case JSCalls.hotelSelected.rawValue:
            
            /// Hotel details controller
            guard let resultJSON = JSON(message.body)["result"].json else {
                return
            }
            
            let hotelVC = HotelViewController(json: resultJSON)
            pushVC(hotelVC)
            
        default: break
        }
    }
}

extension SearchViewController: WKNavigationDelegate {
    /// Web view handler
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let alertController = UIAlertController(title: NSLocalizedString("Could not load page", comment: ""), message: NSLocalizedString("Looks like the server isn't running.", comment: ""), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Bummer", comment: ""), style: .default, handler: nil))
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
}
