//
//  Extension+NSAttributedString.swift
//
//
//  Created by Pavel Moslienko on 27.05.2024.
//

import UIKit

extension NSAttributedString {
    
    /// Calculates the height of the attributed text.
    /// - Parameters:
    ///   - width: The container width within which the text should be calculated.
    ///   - textView: Text view for displayed this text
    /// - Returns: The height of the text.
    func height(withConstrainedWidth width: CGFloat, textView: UITextView) -> CGFloat {
        let adjustedWidth = width - textView.textContainerInset.left - textView.textContainerInset.right - 2 * textView.textContainer.lineFragmentPadding
        let constraintRect = CGSize(width: adjustedWidth, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        return ceil(boundingBox.height + textView.textContainerInset.top + textView.textContainerInset.bottom)
    }
}
