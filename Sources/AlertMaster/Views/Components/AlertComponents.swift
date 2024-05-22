//
//  AlertComponents.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

public enum AlertComponents {
    case text(value: String, textAlignment: NSTextAlignment = .left), image(_ image: UIImage, height: CGFloat), custom(view: UIView, height: CGFloat)
    
    func createComponent(for parentView: UIView) -> (UIView, CGFloat) {
        switch self {
        case let .text(value, textAlignment):
            
            let label = UILabel()
            label.text = value
            label.textColor = .black
            label.numberOfLines = 0
            label.textAlignment = textAlignment
            label.backgroundColor = .clear
            
            let height = value.height(withConstrainedWidth: parentView.bounds.width, font: label.font!)
            
            return (label, height)
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
