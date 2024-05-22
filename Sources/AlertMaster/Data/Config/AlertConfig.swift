//
//  AlertConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation

/// Basic config
public struct AlertConfig {
    public var backgroundConfig: AlertBackgroundConfig
    public var closeButtonConfig: AlertCloseButtonConfig
    public var containerConfig: AlertContainerConfig
    
    public init(
        backgroundConfig: AlertBackgroundConfig = AlertBackgroundConfig(),
        closeButtonConfig: AlertCloseButtonConfig = AlertCloseButtonConfig(),
        containerConfig: AlertContainerConfig = AlertContainerConfig()
    ) {
        self.backgroundConfig = backgroundConfig
        self.closeButtonConfig = closeButtonConfig
        self.containerConfig = containerConfig
    }
}
