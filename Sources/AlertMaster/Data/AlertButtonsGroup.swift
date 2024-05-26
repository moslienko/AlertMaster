//
//  AlertButtonsGroup.swift
//  
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import AppViewUtilits
import Foundation

/// A group of buttons arranged in a single row in the grid.
public class AlertButtonsGroup {
    /// Specifies the button layout position for this group.
    public var position: ButtonPosition
    /// An array with the buttons displayed in the alert.
    public var buttons: [AppButton]
    
    /// Creating a group of buttons in an alert, with a specified layout position.
    /// - Parameters:
    ///   - position: Specifies the button layout position for this group.
    ///   - buttons: An array with the buttons displayed in the alert.
    public init(position: ButtonPosition, buttons: [AppButton]) {
        self.position = position
        self.buttons = buttons
    }
}
