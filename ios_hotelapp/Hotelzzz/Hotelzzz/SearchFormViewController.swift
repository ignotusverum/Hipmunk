//
//  ViewController.swift
//  Hotelzzz
//
//  Created by Steve Johnson on 3/21/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import UIKit

private enum DateType {
    case checkIn
    case checkOut
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

class SearchFormViewController: UIViewController, DatePickerViewControllerDelegate {
    @IBOutlet var locationField: UITextField!
    @IBOutlet var openDateStartPickerButton: UIButton!
    @IBOutlet var openDateEndPickerButton: UIButton!

    var checkInDate: Date = Date() { didSet { _updateCheckIn() } }
    var checkOutDate: Date = Date()  { didSet { _updateCheckOut() } }
    fileprivate var _pickingDateType: DateType? = nil

    private func _updateCheckIn() {
        openDateStartPickerButton.setTitle(dateFormatter.string(from: checkInDate), for: .normal)
    }

    private func _updateCheckOut() {
        openDateEndPickerButton.setTitle(dateFormatter.string(from: checkOutDate), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _updateCheckIn()
        _updateCheckOut()
        dateFormatter.timeStyle = .none
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("pick_check_in_date"):
            _pickingDateType = .checkIn
            _handleDatePickerSegue(destination: segue.destination,
                                   date: self.checkInDate,
                                   title: NSLocalizedString("Check in", comment: ""))
        case .some("pick_check_out_date"):
            _pickingDateType = .checkOut
            _handleDatePickerSegue(destination: segue.destination,
                                   date: self.checkOutDate,
                                   title: NSLocalizedString("Check out", comment: ""))
        case .some("search"):
            guard let searchVC = segue.destination as? SearchViewController else {
                fatalError("Segue destination has unexpected type")
            }
            searchVC.search(location: self.locationField.text ?? "", dateStart: self.checkInDate, dateEnd: self.checkOutDate)
        default:
            fatalError("Can't handle this segue")
        }
    }

    private func _handleDatePickerSegue(destination: UIViewController, date: Date, title: String) {
        guard let navVC = destination as? UINavigationController,
            let datePickerVC = navVC.topViewController as? DatePickerViewController else {
            fatalError("Segue destination has unexpected type")
        }
        datePickerVC.navigationItem.title = title
        datePickerVC.initialDate = date
        datePickerVC.delegate = self
    }

    func datePicker(viewController: DatePickerViewController, didSelectDate date: Date) {
        switch _pickingDateType {
        case .some(.checkIn): self.checkInDate = date
        case .some(.checkOut): self.checkOutDate = date
        default: return;
        }
    }
}
