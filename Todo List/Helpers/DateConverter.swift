//
//  DateConverter.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/25/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class DateConverter {
    
    /// Convert date for appearance date in button on Create task screen.
    static func selected(_ date: Date?) -> String {
        guard let date = date else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "dd MMM yyyy, h:mm a"

        return dateFormatter.string(from: date)
    }
}
