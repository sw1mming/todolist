//
//  DataManager.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

protocol DataManagerProtocol {
    
    // Categories
    
    func fetchCategories(with completion: (([CategoryModel])->()))

    func fetchCategory(by id: Int, completion: ((CategoryModel)->()))
    
    // Save new categoy.
    func save(category: CategoryModel, with completion: ((_ isCompleted: Bool)->()))

    // Save categories after moving rows.
    func save(categories: [CategoryModel])
    
    func deleteCategoty(id: Int, with completion: ((_ isCompleted: Bool) -> ()))
    
    func update(category: CategoryModel, with completion: ((_ isCompleted: Bool) -> ()))
    
    // Tasks

    func fetchTasks(of categoryId: Int, completion: (([TaskModel])->()))
    
    func fetchTasks(with completion: (([TaskModel])->()))
    
    func fetchTaskWith(id: Int, from categoryId: Int, completion: ((TaskModel?) -> ()))
    
    func save(task: TaskModel, for categoryId: Int, with completion: (()->()))
    
    func deleteTask(with id: Int, categoryId: Int, with completion: (_ isCompleted: Bool)->())
    
    func update(task: TaskModel, in categoryId: Int, with completion: ((Bool)->()))
}

//class DataManager: DataManagerProtocol {
//    
//    var currentCategoryId: Int = -1
//    
//    func fetchCategories(with completion: (([CategoryModel])->())) {
//        fatalError("Override this method.")
//    }
//    
//    func save(category: CategoryModel, with completion: (()->())) {
//        fatalError("Override this method.")
//    }
//
//    func fetchTasks(of categoryId: Int, completion: (([TaskModel]) -> ())) {
//        fatalError("Override this method.")
//    }
//    
//    func fetchTasks(with completion: (([TaskModel])->())) {
//        fatalError("Override this method.")
//    }
//    
//    func save(task: TaskModel, with completion: (()->())) {
//        fatalError("Override this method.")
//    }
//    
//    func deleteTask(with id: Int, with completion: (_ isCompleted: Bool)->()) {
//        fatalError("Override this method.")
//    }
//    
//    func fetchTaskWith(id: Int, completion: ((TaskModel?)->())) {
//        fatalError("Override this method.")
//    }
//    
//    func update(task: TaskModel, with completion: ((Bool) -> ())) {
//        fatalError("Override this method.")
//    }
//}
