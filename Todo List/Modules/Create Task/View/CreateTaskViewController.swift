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
    
    private lazy var notificationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [timeButton, deleteNotificationButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var timeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Strings.defaultTimeButtonTitle, for: .normal)
        button.setTitle(Strings.selectedTimeButtonTitle, for: .selected)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapTimeButton), for: .touchUpInside)
        
        return button
    }()

    private lazy var deleteNotificationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "ic_close"), for: .normal)
        button.isHidden = true
        button.addTarget(self, action: #selector(didTapDeleteNotificationButton), for: .touchUpInside)
        
        return button
    }()

    
    private lazy var datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.delegate = self
        
        return view
    }()
    
    
    // MARK: - Properties
    
    var presenter: (CreateTaskViewOutput & NotificationSettingsHandler)!
    
    
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
        
        func setupNotificationStackView() {
            view.addSubview(notificationStackView)
            notificationStackView.addAnchor(top: titleTextField.bottomAnchor,
                                            leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                            padding: UIEdgeInsetsMake(30, 20, 0, 20), size: CGSize(width: 0, height: 40))
        }
        
        func setupConfirmButton() {
            view.addSubview(confirmButton)
            confirmButton.addAnchor(top: notificationStackView.bottomAnchor,
                                    leading: view.leadingAnchor, trailing: view.trailingAnchor,
                                    padding: UIEdgeInsetsMake(50, 20, 0, 20), size: CGSize(width: 0, height: 50))
        }
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupTitleTextField()
        setupNotificationStackView()
        setupConfirmButton()
    }
    
    private func handleAppearancePicker() {
        if datePickerView.isDescendant(of: view) {
            datePickerView.removeFromSuperview()
        } else {
            view.addSubview(datePickerView)
            datePickerView.addAnchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
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
//        handleAppearancePicker()
//        let vc = UIStoryboard(name: NotificationSettingsViewController.className(), bundle: nil).instantiateInitialViewController()!//NotificationSettingsViewController
//        vc.popoverPresentationController?.permittedArrowDirections = .unknown
//        vc.popoverPresentationController?.sourceView = view
//        vc.popoverPresentationController?.sourceRect = CGRect(x: 50, y: 50,
//                                                              width: 300, height: 300)
//        vc.modalPresentationStyle = .overCurrentContext
//        vc.modalTransitionStyle = .crossDissolve
//        vc.present
        present(NotificationSettingsRouter.assembleModuleWith(handler: presenter), animated: true)
//        vc.permittedArrowDirections = UIPopoverArrowDirection.allZeros
    }
    
    @objc private func didTapDeleteNotificationButton(sender: UIButton) {
        presenter.deleteNotification()
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
    
    func showDeleteNotificationButton(_ show: Bool) {
        deleteNotificationButton.isHidden = show
    }
    
    func resetNotification() {
        timeButton.setTitle(Strings.defaultTimeButtonTitle, for: .normal)
    }
    
    func displayTimeButton(title: String) {
        timeButton.setTitle(title, for: .normal)
    }
}

//************************************************************************************
// MARK: - View Input -
//************************************************************************************

extension CreateTaskViewController: DatePickerViewDelegate {
    
    func didTapDoneButton(date: Date) {
        let alert = Alert(title: Strings.notificationAlertTitle,
                          confirmClosure: { [weak self] in
                            self?.handleAppearancePicker()
                            self?.timeButton.setTitle(DateConverter.selected(date), for: .normal)
                            self?.presenter.createNotificationWith(title: self!.titleTextField.text ?? String(), date: date)
        },
                          cancelClosure: {})
        
        present(alert, animated: true, completion: nil)
    }
}
