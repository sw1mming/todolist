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
    
    static func buildNotificationWith(title: String, date: Date, identifier: String, repeats: Bool, completion: @escaping (Bool)->()) {
        let content = UNMutableNotificationContent()
        content.title = title
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                completion(error == nil)
            }
        }
    }
    
    static func deleteNotificationWith(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
