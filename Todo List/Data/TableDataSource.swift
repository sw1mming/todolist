//
//  TableDataSource.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

protocol TableDataSource {
    func getViewModel(by indexPath: IndexPath) -> TableViewModel
    func numberOfRows() -> Int
}

protocol TableViewModel {
    
}
