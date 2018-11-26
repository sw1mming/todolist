//
//  Alert.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/28/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

class Alert: UIAlertController {
    
    convenience init(title: String?, confirmClosure: @escaping (()->()), cancelClosure: @escaping (()->())){
        self.init(title: title, positiveTitle: "YES", cancelTitle: "NO", confirmClosure: confirmClosure, cancelClosure: cancelClosure)
    }
    
    convenience init(title: String?,
                     positiveTitle: String, cancelTitle: String,
                     confirmClosure: @escaping (()->()), cancelClosure: @escaping (()->())){
        self.init(title: title, message: nil, preferredStyle: .alert)
        
        self.addAction(UIAlertAction(title: positiveTitle,
                                     style: .default,
                                     handler: { action in confirmClosure() }))
        
        self.addAction(UIAlertAction(title: cancelTitle,
                                     style: .default,
                                     handler: { action in cancelClosure() }))
    }

    convenience init(title: String?, textFieldPlaceholder: String, closure: @escaping ((String)->())) {
//        let alert: UIAlertController = {
            self.init(title: title, message: nil, preferredStyle: .alert)
            self.addTextField { (textField) in
                textField.placeholder = textFieldPlaceholder
            }
            self.addAction(UIAlertAction(title: "Cancel", style: .destructive))
            self.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
                guard let text = self?.textFields?.first?.text, !text.isEmpty else { return }
                closure(text)
//                self?.presenter.createNewCategoryWith(name: text)
            }))
//            return controller
//        }()
        
        
    }

    convenience init(title: String?){
        self.init(title: title, message: nil, preferredStyle: .alert)
        
        self.addAction(UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil))
    }
}
