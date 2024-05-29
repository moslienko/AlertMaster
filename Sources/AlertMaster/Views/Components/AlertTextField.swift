//
//  AlertTextField.swift
//
//
//  Created by Pavel Moslienko on 25.05.2024.
//

import UIKit

class AlertTextField: UITextField {
    
    // MARK: - Public properties
    public var textDidChange: ((_ text: String?) -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
}

// MARK: - Actions
private extension AlertTextField {
    
    @objc
    func textFieldDidChange() {
        textDidChange?(self.text)
    }
}

// MARK: - Setup methods
private extension AlertTextField {
    
    func setupTextField() {
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}
