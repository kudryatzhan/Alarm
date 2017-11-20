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
    
    // mock data
    var mockAlarms: [Alarm] {
        let alarm1 = Alarm(fireTimeFromMidnight: 1000, name: "Alarm #1")
        let alarm2 = Alarm(fireTimeFromMidnight: 5000, name: "Alarm #2")
        let alarm3 = Alarm(fireTimeFromMidnight: 10000, name: "Alarm #3")
        
        return [alarm1, alarm2, alarm3]
    }
    
    init() {
        alarms = mockAlarms
    }
    
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
