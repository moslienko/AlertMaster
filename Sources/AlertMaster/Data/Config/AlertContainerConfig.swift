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
    public var maxAlertHeightIntPercentage: Float
    public var containerInsets: AlertContainerConfig.SideInset
    public var componentsInsets: UIEdgeInsets
    public var componentsSpacing: CGFloat
    public var cornerRadius: CGFloat
    public var borderWidth: CGFloat
    public var borderColor: CGColor
    public var backgroundColor: UIColor
    public var backgroundImage: UIImage?
    public var shadowParams: ShadowParams?

    public struct SideInset {
        public var left: CGFloat
        public var right: CGFloat
        
        public init(left: CGFloat, right: CGFloat) {
            self.left = left
            self.right = right
        }
    }
    
    public struct ShadowParams {
        public var shadowColor: CGColor
        public var shadowOpacity: Float
        public var shadowOffset: CGSize
        public var shadowRadius: CGFloat
        
        public init(shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
            self.shadowColor = shadowColor
            self.shadowOpacity = shadowOpacity
            self.shadowOffset = shadowOffset
            self.shadowRadius = shadowRadius
        }
    }
    
    public init(
        maxAlertHeightIntPercentage: Float = 66.0,
        containerInsets: AlertContainerConfig.SideInset = SideInset(left: 16.0, right: -16.0),
        componentsInsets: UIEdgeInsets = UIEdgeInsets(top: 16.0, left: 16.0, bottom: -16.0, right: -16.0),
        componentsSpacing: CGFloat = 8.0,
        cornerRadius: CGFloat = 15,
        borderWidth: CGFloat = 0.0,
        borderColor: CGColor = UIColor.clear.cgColor,
        backgroundColor: UIColor = .white,
        backgroundImage: UIImage? = nil,
        shadowParams: AlertContainerConfig.ShadowParams? = nil
    ) {
        self.maxAlertHeightIntPercentage = maxAlertHeightIntPercentage
        self.containerInsets = containerInsets
        self.componentsInsets = componentsInsets
        self.componentsSpacing = componentsSpacing
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.shadowParams = shadowParams
    }
}
