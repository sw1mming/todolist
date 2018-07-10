//
//  Task.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class TaskModel: NSObject, NSCoding {
    
    enum Key {
        static let name = "name"
        static let id = "id"
        static let icon = "icon"
        static let isDone = "isDone"
    }
    
    // MARK: Properties
    
    var name: String?
    
    var id: Int?
    
    var icon: UIImage?
    
    var isDone = false
    
    
    // MARK: - Life cycle
    
    public required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: Key.name) as? String
        id = aDecoder.decodeInteger(forKey: Key.id)
        icon = aDecoder.decodeObject(forKey: Key.icon) as? UIImage
        isDone = aDecoder.decodeBool(forKey: Key.isDone)
    }
    
    public override init() {
        id = Int(arc4random_uniform(100*100))
    }
    
    public func encode(with aCoder: NSCoder) {
        if let nameValue = name {
            aCoder.encode(nameValue, forKey: Key.name)
        }
        
        if let idValue = id {
            aCoder.encode(idValue, forKey: Key.id)
        }

        if let iconValue = icon {
            aCoder.encode(iconValue, forKey: Key.icon)
        }
        
        aCoder.encode(isDone, forKey: Key.isDone)
    }
}

extension TaskModel {
    
    func updateWith(_ task: TaskModel) {
        name = task.name
        icon = task.icon
        isDone = task.isDone
    }
}
