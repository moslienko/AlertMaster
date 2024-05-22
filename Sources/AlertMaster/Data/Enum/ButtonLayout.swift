//
//  ButtonLayout.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation

public enum ButtonLayout {
    case auto(buttons: [AlertActionButton], position: ButtonPosition), manual(buttonsGroup: [AlertButtonsGroup]), none
}
