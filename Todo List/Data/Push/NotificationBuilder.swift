//
//  NotificationBuilder.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/20/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationBuilder {
    
    static func buildNotificationWith(title: String, date: Date, completion: @escaping (Bool)->()) {
        let content = UNMutableNotificationContent()
        content.title = title
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: false)
        
        let request = UNNotificationRequest(identifier: NSUUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            completion(error != nil)
        }
    }
}
