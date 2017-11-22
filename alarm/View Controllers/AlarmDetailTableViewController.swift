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
    
    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
                updateViews()
            }
        }
    }
    
    
    private func updateViews() {
        guard let alarm = alarm else { enableButton.isHidden = true; return }
        alarmDatePicker.date = alarm.fireDate!
        alarmTitleTextField.text = alarm.name
        
        
        changeButtonStyle()
    }
    
    private func changeButtonStyle() {
        guard let alarm = alarm else { return }
        
        if alarm.enabled {
            enableButton.setTitle("Disable", for: .normal)
            enableButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        } else {
            enableButton.setTitle("Enable", for: .normal)
            enableButton.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        enableButton.layer.cornerRadius = 14.0
        enableButton.clipsToBounds = true
    }
    
    @IBAction func enableButtonTapped(_ sender: UIButton) {
        AlarmController.shared.toggleEnabled(for: alarm!)
        changeButtonStyle()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let timeInterval = alarmDatePicker.date.timeIntervalSince(DateHelper.thisMorningAtMidnight!)
        guard let title = alarmTitleTextField.text else { return }
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeInterval, name: title)
        } else {
            let _ = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeInterval, name: title)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
