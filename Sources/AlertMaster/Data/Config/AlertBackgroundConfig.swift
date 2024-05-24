//
//  AlertBackgroundConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for parent window style
public struct AlertBackgroundConfig {
    public var isNeedBlur: Bool
    public var blurStyle: UIBlurEffect.Style
    public var backgroundColor: UIColor
    public var backgroundImage: UIImage?

    public init(
        isNeedBlur: Bool = false,
        blurStyle: UIBlurEffect.Style = .regular,
        backgroundColor: UIColor = .black.withAlphaComponent(0.5),
        backgroundImage: UIImage? = nil
    ) {
        self.isNeedBlur = isNeedBlur
        self.blurStyle = blurStyle
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
    }
}
