//
//  NotificationSettingsPresenter.swift
//  Todo List
//
//  Created by Sergey Melnik on 7/16/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class NotificationSettingsPresenter {
    
    var handler: NotificationSettingsHandler!
    private var selectedDate: Date?
}

extension NotificationSettingsPresenter: NotificationSettingsViewOutput {
    
    
    func viewDidLoad() {}
    
    func didChoose(date: Date) {
//        handler.didSet(date: date)
        selectedDate = date
    }
    
    func didSelectConfirm() {
        guard let date = selectedDate else { return }
        handler.didSet(date: date)
    }
}
