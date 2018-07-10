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
        self.init(title: title, message: nil, preferredStyle: .alert)
        
        self.addAction(UIAlertAction(title: "YES",
                                     style: UIAlertActionStyle.default,
                                     handler: { action in
                                        confirmClosure()
        }))
        
        self.addAction(UIAlertAction(title: "NO",
                                     style: UIAlertActionStyle.default,
                                     handler: { action in
                                        cancelClosure()
        }))
    }
    
    convenience init(title: String?){
        self.init(title: title, message: nil, preferredStyle: .alert)
    }
}
