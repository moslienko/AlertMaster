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
        case image = 2

        static var id: Int = 101
        static var groupName: String = "Background"
        
        var fieldName: String {
            switch self {
            case .withBlur:
                return "Blur"
            case .withColor:
                return "Color"
            case .image:
                return "Image"
            }
        }
    }
    
    enum ContainerContent: Int, CaseIterable, AlertParamsSegment {
        case white = 0
        case border = 1
        case image = 2
        
        static var id: Int = 102
        static var groupName: String = "Container"
        
        var fieldName: String {
            switch self {
            case .white:
                return "White"
            case .border:
                return "Border, shadow"
            case .image:
                return "With image"
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
    
    enum AnimationContent: Int, CaseIterable, AlertParamsSegment {
        case `default` = 0
        case zoom = 1
        case slide = 2
        case rotate = 3

        static var id: Int = 105
        static var groupName: String = "Animation"
        
        var fieldName: String {
            switch self {
            case .default:
                return "Default"
            case .zoom:
                return "Zoom"
            case .slide:
                return "Slide"
            case .rotate:
                return "Rotate"
            }
        }
    }
    
    enum ComponentsContent: Int, CaseIterable, AlertParamsSegment {
        case variantOne = 0
        case variantTwo = 1
        case textField = 2
        case textView = 3
        case datePicker = 4

        static var id: Int = 106
        static var groupName: String = "Components"
        
        var fieldName: String {
            switch self {
            case .variantOne:
                return "#1"
            case .variantTwo:
                return "#2"
            case .textField:
                return "Text field"
            case .textView:
                return "Text view"
            case .datePicker:
                return "Date picker"
            }
        }
    }
}
