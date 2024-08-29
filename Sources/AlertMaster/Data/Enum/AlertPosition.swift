//
//  AlertPosition.swift
//  
//
//  Created by Pavel Moslienko on 24.08.2024.
//

import Foundation

/// An enumeration representing the alert position on the screen.
public enum AlertPosition {
    /// Alert at the top of the screen.
    case top(inset: CGFloat)
    /// Alert in the center of the screen.
    case center(inset: CGFloat)
    /// Alert at the bottom of the screen.
    case bottom(inset: CGFloat)
}
