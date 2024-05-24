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
         image(_ image: UIImage, height: CGFloat),
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
            
            return (textView, height)
        case let .image(img, height):
            let imageView = UIImageView(image: img)
            imageView.contentMode = .scaleAspectFit
            imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
            
            return (imageView, height)
        case let .custom(view, height):
            return (view, height)
        }
    }
}
