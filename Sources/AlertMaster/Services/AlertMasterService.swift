//
//  AlertMasterService.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit
import AppViewUtilits

/// The main alert service through which it is configured and its lifecycle is managed.
public class AlertMasterService {
    
    // MARK: - Public properties
    /// UI components that inluded in content of the alert.
    public var components: [AlertComponents]
    /// Action buttons specified in the alert and the layout to display them.
    public var buttonsLayout: ButtonLayout
    /// Called when the dismiss button is tapped and alert is dismissed.
    public var didDismissButtonTapped: (() -> Void)?
    
    // MARK: - Private properties
    private let screen = AlertScreenViewController()
    
    /// Init alert service.
    /// - Parameters:
    ///   - components: UI components that inluded in content of the alert.
    ///   - buttonsLayout: Action buttons specified in the alert and the layout to display them.
    public init(
        components: [AlertComponents],
        buttonsLayout: ButtonLayout
    ) {
        self.components = components
        self.buttonsLayout = buttonsLayout
    }
    
    /// Presents the alert in the specified view controller with the given configuration.
    /// - Parameters:
    ///   - controller: Specifies the view controller where the alert will be presented.
    ///   - config: Alert's configuration.
    public func show(in controller: UIViewController, with config: AlertConfig) {
        screen.model = AlertScreenViewModel(alert: self, config: config)
        screen.model?.didDismissButtonTapped = {
            self.didDismissButtonTapped?()
        }
        screen.modalPresentationStyle = .overFullScreen
        
        DispatchQueue.main.async {
            controller.present(self.screen, animated: false)
        }
    }
    
    /// Dismisses the alert and calls the optional completion handler after dismissal.
    /// - Parameter finished: An optional closure to be executed after the alert is dismissed.
    public func dismiss(finished: (() -> Void)? = nil) {
        screen.hideView {
            self.screen.dismiss(animated: false, completion: nil)
            finished?()
        }
    }
}
