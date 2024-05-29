//
//  AlertScreenPresentation.swift
//  
//
//  Created by Pavel Moslienko on 24.05.2024.
//

import UIKit

/// A protocol that allows you to customize the animations of the appearance and closing of the alert.
public protocol AlertScreenPresentable {
    /// Animate the appearance of the alert.
    /// - Parameters:
    ///   - backgroundView: The alert background view.
    ///   - alertView: The alert container, which contains all its components directly.
    func showView(backgroundView: UIView, alertView: UIView)
    /// Animate the closing of the alert.
    /// - Parameters:
    ///   - backgroundView: The alert background view.
    ///   - alertView: The alert container, which contains all its components directly.
    ///   - finished: An optional closure that is called after the animation completes.
    func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?)
}

/// An out-of-the-box animation that allows you to customize the appearance and closing animations of the alert.
public class AlertScreenPresentation: AlertScreenPresentable {
    
    public init() {}
    
    public func showView(backgroundView: UIView, alertView: UIView) {
        alertView.alpha = 0.0
        backgroundView.alpha = 0.0
        UIView.animate(withDuration: 0.35) {
            backgroundView.alpha = 1.0
            alertView.alpha = 1
        }
    }
    
    public func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?) {
        UIView.animate(withDuration: 0.35) {
            backgroundView.alpha = 0.0
            alertView.alpha = 0
        } completion: { _ in
            finished?()
        }
    }
}
