//
//  UIView+AddAnchor.swift
//  AimprosoftChat
//
//  Created by Sergey Melnik on 4/27/18.
//  Copyright © 2018 aimprosoft. All rights reserved.
//

import UIKit

extension UIView {
    
    func addAnchor(top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil,
                   leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil,
                   padding: UIEdgeInsets = .zero , size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
