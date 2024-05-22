//
//  FooterButtonsView.swift
//
//
//  Created by Pavel Moslienko on 02.05.2024.
//

import UIKit

public class FooterButtonsView: UIView {
    
    var buttonsConfig = AlertButtonsConfig()
    
    // MARK: - Private properties
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = buttonsConfig.verticalGridSpacing
        
        return stackView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        self.buttonsConfig = AlertButtonsConfig()
        super.init(frame: frame)
        setupView()
    }
    
    init(frame: CGRect, buttonsConfig: AlertButtonsConfig) {
        self.buttonsConfig = buttonsConfig
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.buttonsConfig = AlertButtonsConfig()
        super.init(coder: coder)
        setupView()
    }
}

// MARK: - Public methods
public extension FooterButtonsView {
    
    func addCustomGroups(_ groups: [AlertButtonsGroup]) {
        groups.forEach({ group in
            switch group.position {
            case .horizontal:
                createNewHorizontalStack()
                group.buttons.forEach({ button in
                    if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView {
                        lastHorizontalStack.addArrangedSubview(button)
                    }
                })
            case .vertical:
                createNewVerticalStack()
                group.buttons.forEach({ button in
                    if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView {
                        lastHorizontalStack.addArrangedSubview(button)
                    }
                })
            }
        })
    }
    
    func addCustomButton(_ button: UIButton, position: ButtonPosition) {
        switch position {
        case .horizontal:
            if let lastHorizontalStack = mainStackView.arrangedSubviews.last as? UIStackView,
               lastHorizontalStack.arrangedSubviews.count == buttonsConfig.countButtonsInOneRow {
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
        horizontalStackView.spacing = buttonsConfig.horizontalGridSpacing
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        
        mainStackView.addArrangedSubview(horizontalStackView)
    }
    
    func createNewVerticalStack() {
        let horizontalStackView = UIStackView()
        
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .vertical
        horizontalStackView.spacing = buttonsConfig.verticalGridSpacing
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        
        mainStackView.addArrangedSubview(horizontalStackView)
    }
}
