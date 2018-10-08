//
//  CategoryModel.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class CategoryModel: NSObject, NSCoding {
    
    enum Key {
        static let name = "name"
        static let id = "id"
        static let icon = "icon"
        static let tasks = "tasks"
    }
    
    
    // MARK: - Properties
    
    let id: Int
    
    let name: String
    
    var icon: UIImage?
    
    var tasks: [TaskModel]?
    
    
    // MARK: - Life cycle
    
    init(title: String) {
        id = Int(arc4random_uniform(100*100))
        self.name = title
    }
    
    public required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: Key.name) as? String ?? ""
        id = aDecoder.decodeInteger(forKey: Key.id)
        icon = aDecoder.decodeObject(forKey: Key.icon) as? UIImage
        tasks = aDecoder.decodeObject(forKey: Key.tasks) as? [TaskModel]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: Key.name)
        
        aCoder.encode(id, forKey: Key.id)
        
        if let iconValue = icon {
            aCoder.encode(iconValue, forKey: Key.icon)
        }
        
        if let tasks = tasks {
            aCoder.encode(tasks, forKey: Key.tasks)
        }
    }
}
