//
//  DatePicker.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/26/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate {
    func didTapDoneButton(date: Date)
}

//************************************************************************************
// MARK: - Date Picker View -
//************************************************************************************

class DatePickerView: UIView {
    
    // MARK: Properties
    
    var delegate: DatePickerViewDelegate?
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        
        return picker
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.doneButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        
        return button
    }()

    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = UIColor.red.withAlphaComponent(0.5)
        addSubview(doneButton)
        doneButton.addAnchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: CGSize(width: 0, height: 40))
        
        addSubview(datePicker)
        datePicker.addAnchor(top: doneButton.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
    
    // MARK: - Selectors
    
    @objc func didTapDoneButton() {
        delegate?.didTapDoneButton(date: datePicker.date)
    }
}
