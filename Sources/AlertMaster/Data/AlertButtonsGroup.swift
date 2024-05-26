//
//  AlertButtonsGroup.swift
//  
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import AppViewUtilits
import Foundation

public class AlertButtonsGroup {
    public var position: ButtonPosition
    public var buttons: [AppButton]
    
    public init(position: ButtonPosition, buttons: [AppButton]) {
        self.position = position
        self.buttons = buttons
    }
}
