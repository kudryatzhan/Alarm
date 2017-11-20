//
//  SwitchTableViewCell.swift
//  alarm
//
//  Created by Kudryatzhan Arziyev on 11/20/17.
//  Copyright © 2017 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
    }
}
