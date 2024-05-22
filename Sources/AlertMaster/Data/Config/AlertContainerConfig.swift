//
//  AlertContainerConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for alerts container style
public struct AlertContainerConfig {
    public var backgroundColor: UIColor
    public var cornerRadius: CGFloat
    public var componentsInsets: UIEdgeInsets
    public var componentsSpacing: CGFloat

    public init(
        backgroundColor: UIColor = .white,
        cornerRadius: CGFloat = 15,
        componentsInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: -16.0),
        componentsSpacing: CGFloat = 8.0
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.componentsInsets = componentsInsets
        self.componentsSpacing = componentsSpacing
    }
}
