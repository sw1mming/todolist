//
//  UIView+LoadFromNib.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/30/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

extension UIView {

    static var reuseIdentifier: String {
        return className()
    }

    static func nib () -> UINib {
        return UINib.init(nibName: className(), bundle: nil)
    }
    
    static func view () -> AnyObject {
        return Bundle.main.loadNibNamed(self.className(), owner: nil, options: nil)?.first as! UIView
    }

    static func kind() -> String {
        return className()
    }
}
