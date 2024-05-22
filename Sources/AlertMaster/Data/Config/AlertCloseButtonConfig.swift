//
//  AlertCloseButtonConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for alert dismiss buttom style
public struct AlertCloseButtonConfig {
    public var isShowCloseButton: Bool
    public var icon: UIImage
    public var size: CGSize
    public var position: Position
    
    public struct PositionInset {
        public var top: CGFloat
        public var side: CGFloat
        
        public init(top: CGFloat, side: CGFloat) {
            self.top = top
            self.side = side
        }
    }
    
    public enum Position {
        case left(inset: PositionInset), right(inset: PositionInset)
    }
    
    public init(
        isShowCloseButton: Bool = true,
        icon: UIImage = AlertCloseButtonConfig.defaultIcon ?? UIImage(),
        size: CGSize = CGSize(width: 44.0, height: 44.0),
        position: Position = .right(inset: PositionInset(top: 16.0, side: -16.0))
    ) {
        self.isShowCloseButton = isShowCloseButton
        self.icon = icon
        self.size = size
        self.position = position
    }
    
    public static var defaultIcon: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "xmark.circle.fill")
        } else {
            return UIImage(named: "close")
        }
    }
}
