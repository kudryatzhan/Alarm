//
//  AlarmDetailTableViewController.swift
//  alarm
//
//  Created by Kudryatzhan Arziyev on 11/20/17.
//  Copyright © 2017 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // Outlets
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func enableButtonTapped(_ sender: UIButton) {
    }
    
}
