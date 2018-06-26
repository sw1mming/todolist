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
    
    private lazy var timeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Strings.defaultTimeButtonTitle, for: .normal)
        button.setTitle(Strings.selectedTimeButtonTitle, for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        return button
    }()


    private var datePickerView: DatePickerView = {
        let view = DatePickerView()
//        view.delegate
        return view
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        return picker
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
            titleTextField.addAnchor(top: navigationBar.safeAreaLayoutGuide.bottomAnchor,
                                     leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                     padding: UIEdgeInsetsMake(50, 20, 0, 20))
        }
        
        func setupTimeButton() {
            view.addSubview(timeButton)
            timeButton.addAnchor(top: titleTextField.bottomAnchor,
                                 leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                 padding: UIEdgeInsetsMake(30, 20, 0, 20), size: CGSize(width: 0, height: 40))
        }
        
        func setupConfirmButton() {
            view.addSubview(confirmButton)
            confirmButton.addAnchor(top: timeButton.bottomAnchor,
                                    leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                    padding: UIEdgeInsetsMake(50, 20, 0, 20), size: CGSize(width: 0, height: 50))
        }
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleTextField()
        setupTimeButton()
        setupConfirmButton()
    }
    
    private func handleAppearancePicker() {
        if datePicker.isDescendant(of: view) {
            datePicker.removeFromSuperview()
        } else {
            view.addSubview(datePicker)
            datePicker.addAnchor(bottom: view.bottomAnchor)
        }

        timeButton.isSelected = !timeButton.isSelected
    }
    
    
    // MARK: - Selectors
    
    @objc private func textDidChanged() {
        presenter.textDidChange(titleTextField.text)
    }
    
    @objc private func didTapConfirmButton(sender: UIButton) {
        presenter.createButtonWasTapped()
    }
    
    @objc private func dismissScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapTimeButton(sender: UIButton) {
        view.endEditing(true)
        handleAppearancePicker()
    }
    
    @objc private func dateDidChange(sender: UIDatePicker) {
        handleAppearancePicker()
        timeButton.setTitle(DateConverter.selected(sender.date), for: .normal)
        presenter.createNotificationWith(title: titleTextField.text ?? String(), date: sender.date)
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

