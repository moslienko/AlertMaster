//
//  AlertParams.swift
//  AlertMasterExample
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import Foundation

protocol AlertParamsSegment {
    static var id: Int { get }
    static var groupName: String { get }
    var fieldName: String { get }
}

enum AlertParams {
    
    enum BackgroundContent: Int, CaseIterable, AlertParamsSegment {
        case withBlur = 0
        case withColor = 1
        
        static var id: Int = 101
        static var groupName: String = "Background"
        
        var fieldName: String {
            switch self {
            case .withBlur:
                return "Blur"
            case .withColor:
                return "Color"
            }
        }
    }
    
    enum ContainerContent: Int, CaseIterable, AlertParamsSegment {
        case white = 0
        case red = 1
        
        static var id: Int = 102
        static var groupName: String = "Container"
        
        var fieldName: String {
            switch self {
            case .white:
                return "White, corner 15"
            case .red:
                return "Red, corner 0"
            }
        }
    }
    
    enum CloseButtonContent: Int, CaseIterable, AlertParamsSegment {
        case left = 0
        case right = 1
        case none = 2

        static var id: Int = 103
        static var groupName: String = "Close button"
        
        var fieldName: String {
            switch self {
            case .left:
                return "Btn in left"
            case .right:
                return "Btn in right"
            case .none:
                return "Without btn"
            }
        }
    }
    
    enum ActionButtonsContent: Int, CaseIterable, AlertParamsSegment {
        case horizontal = 0
        case vertical = 1
        case manual = 2
        case none = 3

        static var id: Int = 104
        static var groupName: String = "Action buttons"
        
        var fieldName: String {
            switch self {
            case .horizontal:
                return "Horizontal"
            case .vertical:
                return "Verical"
            case .manual:
                return "Manual"
            case .none:
                return "Without"
            }
        }
    }
}
