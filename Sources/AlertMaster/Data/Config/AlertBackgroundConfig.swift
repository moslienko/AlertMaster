//
//  AlertBackgroundConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for parent window style.
public struct AlertBackgroundConfig {
    /// A Boolean value indicating whether tapping on the background should dismiss the alert.
    public var isAllowTapForDismiss: Bool
    /// A Boolean value indicating whether to apply a blur effect to the background.
    public var isNeedBlur: Bool
    /// The style of the blur effect to be applied to the background.
    public var blurStyle: UIBlurEffect.Style
    /// The background color of the alert.
    public var backgroundColor: UIColor
    /// An optional background image to be displayed behind the alert.
    public var backgroundImage: UIImage?
    
    /// Initializes a new `AlertBackgroundConfig` instance with the specified configuration options.
    /// - Parameters:
    ///   - isAllowTapForDismiss: A Boolean value indicating whether tapping on the background should dismiss the alert.
    ///   - isNeedBlur: A Boolean value indicating whether to apply a blur effect to the background.
    ///   - blurStyle: The style of the blur effect to be applied to the background.
    ///   - backgroundColor: The background color of the alert.
    ///   - backgroundImage: An optional background image to be displayed behind the alert.
    public init(
        isAllowTapForDismiss: Bool = false,
        isNeedBlur: Bool = false,
        blurStyle: UIBlurEffect.Style = .regular,
        backgroundColor: UIColor = .black.withAlphaComponent(0.5),
        backgroundImage: UIImage? = nil
    ) {
        self.isAllowTapForDismiss = isAllowTapForDismiss
        self.isNeedBlur = isNeedBlur
        self.blurStyle = blurStyle
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }
}
