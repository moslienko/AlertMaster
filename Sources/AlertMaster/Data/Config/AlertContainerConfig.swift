//
//  AlertContainerConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for alerts container style.
public struct AlertContainerConfig {
    /// The maximum height of the alert container as a percentage of the screen height.
    public var maxAlertHeightIntPercentage: Float
    /// The insets for the container.
    public var containerInsets: AlertContainerConfig.SideInset
    /// The insets for the components within the container.
    public var componentsInsets: UIEdgeInsets
    /// The spacing between components within the container.
    public var componentsSpacing: CGFloat
    /// The corner radius of the container.
    public var cornerRadius: CGFloat
    /// The width of the container's border.
    public var borderWidth: CGFloat
    /// The background color of the container border.
    public var borderColor: CGColor
    /// The background color of the container.
    public var backgroundColor: UIColor
    /// The background image of the container.
    public var backgroundImage: UIImage?
    /// The parameters for the shadow of the container.
    public var shadowParams: ShadowParams?

    /// Params for alert container insets.
    public struct SideInset {
        public var left: CGFloat
        public var right: CGFloat
        
        public init(left: CGFloat, right: CGFloat) {
            self.left = left
            self.right = right
        }
    }
    
    /// Params for alert container shadows.
    public struct ShadowParams {
        /// The color of the shadow.
        public var shadowColor: CGColor
        /// The opacity of the shadow.
        public var shadowOpacity: Float
        /// The offset of the shadow.
        public var shadowOffset: CGSize
        /// The radius of the shadow.
        public var shadowRadius: CGFloat
        
        /// Initializes a new `ShadowParams` instance with the specified parameters.
        /// - Parameters:
        ///   - shadowColor: The color of the shadow.
        ///   - shadowOpacity: The opacity of the shadow.
        ///   - shadowOffset: The offset of the shadow.
        ///   - shadowRadius: The radius of the shadow.
        public init(shadowColor: CGColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat) {
            self.shadowColor = shadowColor
            self.shadowOpacity = shadowOpacity
            self.shadowOffset = shadowOffset
            self.shadowRadius = shadowRadius
        }
    }
    
    /// Initializes a new `AlertContainerConfig` instance with the specified configuration options.
    /// - Parameters:
    ///   - maxAlertHeightIntPercentage: The maximum height of the alert container as a percentage of the screen height.
    ///   - containerInsets: The insets for the container.
    ///   - componentsInsets: The insets for the components within the container.
    ///   - componentsSpacing: The spacing between components within the container.
    ///   - cornerRadius: The corner radius of the container.
    ///   - borderWidth: The width of the container's border.
    ///   - borderColor: The background color of the container border.
    ///   - backgroundColor: The background color of the container.
    ///   - backgroundImage:  The background image of the container.
    ///   - shadowParams: he parameters for the shadow of the container.
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
