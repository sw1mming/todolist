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
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        indicatorImageView.image = nil
        nameLabel.text = nil
        dateLabel.text = nil
    }
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
        var dateString: String?
        
        init(model: TaskModel) {
            name = model.name
            icon = model.icon
            id = model.id
            isDone = model.isDone
            
            if let date = model.date {
                dateString = DateConverter.selected(date)
            }
        }
    }
}
