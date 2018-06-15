//
//  CreateTaskViewController.swift
//  Todo List
//
//  Created by Sergey Melnik on 5/31/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Create Task View -
//************************************************************************************

class CreateTaskViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private var navigationBar: UINavigationBar = {
        let bar = UINavigationBar()
        bar.setBackgroundImage(UIImage(), for: .default)
        
        let item = UINavigationItem()
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_close"), style: .plain, target: self, action: #selector(dismissScreen))
        button.tintColor = .white
        
        item.setLeftBarButton(button, animated: true)
        
        item.title = "Create task"
        
        bar.items = [item]
        bar.tintColor = .white
        
        return bar
    }()
    
    private var titleTextField: UITextField = {
        let textField = UITextField()
        textField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        textField.placeholder = "Enter name of task"
        textField.borderStyle = .line
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        
        return textField
    }()
    
    private var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10.0
        button.isEnabled = false
        
        return button
    }()
    
    // MARK: - Properties
    
    var presenter: CreateTaskViewOutput!
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        presenter.viewDidLoad()
    }
    
    
    // MARK: - Privates
    
    private func setupDefaults() {
        func setupNavigationBar() {
            view.addSubview(navigationBar)
            
            navigationBar.addAnchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil,
                                    leading: view.leadingAnchor, trailing: view.trailingAnchor)
        }
        
        func setupTitleTextField() {
            view.addSubview(titleTextField)
            titleTextField.addAnchor(top: navigationBar.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsetsMake(50, 20, 0, 20))
        }
        
        func setupConfirmButton() {
            view.addSubview(confirmButton)
            confirmButton.addAnchor(top: titleTextField.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsetsMake(50, 20, 0, 20), size: CGSize(width: 0, height: 50))
        }
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleTextField()
        setupConfirmButton()
    }
    
    
    // MARK: - Selectors
    
    @objc private func textDidChanged() {
        presenter.textDidChange(titleTextField.text)
    }
    
    @objc private func didTapConfirmButton() {
        presenter.createButtonWasTapped()
    }
    
    @objc private func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
}

//************************************************************************************
// MARK: - View Input -
//************************************************************************************

extension CreateTaskViewController: CreateTaskViewInput {
    
    func enableConfirmButton(_ isEnabled: Bool) {
        confirmButton.isEnabled = isEnabled
    }
    
    func close() {
        dismissScreen()
    }
}

