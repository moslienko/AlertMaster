//
//  AlertButtonsGroup.swift
//  
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation

public class AlertButtonsGroup {
    public var position: ButtonPosition
    public var buttons: [AlertActionButton]
    
    public init(position: ButtonPosition, buttons: [AlertActionButton]) {
        self.position = position
        self.buttons = buttons
    }
}
