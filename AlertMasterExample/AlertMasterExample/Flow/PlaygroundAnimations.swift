//
//  PlaygroundAnimations.swift
//  AlertMasterExample
//
//  Created by Pavel Moslienko on 24.05.2024.
//

import AlertMaster
import Foundation
import UIKit

class PlaygroundAnimations {
    
    class RotatePresentable: AlertScreenPresentable {
        
        func showView(backgroundView: UIView, alertView: UIView) {
            alertView.transform = CGAffineTransform(rotationAngle: .pi / 2)
            alertView.alpha = 0.0
            UIView.animate(withDuration: 0.35) {
                backgroundView.alpha = 1.0
                alertView.transform = CGAffineTransform.identity
                alertView.alpha = 1.0
            }
        }

        public func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?) {
            UIView.animate(withDuration: 0.35, animations: {
                backgroundView.alpha = 0.0
                alertView.transform = CGAffineTransform(rotationAngle: .pi / 2)
                alertView.alpha = 0.0
            }) { _ in
                finished?()
            }
        }
    }
    
    class ZoomPresentable: AlertScreenPresentable {
        
        func showView(backgroundView: UIView, alertView: UIView) {
            alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            alertView.alpha = 0.0
            UIView.animate(withDuration: 0.35) {
                backgroundView.alpha = 1.0
                alertView.transform = CGAffineTransform.identity
                alertView.alpha = 1.0
            }
        }

        func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?) {
            UIView.animate(withDuration: 0.35, animations: {
                backgroundView.alpha = 0.0
                alertView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                alertView.alpha = 0.0
            }) { _ in
                finished?()
            }
        }
    }
    
    class SlidePresentable: AlertScreenPresentable {
        
        func showView(backgroundView: UIView, alertView: UIView) {
            alertView.transform = CGAffineTransform(translationX: 0, y: -backgroundView.bounds.height)
            UIView.animate(withDuration: 0.35) {
                backgroundView.alpha = 1.0
                alertView.alpha = 1.0
                alertView.transform = CGAffineTransform.identity
            }
        }

        func hideView(backgroundView: UIView, alertView: UIView, finished: (() -> Void)?) {
            UIView.animate(withDuration: 0.35, animations: {
                backgroundView.alpha = 0.0
                alertView.transform = CGAffineTransform(translationX: 0, y: -backgroundView.bounds.height)
            }) { _ in
                finished?()
            }
        }
    }
}
