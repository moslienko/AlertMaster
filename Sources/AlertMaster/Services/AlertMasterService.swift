//
//  AlertMasterService.swift
//
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation
import UIKit
import AppViewUtilits

public class AlertMasterService {
    
    public var components: [AlertComponents]
    public var buttonsLayout: ButtonLayout
    public var didDismissButtonTapped: (() -> Void)?

    private let screen = AlertScreenViewController()
    
    public let headerStyle: DecorateWrapper<UILabel> = .wrap(style: { _ in
        
    })
        
    public init(
        components: [AlertComponents],
        buttonsLayout: ButtonLayout
    ) {
        self.components = components
        self.buttonsLayout = buttonsLayout
    }
    
    public func show(in controller: UIViewController, with config: AlertConfig) {
        screen.model = AlertScreenViewModel(alert: self, config: config)
        screen.model?.didDismissButtonTapped = {
            self.didDismissButtonTapped?()
        }
        screen.modalPresentationStyle = .overFullScreen
        
        DispatchQueue.main.async {
            controller.present(self.screen, animated: true)
        }
    }
    
    public func dismiss(finished: (() -> Void)? = nil) {
        screen.hideView {
            self.screen.dismiss(animated: false, completion: nil)
            finished?()
        }
    }
}
