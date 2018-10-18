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
    
    var currentCategoryId: Int { get set }
    
    func fetchCategories(with completion: (([CategoryModel])->()))
    
    func save(category: CategoryModel, with completion: (()->()))
    
    // Tasks

    func fetchTasks(of categoryId: Int, completion: (([TaskModel])->()))
    
    func fetchTasks(with completion: (([TaskModel])->()))
    
    func fetchTaskWith(id: Int, completion: ((TaskModel?)->()))
    
    func save(task: TaskModel, with completion: (()->()))
    
    func deleteTask(with id: Int, with completion: (_ isCompleted: Bool)->())
    
    func update(task: TaskModel, with completion: ((Bool)->()))
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
