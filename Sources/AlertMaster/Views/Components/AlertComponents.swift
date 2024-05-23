//
//  AlertComponents.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

public enum AlertComponents {
    case text(value: String, textAlignment: NSTextAlignment = .left),
         textView(value: NSAttributedString, textAlignment: NSTextAlignment = .left),
         image(_ image: UIImage, height: CGFloat),
         custom(view: UIView, height: CGFloat)
    
    func createComponent(parentWidth: CGFloat) -> (UIView, CGFloat) {
        switch self {
        case let .text(value, textAlignment):
            let label = UILabel()
            label.text = value
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = textAlignment
            label.backgroundColor = .clear
            
            let height = value.height(
                withConstrainedWidth: parentWidth,
                font: label.font ?? UIFont.systemFont(ofSize: 14)
            )
            
            return (label, height)
        case let .textView(value, textAlignment):
            let textView = UITextView()
            textView.attributedText = value
            textView.isEditable = false
            textView.isScrollEnabled = false
            textView.textAlignment = textAlignment
            textView.backgroundColor = .clear
            
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
