//
//  AlertDatePicker.swift
//
//
//  Created by Pavel Moslienko on 25.05.2024.
//

import UIKit

public class AlertDatePicker: UIDatePicker {
    
    // MARK: - Public properties
    public var dateDidChange: ((_ date: Date?) -> Void)?
    
    public enum HeightConstant: CGFloat {
        case wheel = 216.0
    }
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDatePicker()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDatePicker()
    }
}

// MARK: - Actions
private extension AlertDatePicker {
    
    @objc
    func datePickerValueChanged() {
        dateDidChange?(self.date)
    }
}

// MARK: - Setup methods
private extension AlertDatePicker {
    
    func setupDatePicker() {
        self.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
}
