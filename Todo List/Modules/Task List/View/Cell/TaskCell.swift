//
//  TaskCell.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Task Cell -
//************************************************************************************

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var indicatorImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
}


//************************************************************************************
// MARK: - Task Cell View Model -
//************************************************************************************

extension TaskCell {
    
    class ViewModel: TableViewModel {
        var name: String?
        var icon: UIImage?
        var id: Int?
        var isDone = false
        
        init(model: TaskModel) {
            name = model.name
            icon = model.icon
            id = model.id
            isDone = model.isDone
        }
    }
}
