//
//  AlarmController.swift
//  alarm
//
//  Created by Kudryatzhan Arziyev on 11/20/17.
//  Copyright © 2017 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleNotifications(for alarm: Alarm)
    func cancelUserNotification(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "It is time"
        notificationContent.body = "Here should be a description..."
        notificationContent.sound = UNNotificationSound.default()
        
        let dateComponents = Calendar.current.dateComponents([.minute, .second], from: alarm.fireDate!)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request. \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotification(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}

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
        alarms = loadFromPersistenceStore()
    }
    
    // add alarm
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let newAlarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(newAlarm)
        
        saveToPersistenceStore()
        
        return newAlarm
    }
    
    // update alarm
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        
        saveToPersistenceStore()
    }
    
    // delete alarm
    func delete(alarm: Alarm) {
        guard let indexOfAlarmToDelete = alarms.index(of: alarm) else { return }
        alarms.remove(at: indexOfAlarmToDelete)
        
        saveToPersistenceStore()
    }
    
    // toggle enabled
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        
        saveToPersistenceStore()
    }
    
    // MARK: - Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "alarmList.json"
        
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    func saveToPersistenceStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            print(String(data: data, encoding: .utf8)!)
            try data.write(to: fileURL())
        } catch {
            debugPrint("Could not save data: \(error)")
        }
    }
    
    func loadFromPersistenceStore() -> [Alarm] {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let alarmArray = try decoder.decode([Alarm].self, from: data)
            return alarmArray
        } catch {
            debugPrint("Could not load data: \(error)")
        }
        return []
    }
}
