//
//  NotificationSettingsViewController.swift
//  Todo List
//
//  Created by Sergey Melnik on 7/16/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit


//************************************************************************************
// MARK: - Notification Settings View -
//************************************************************************************

class NotificationSettingsViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var clearButton: UIButton!
    
    var presenter: NotificationSettingsViewOutput!
    
    private lazy var datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.delegate = self
        
        return view
    }()

    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        clearButton.isHidden = true
        setupPressOn(view: titleLabel)
    }
    
    // MARK: - Privates
    
    private func setupPressOn(view: UIView) {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectTime)))
    }
    
    private func handleAppearancePicker() {
        if datePickerView.isDescendant(of: view) {
            datePickerView.removeFromSuperview()
        } else {
            view.addSubview(datePickerView)
            datePickerView.addAnchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didSelectConfirmButton(_ sender: Any) {
        presenter.didSelectConfirm()
        dismiss(animated: true)
    }
    
    @IBAction func didSelectClearButton(_ sender: Any) {
    }
    
    @objc func didSelectTime() {
        handleAppearancePicker()
    }
}


//************************************************************************************
// MARK: - Date Picker View Delegate -
//************************************************************************************

extension NotificationSettingsViewController: DatePickerViewDelegate {
    
    func didTapDoneButton(date: Date) {
        titleLabel.text = DateConverter.selected(date)
        handleAppearancePicker()
        presenter.didChoose(date: date)
    }
}
