//
//  NotificationSettingsRouter.swift
//  Todo List
//
//  Created by Sergey Melnik on 7/16/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class NotificationSettingsRouter {
    
    static func assembleModuleWith(handler: NotificationSettingsHandler) -> UIViewController {
        let view = UIStoryboard(name: NotificationSettingsViewController.className(), bundle: nil).instantiateInitialViewController()! as! NotificationSettingsViewController
        let presenter = NotificationSettingsPresenter()
        presenter.handler = handler
        
        view.presenter = presenter
        
        return view
    }
}
