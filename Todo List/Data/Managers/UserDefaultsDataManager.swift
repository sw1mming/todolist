//
//  UserDefaultsDataManager.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

class UserDefaultsDataManager: DataManagerProtocol {
    
    enum Key {
        static let tasks = "tasks"
        static let categories = "categories"
    }
    
    func save(category: CategoryModel, with completion: ((_ isCompleted: Bool) -> ())) {
        loadCategoriesWith { [weak self] categories in
            var result = categories
            result.count > 0 ? result.insert(category, at: result.startIndex) : result.append(category)
            
            self?.save(categories: result)
            completion(true)
        }
    }
    
    func deleteCategoty(id: Int, with completion: ((_ isCompleted: Bool) -> ())) {
        loadCategoriesWith { categories in
            var result = categories
            guard let index = categories.enumerated().filter({ $0.element.id == id }).first?.offset else {
                completion(false)
                return
            }
            
            result.remove(at: index)
            
            save(categories: result)
            completion(true)
        }
    }
    
    func update(category: CategoryModel, with completion: ((_ isCompleted: Bool) -> ())) {
        loadCategoriesWith { categories in
            var result = categories
            guard let index = categories.enumerated().filter({ $0.element.id == category.id }).first?.offset else {
                completion(false)
                return
            }
            
            result.remove(at: index)
            result.insert(category, at: index)
            
            save(categories: result)
            completion(true)
        }
    }
    
    func fetchCategories(with completion: (([CategoryModel]) -> ())) {
        loadCategoriesWith { categories in
            completion(categories)
        }
    }
    
    func fetchCategory(by id: Int, completion: ((CategoryModel) -> ())) {
        loadCategoriesWith { categories in
            guard let category = categories.filter({ $0.id == id }).first else {
                print("Manager doesn't have category by \(id).")
                return
            }
            
            completion(category)
        }
    }
    
    func save(task: TaskModel, for categoryId: Int, with completion: (()->())) {
        fetchCategories { categories in
            let category = categories.filter({ $0.id == categoryId }).first
            category?.tasks.append(task)
            
            save(categories: categories)
            completion()
        }
    }
    
    func fetchTasks(of categoryId: Int, completion: (([TaskModel]) -> ())) {
        loadCategoriesWith { categories in
            guard let tasks = categories.filter({ $0.id == categoryId }).first?.tasks else { completion([]); return }
            completion(tasks)
        }
    }
    
    func fetchTasks(with completion: (([TaskModel])->())) {
        loadTasksWith { (tasks) in
            completion(tasks)
        }
    }
    
    func deleteTask(with id: Int, categoryId: Int, with completion: (_ isCompleted: Bool)->()) {
        fetchCategory(by: categoryId) { category in
            guard let index = category.tasks.enumerated().filter({ $0.element.id == id }).first?.offset else {
                completion(false)
                return
            }

            category.tasks.remove(at: index)
            update(category: category, with: completion)
        }
    }
    
    func fetchTaskWith(id: Int, from categoryId: Int, completion: ((TaskModel?) -> ())) {
        fetchCategory(by: categoryId) { category in
            let task = category.tasks.filter({ $0.id == id }).first
            completion(task)
        }
    }
    
    func update(task: TaskModel, in categoryId: Int, with completion: ((Bool)->())) {
        guard let id = task.id else {
            completion(false)
            return
        }

        fetchCategory(by: categoryId) { category in
            var result = category.tasks
            
            guard let loadedTaskEnum = result.enumerated().filter({ $0.element.id == id }).first else {
                completion(false)
                return
            }
            
            result.remove(at: loadedTaskEnum.offset)
            loadedTaskEnum.element.updateWith(task)
            result.insert(loadedTaskEnum.element, at: loadedTaskEnum.offset)
            
            category.tasks = result
            update(category: category, with: completion)
        }
        
//        loadTasksWith { [weak self] tasks in
//            var result = tasks
//
//            guard let loadedTaskEnum = result.enumerated().filter({ $0.element.id == id }).first else {
//                completion(false)
//                return
//            }
//
//            result.remove(at: loadedTaskEnum.offset)
//            loadedTaskEnum.element.updateWith(task)
//            result.insert(loadedTaskEnum.element, at: loadedTaskEnum.offset)
//
//            self?.save(tasks: result)
//            completion(true)
//        }

    }
    
    // MARK: - Privates
    
    // MARK: Tasks
    
    private func loadTasksWith(completion: (([TaskModel])->())) {
        let data = UserDefaults.standard.object(forKey: Key.tasks) as? NSData
        var tasksArray = [TaskModel]()
        
        if let tasks = data {
            if let currentTasksArray = NSKeyedUnarchiver.unarchiveObject(with: tasks as Data) as? [TaskModel] {
                tasksArray = currentTasksArray
            }
        }
        
        completion(tasksArray)
    }
    
    private func save(tasks: [TaskModel]) {
        let tasksData = NSKeyedArchiver.archivedData(withRootObject: tasks)
        
        UserDefaults.standard.set(tasksData, forKey: Key.tasks)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: Categories
    
    private func loadCategoriesWith(completion: (([CategoryModel])->())) {
        let data = UserDefaults.standard.object(forKey: Key.categories) as? NSData
        var categoriesArray = [CategoryModel]()
        
        if let tasks = data {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: tasks as Data) as? [CategoryModel] {
                categoriesArray = array
            }
        }
        
        completion(categoriesArray)
    }
    
    private func save(categories: [CategoryModel]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: categories)
        
        UserDefaults.standard.set(data, forKey: Key.categories)
        UserDefaults.standard.synchronize()
    }
}
