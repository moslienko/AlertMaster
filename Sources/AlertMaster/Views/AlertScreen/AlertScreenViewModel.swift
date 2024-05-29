//
//  AlertScreenViewModel.swift
//
//
//  Created by Pavel Moslienko on 29.04.2024.
//

import UIKit

/// View model for alert vc
public class AlertScreenViewModel {
    /// The main alert service instance.
    public var alert: AlertMasterService
    /// The configuration object.
    public var config: AlertConfig
        
    /// Initializes a new instance of the alert view model.
    /// - Parameters:
    ///   - alert: The main alert service instance.
    ///   - config: The configuration object.
    public init(alert: AlertMasterService, config: AlertConfig) {
        self.alert = alert
        self.config = config
    }
}
