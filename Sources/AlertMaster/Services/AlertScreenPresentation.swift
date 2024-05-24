//
//  AlertScreenPresentation.swift
//  
//
//  Created by Pavel Moslienko on 24.05.2024.
//

import UIKit

public protocol AlertScreenPresentable {
    func showView(backgroundView: UIView, alertView: UIView)
    func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?)
}

public class AlertScreenPresentation: AlertScreenPresentable {
    
    public init() {}
    
    public func showView(backgroundView: UIView, alertView: UIView) {
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
