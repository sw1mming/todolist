//
//  DatePicker.swift
//  Todo List
//
//  Created by Sergey Melnik on 6/26/18.
//  Copyright © 2018 Sergey Melnik. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func didTapDoneButton() -> Date
}

class DatePickerView: UIView {
    
    var delegate: DatePickerDelegate?
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(Strings.doneButtonTitle, for: .normal)
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(doneButton)
        doneButton.addAnchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, size: CGSize(width: 0, height: 40))
        
        addSubview(datePicker)
        datePicker.addAnchor(top: doneButton.bottomAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
    }
}


extension DatePickerView: DatePickerDelegate {
    
    @objc func didTapDoneButton() -> Date {
        return datePicker.date
    }
}
