//
//  AlertTextView.swift
//
//
//  Created by Pavel Moslienko on 25.05.2024.
//

import AppViewUtilits
import UIKit

class AlertTextView: UITextView {
    
    // MARK: - Public properties
    public var textDidChange: ((_ text: String?) -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextView()
    }
}

// MARK: - Actions
private extension AlertTextView {
    
    @objc
    func textFieldDidChange() {
        textDidChange?(self.text)
    }
}

// MARK: - Setup methods
private extension AlertTextView {
    
    func setupTextView() {
        self.delegate = self
    }
}

// MARK: - UITextViewDelegate
extension AlertTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.textDidChange?(textView.text)
    }
}
