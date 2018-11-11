//
//  CategoryAddCell.swift
//  Todo List
//
//  Created by Melnik Sergey on 10.11.2018.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class AddCategoryCell: UITableViewCell {}

extension AddCategoryCell {
    
    class ViewModel: TableViewModel {}
    
    func fill() -> UITableViewCell {
        textLabel?.textAlignment = .center
        textLabel?.text = "Add new"
        
        return self
    }
}
