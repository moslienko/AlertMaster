//
//  AlertScreenViewModel.swift
//
//
//  Created by Pavel Moslienko on 29.04.2024.
//

import UIKit

public class AlertScreenViewModel {
    public var alert: AlertMasterService
    public var config: AlertConfig
    
    var didDismissButtonTapped: (() -> Void)?
    
    public init(alert: AlertMasterService, config: AlertConfig) {
        self.alert = alert
        self.config = config
    }
}
