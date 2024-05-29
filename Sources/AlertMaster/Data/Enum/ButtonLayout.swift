//
//  ButtonLayout.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import AppViewUtilits
import Foundation

/// An enumeration representing the possible layout grid style for buttons in the alert.
public enum ButtonLayout {
    /// Arrangement at which all buttons in the alert will have the same layout.
    case auto(buttons: [AppButton], position: ButtonPosition)
    /// An arrangement in which each individual group can have its own layout.
    case manual(buttonsGroup: [AlertButtonsGroup])
    /// Without buttons.
    case none
}
