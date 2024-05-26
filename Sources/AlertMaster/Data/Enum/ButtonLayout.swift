//
//  ButtonLayout.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import AppViewUtilits
import Foundation

public enum ButtonLayout {
    case auto(buttons: [AppButton], position: ButtonPosition), manual(buttonsGroup: [AlertButtonsGroup]), none
}
