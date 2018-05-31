//
//  NSObject+StringFromClass.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

extension NSObject {
    static func className() -> String {
        var className = String(describing: self)
        
        if className.contains("<") {
            let components = className.components(separatedBy: "<")
            
            if components.count > 0 {
                className = components[0]
            }
        }
        
        return className
    }
}
