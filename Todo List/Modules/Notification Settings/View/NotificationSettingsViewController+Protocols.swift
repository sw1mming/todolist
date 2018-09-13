//
//  NotificationSettingsViewController+Protocols.swift
//  Todo List
//
//  Created by Sergey Melnik on 7/24/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

protocol NotificationSettingsHandler {
    func didSet(date: Date)
}

protocol NotificationSettingsViewOutput {
    func viewDidLoad()
    func didChoose(date: Date)
    func didSelectConfirm()
}
