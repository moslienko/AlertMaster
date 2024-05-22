//
//  AlertButtonsConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit

/// Config for alert action buttons
public struct AlertButtonsConfig {
    public var horizontalGridSpacing: CGFloat
    public var verticalGridSpacing: CGFloat
    public var countButtonsInOneRow: Int
    
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
