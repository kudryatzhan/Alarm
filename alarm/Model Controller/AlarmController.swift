//
//  AlarmController.swift
//  alarm
//
//  Created by Kudryatzhan Arziyev on 11/20/17.
//  Copyright © 2017 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms = [Alarm]()
    
    // add alarm
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let newAlarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(newAlarm)
        
        return newAlarm
    }
    
    // update alarm
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    // delete alarm
    func delete(alarm: Alarm) {
        guard let indexOfAlarmToDelete = alarms.index(of: alarm) else { return }
        alarms.remove(at: indexOfAlarmToDelete)
    }
}
