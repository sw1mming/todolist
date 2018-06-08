//
//  CreateTaskViewController+Protocols.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/1/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import Foundation

// Output
protocol CreateTaskViewOutput: class {
    func viewDidLoad()
    func textDidChange(_ text: String?)
    func createButtonWasTapped()
}

// Input
protocol CreateTaskViewInput: class {
    func enableConfirmButton(_ isEnabled: Bool)
    func close()
}
