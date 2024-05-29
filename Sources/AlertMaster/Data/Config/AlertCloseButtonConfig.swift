//
//  AlertCloseButtonConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for alert dismiss buttom style.
public struct AlertCloseButtonConfig {
    /// A Boolean value indicating whether the close button should be shown in the alert.
    public var isShowCloseButton: Bool
    /// The icon image for the close button.
    public var icon: UIImage
    /// The tint color for the close button.
    public var tintColor: UIColor
    /// The size of the close button.
    public var size: CGSize
    /// The position of the close button within the alert.
    public var position: Position
    
    /// Params for close button insets.
    public struct PositionInset {
        public var top: CGFloat
        public var side: CGFloat
        
        public init(top: CGFloat, side: CGFloat) {
            self.top = top
            self.side = side
        }
    }
    
    /// Layout position for close button.
    public enum Position {
        case left(inset: PositionInset), right(inset: PositionInset)
    }
    
    /// Initializes a new `AlertCloseButtonConfig` instance with the specified configuration options.
    /// - Parameters:
    ///   - isShowCloseButton: A Boolean value indicating whether the close button should be shown in the alert.
    ///   - icon: The icon image for the close button.
    ///   - tintColor: The tint color for the close button.
    ///   - size: The size of the close button.
    ///   - position: The position of the close button within the alert.
    public init(
        isShowCloseButton: Bool = true,
        icon: UIImage = AlertCloseButtonConfig.defaultIcon ?? UIImage(),
        tintColor: UIColor = .black,
        size: CGSize = CGSize(width: 40.0, height: 40.0),
        position: Position = .right(inset: PositionInset(top: 16.0, side: -16.0))
    ) {
        self.isShowCloseButton = isShowCloseButton
        self.icon = icon
        self.tintColor = tintColor
        self.size = size
        self.position = position
    }
    
    /// Default close button icon
    public static var defaultIcon: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "xmark.circle.fill")
        } else {
            return UIImage(named: "close")
        }
    }
}
