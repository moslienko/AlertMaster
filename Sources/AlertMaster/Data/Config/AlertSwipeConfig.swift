//
//  AlertSwipeConfig.swift
//
//
//  Created by Pavel Moslienko on 25.08.2024.
//

import UIKit

/// Config for swiping on the alert container.
public struct AlertSwipeConfig {
    ///  A Boolean value indicating whether the alert can be closed by swiping on it.
    public var isAllowSwipeForDismiss: Bool
    /// Minimum distance at which you can swipe the alert to the other side (for the bounce effect).
    public var insetForBounceInOtherDir: CGFloat
    /// Minimum distance at which the alert will be closed.
    public var minInsetForDismiss: CGFloat
    
    /// Initializes a new `AlertSwipeConfig` instance with the specified configuration options.
    /// - Parameters:
    ///   - isAllowSwipeForDismiss: A Boolean value indicating whether the alert can be closed by swiping on it.
    ///   - insetForBounceInOtherDir: Minimum distance at which you can swipe the alert to the other side (for the bounce effect).
    ///   - minInsetForDismiss: Minimum distance at which the alert will be closed.
    public init(
        isAllowSwipeForDismiss: Bool = true,
        insetForBounceInOtherDir: CGFloat = 25.0,
        minInsetForDismiss: CGFloat = 100
    ) {
        self.isAllowSwipeForDismiss = isAllowSwipeForDismiss
        self.insetForBounceInOtherDir = insetForBounceInOtherDir
        self.minInsetForDismiss = minInsetForDismiss
    }
    
}
