//
//  AlertConfig.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation

/// Basic config.
public struct AlertConfig {
    /// Config for parent window style.
    public var backgroundConfig: AlertBackgroundConfig
    /// Config for alert dismiss buttom style.
    public var closeButtonConfig: AlertCloseButtonConfig
    /// Config for alerts container style.
    public var containerConfig: AlertContainerConfig
    /// Config for alert action buttons.
    public var buttonsConfig: AlertButtonsConfig
    /// Animation class that allows you to customize the appearance and closing animations of the alert.
    public var presentableService: AlertScreenPresentable
    
    /// Initializes a new `AlertConfig` instance with the specified configuration options.
    /// - Parameters:
    ///   - backgroundConfig: Config for parent window style.
    ///   - closeButtonConfig: onfig for alert dismiss buttom style.
    ///   - containerConfig: Config for alerts container style.
    ///   - buttonsConfig: Config for alert action buttons.
    ///   - presentableService: Animation class that allows you to customize the appearance and closing animations of the alert.
    public init(
        backgroundConfig: AlertBackgroundConfig = AlertBackgroundConfig(),
        closeButtonConfig: AlertCloseButtonConfig = AlertCloseButtonConfig(),
        containerConfig: AlertContainerConfig = AlertContainerConfig(),
        buttonsConfig: AlertButtonsConfig = AlertButtonsConfig(),
        presentableService: AlertScreenPresentable = AlertScreenPresentation()
    ) {
        self.backgroundConfig = backgroundConfig
        self.closeButtonConfig = closeButtonConfig
        self.containerConfig = containerConfig
        self.buttonsConfig = buttonsConfig
        self.presentableService = presentableService
    }
}
