//
//  CategoryCell.swift
//  Todo List
//
//  Created by Melnik Sergey on 10/7/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Cell -
//************************************************************************************

class CategoryCell: UITableViewCell {
    
    
    // MARK: Constant
    
    static let cellHeight: CGFloat = 100
    
    
    // MARK: Properties
    
    let titleLabel: UILabel = {
        return UILabel()
    }()
    
    
    // MARK: - Life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//************************************************************************************
// MARK: - CategoryCell: ViewModel -
//************************************************************************************

extension CategoryCell {
    
    class ViewModel: TableViewModel {
        var title = ""
        
        init(title: String) {
            self.title = title
        }
        
        init(category: CategoryModel) {
            title = category.name
        }
    }
}
