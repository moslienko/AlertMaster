//
//  AlertActionButton.swift
//
//
//  Created by Pavel Moslienko on 02.05.2024.
//

import UIKit

public class AlertActionButton: UIButton {
    
    // MARK: - Public properties
    public var normalBackgroundColor: UIColor = .blue {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var highlightedBackgroundColor: UIColor = .blue.withAlphaComponent(0.9) {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var normalTextColor: UIColor = .white {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var highlightedTextColor: UIColor = .white.withAlphaComponent(0.9) {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var cornerRadius: CGFloat = 8 {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    public var font: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            titleLabel?.font = font
        }
    }
    
    public var shadowColor: UIColor = .clear {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var shadowOpacity: Float = 0 {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var shadowOffset: CGSize = CGSize(width: 0, height: 2) {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var shadowRadius: CGFloat = 2 {
        didSet {
            updateButtonAppearance()
        }
    }
    
    public var animationDuration: TimeInterval = 0.1
    
    public var highlightedScale: CGFloat = 0.95
    
    public var normalImageTintColor: UIColor?
    
    public var highlightedImageTintColor: UIColor?
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
    
    public var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
        }
    }
    
    public var action: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
}

// MARK: - Actions
private extension AlertActionButton {
    
    @objc
    func onButtonTouchDown() {
        UIView.animate(withDuration: animationDuration) {
            self.transform = CGAffineTransform(scaleX: self.highlightedScale, y: self.highlightedScale)
            self.backgroundColor = self.highlightedBackgroundColor
        }
    }
    
    @objc
    func onButtonTouchUpInside() {
        UIView.animate(withDuration: animationDuration) {
            self.transform = .identity
            self.backgroundColor = self.normalBackgroundColor
        }
        
        self.action?()
    }
    
    @objc
    func onButtonTouchUpOutside() {
        UIView.animate(withDuration: animationDuration) {
            self.transform = .identity
            self.backgroundColor = self.normalBackgroundColor
        }
    }
}

// MARK: - Setup methods
private extension AlertActionButton {
    
    func setupButton() {
        updateButtonAppearance()
        
        addTarget(self, action: #selector(onButtonTouchDown), for: .touchDown)
        addTarget(self, action: #selector(onButtonTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(onButtonTouchUpOutside), for: .touchUpOutside)
    }
    
    func updateButtonAppearance() {
        setTitleColor(normalTextColor, for: .normal)
        setTitleColor(highlightedTextColor, for: .highlighted)
        backgroundColor = normalBackgroundColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        titleLabel?.font = font
        contentEdgeInsets = contentEdgeInsets
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        setTitle(title, for: .normal)
        setImage(image, for: .normal)
        if let normalImageTintColor = normalImageTintColor {
            let normalImage = image?.withRenderingMode(.alwaysTemplate)
            setImage(normalImage, for: .normal)
            tintColor = normalImageTintColor
        }
        if let highlightedImageTintColor = highlightedImageTintColor {
            let highlightedImage = image?.withRenderingMode(.alwaysTemplate)
            setImage(highlightedImage, for: .highlighted)
            tintColor = highlightedImageTintColor
        }
    }
}
