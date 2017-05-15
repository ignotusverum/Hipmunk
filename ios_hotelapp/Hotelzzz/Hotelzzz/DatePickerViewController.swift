//
//  DatePickerViewController.swift
//  Hotelzzz
//
//  Created by Steve Johnson on 3/22/17.
//  Copyright © 2017 Hipmunk, Inc. All rights reserved.
//

import Foundation
import UIKit


protocol DatePickerViewControllerDelegate: class {
    func datePicker(viewController: DatePickerViewController, didSelectDate date: Date)
}


class DatePickerViewController: UIViewController {
    weak var delegate: DatePickerViewControllerDelegate?
    var initialDate: Date?

    @IBOutlet var datePicker: UIDatePicker!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let initialDate = initialDate {
            datePicker.date = initialDate
        }
    }

    @IBAction func doneAction(sender: Any?) {
        self.delegate?.datePicker(viewController: self, didSelectDate: datePicker.date)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
}
