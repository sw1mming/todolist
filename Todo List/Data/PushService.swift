//
//  PushService.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/15/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation
import UserNotifications

class PushService: NSObject {
    
    func register() {
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.delegate = self
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
    }
}

extension PushService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}
