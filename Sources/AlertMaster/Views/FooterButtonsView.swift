//
//  FooterButtonsView.swift
//
//
//  Created by Pavel Moslienko on 02.05.2024.
//

import UIKit

public class FooterButtonsView: UIView {
    
    // MARK: - Private properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - Public methods
public extension FooterButtonsView {
    
    func addCustomButton(_ button: UIButton, position: ButtonPosition) {
        switch position {
        case .horizontal:
            if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView,
               lastHorizontalStack.arrangedSubviews.count == 2 {
                createNewHorizontalStack()
            }
            
            if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView {
                lastHorizontalStack.addArrangedSubview(button)
            } else {
                createNewHorizontalStack()
                if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView {
                    lastHorizontalStack.addArrangedSubview(button)
                }
            }
        case .vertical:
            createNewHorizontalStack()
            if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView {
                lastHorizontalStack.addArrangedSubview(button)
            }
        }
    }
}

// MARK: - Setup methods
private extension FooterButtonsView {
    
    func setupView() {
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func createNewHorizontalStack() {
        let horizontalStackView = UIStackView()
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        
        mainStackView.addArrangedSubview(horizontalStackView)
    }
}
