//
//  AlertButtonsConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for alert action buttons.
public struct AlertButtonsConfig {
    /// The horizontal spacing between buttons in the grid layout.
    public var horizontalGridSpacing: CGFloat
    /// The vertical spacing between buttons in the grid layout.
    public var verticalGridSpacing: CGFloat
    /// The maximum number of buttons to display in a single row of the grid layout.
    public var countButtonsInOneRow: Int
    
    /// Initializes a new `AlertButtonsConfig` instance with the specified configuration options.
    /// - Parameters:
    ///   - horizontalGridSpacing: The horizontal spacing between buttons in the grid layout.
    ///   - verticalGridSpacing: The vertical spacing between buttons in the grid layout.
    ///   - countButtonsInOneRow: The maximum number of buttons to display in a single row of the grid layout.
    public init(
        horizontalGridSpacing: CGFloat = 10.0,
        verticalGridSpacing: CGFloat = 10.0,
        countButtonsInOneRow: Int = 2
    ) {
        self.horizontalGridSpacing = horizontalGridSpacing
        self.verticalGridSpacing = verticalGridSpacing
        self.countButtonsInOneRow = countButtonsInOneRow
    }
}
