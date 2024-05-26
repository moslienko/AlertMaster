//
//  AlertComponents.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import AppViewUtilits
import Foundation
import UIKit

public enum AlertComponents {
    case text(value: String, style: DecorateWrapper<UILabel>),
         textView(value: NSAttributedString, style: DecorateWrapper<UITextView>),
         image(_ imageView: UIImageView, height: CGFloat),
         textField(value: String, style: DecorateWrapper<UITextField>, height: CGFloat, callback: ((String?) -> Void)?),
         editedTextView(value: String, style: DecorateWrapper<UITextView>, height: CGFloat, callback: ((String?) -> Void)?),
         timePicker(date: Date, style: DecorateWrapper<UIDatePicker>, height: CGFloat, callback: ((Date?) -> Void)?),
         custom(view: UIView, height: CGFloat)
    
    func createComponent(parentWidth: CGFloat) -> (UIView, CGFloat) {
        switch self {
        case let .text(value, style):
            let label = UILabel()
            label.text = value
            label.apply(style)
            
            let height = value.height(
                withConstrainedWidth: parentWidth,
                font: label.font ?? UIFont.systemFont(ofSize: 14)
            )
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            return (label, height)
        case let .textView(value, style):
            let textView = UITextView()
            textView.attributedText = value
            textView.backgroundColor = .clear
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.apply(style)
            
            let font = value.attribute(.font, at: 0, effectiveRange: nil) as? UIFont ?? UIFont.systemFont(ofSize: 14)
            let height = value.string.height(
                withConstrainedWidth: parentWidth - textView.textContainerInset.left - textView.textContainerInset.right,
                font: font
            )
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            return (textView, height)
        case let .image(imageView, height):
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            return (imageView, height)
        case let .textField(value, style, height, callback):
            let textField = AlertTextField()
            textField.text = value
            (textField as? UITextField)?.apply(style)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            textField.textDidChange = { text in
                callback?(text)
            }
            
            return (textField, height)
        case let .editedTextView(value, style, height, callback):
            let textView = AlertTextView(frame: .zero, textContainer: nil)
            textView.text = value
            (textView as? UITextView)?.apply(style)
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            textView.textDidChange = { text in
                callback?(text)
            }
            
            return (textView, height)
        case let .timePicker(date, style, height, callback):
            let datePicker = AlertDatePicker()
            datePicker.date = date
            (datePicker as? UIDatePicker)?.apply(style)
            datePicker.datePickerMode = .time
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            datePicker.dateDidChange = { date in
                callback?(date)
            }
            
            return (datePicker, height)
        case let .custom(view, height):
            return (view, height)
        }
    }
}
