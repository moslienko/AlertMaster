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
    public var containerInsets: AlertContainerConfig.SideInset
    public var componentsInsets: UIEdgeInsets
    public var componentsSpacing: CGFloat

    public struct SideInset {
        public var left: CGFloat
        public var right: CGFloat
        
        public init(left: CGFloat, right: CGFloat) {
            self.left = left
            self.right = right
        }
    }
    
    public init(
        backgroundColor: UIColor = .white,
        cornerRadius: CGFloat = 15,
        containerInsets: AlertContainerConfig.SideInset = SideInset(left: 16.0, right: -16.0),
        componentsInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: -16.0, right: -16.0),
        componentsSpacing: CGFloat = 8.0
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.containerInsets = containerInsets
        self.componentsInsets = componentsInsets
        self.componentsSpacing = componentsSpacing
    }
}
