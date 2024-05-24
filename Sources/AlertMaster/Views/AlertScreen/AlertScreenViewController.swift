//
//  AlertScreenViewController.swift
//
//
//  Created by Pavel Moslienko on 29.04.2024.
//

import AppViewUtilits
import UIKit

public class AlertScreenViewController: UIViewController {
    
    // MARK: - UI components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = model?.config.backgroundConfig.backgroundColor
        
        return view
    }()
    
    private lazy var blurView: UIVisualEffectView = {
        let effect: UIBlurEffect.Style = model?.config.backgroundConfig.blurStyle ?? .regular
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.image = model?.config.backgroundConfig.backgroundImage
        
        return view
    }()
    
    private lazy var backgroundTouchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        if model?.config.backgroundConfig.isAllowTapForDismiss ?? false {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleBackgroundContainerTap(_:)))
            view.addGestureRecognizer(tap)
            view.isUserInteractionEnabled = true
        }
        return view
    }()

    private lazy var alertView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = model?.config.containerConfig.backgroundColor
        view.layer.cornerRadius = model?.config.containerConfig.cornerRadius ?? 0.0
        view.layer.borderWidth = model?.config.containerConfig.borderWidth ?? 0.0
        view.layer.borderColor = model?.config.containerConfig.borderColor
        
        if let shadowParams = model?.config.containerConfig.shadowParams {
            view.layer.shadowColor = shadowParams.shadowColor
            view.layer.shadowOpacity = shadowParams.shadowOpacity
            view.layer.shadowOffset = shadowParams.shadowOffset
            view.layer.shadowRadius = shadowParams.shadowRadius
        } else {
            view.layer.shadowColor = UIColor.clear.cgColor
            view.layer.shadowOpacity = 0
            view.layer.shadowOffset = .zero
            view.layer.shadowRadius = 0
        }
        
        return view
    }()
    
    private lazy var alertBackgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = model?.config.containerConfig.backgroundImage
        
        return view
    }()
    
    private let contentStackView: AlertScrollableStackView = {
        let stackView = AlertScrollableStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let footerButtonsView: FooterButtonsView = {
        let stackView = FooterButtonsView(frame: .zero, buttonsConfig: AlertButtonsConfig())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    // MARK: - Constraints
    private var constraints = [NSLayoutConstraint]()
    private var closeButtonTopConstraint: NSLayoutConstraint?
    private var closeButtonSideConstraint: NSLayoutConstraint?
    private var contentStackViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Public properties
    public var model: AlertScreenViewModel?
    
    // MARK: - Lifecycle
    public override func viewDidLayoutSubviews() {
        self.applyStyles()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showView()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    public override func viewDidLoad() {
        self.setupInitialState()
        self.setupView()
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.viewDidLoad()
            self.containerView.alpha = 1.0
            self.alertView.alpha = 1
        })
    }
}

// MARK: - Setup methods
private extension AlertScreenViewController {
    
    func setupInitialState() {
        self.setupConstaints()
        self.setupComponents()
        self.setupActions()
    }
    
    func setupComponents() {
        guard let model = self.model else {
            return
        }
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.containerView.alpha = 0.0
        self.alertView.alpha = 0
        
        self.contentStackView.stackView.distribution = .fill
        self.contentStackView.stackView.alignment = .fill
        self.contentStackView.stackView.spacing = model.config.containerConfig.componentsSpacing
        
        self.contentStackView.stackView.isLayoutMarginsRelativeArrangement = true
        self.contentStackView.scrollView.showsHorizontalScrollIndicator = false
        self.contentStackView.scrollView.showsVerticalScrollIndicator = false
        
        self.closeButton.setImage(model.config.closeButtonConfig.icon, for: [])
    }
    
    func setupActions() {
        self.closeButton.addTarget(self, action: #selector(self.closeButtonTapped(_:)), for: .touchUpInside)
    }
    
    func applyStyles() {
        self.view.backgroundColor = .clear
        self.contentStackView.backgroundColor = .clear
    }
    
    func setupConstaints() {
        guard let model = self.model else {
            return
        }
        
        view.subviews.forEach({ $0.removeFromSuperview() })
        NSLayoutConstraint.deactivate(constraints)
        constraints = []
        
        view.addSubview(blurView)
        view.addSubview(containerView)
        view.addSubview(backgroundImageView)
        view.addSubview(backgroundTouchView)
        
        backgroundTouchView.addSubview(alertView)
        alertView.addSubview(alertBackgroundImageView)
        alertView.addSubview(contentStackView)
        alertView.addSubview(closeButton)
        
        blurView.isHidden = !model.config.backgroundConfig.isNeedBlur
        backgroundImageView.isHidden = model.config.backgroundConfig.backgroundImage == nil
        alertBackgroundImageView.isHidden = model.config.containerConfig.backgroundImage == nil
        closeButton.isHidden = !model.config.closeButtonConfig.isShowCloseButton
        print("setupConstaints - \(self.view)")
        let closeBtnPosition = model.config.closeButtonConfig.position
        switch closeBtnPosition {
        case let .left(inset):
            closeButtonTopConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: inset.top)
            closeButtonSideConstraint = NSLayoutConstraint(item: closeButton, attribute: .leading, relatedBy: .equal, toItem: alertView, attribute: .leading, multiplier: 1.0, constant: inset.side)
        case let .right(inset):
            closeButtonTopConstraint = NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: inset.top)
            closeButtonSideConstraint = NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: alertView, attribute: .trailing, multiplier: 1.0, constant: inset.side)
        }
        
        contentStackViewHeightConstraint = NSLayoutConstraint(item: contentStackView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
        
        guard let contentStackViewHeightConstraint = contentStackViewHeightConstraint,
              let closeButtonSideConstraint = closeButtonSideConstraint,
              let closeButtonTopConstraint = self.closeButtonTopConstraint
        else {
            return
        }
        
        constraints += [
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundTouchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundTouchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundTouchView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundTouchView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            alertView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            alertView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: model.config.containerConfig.containerInsets.left),
            alertView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: model.config.containerConfig.containerInsets.right),
            
            
            alertBackgroundImageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: model.config.containerConfig.componentsInsets.left),
            alertBackgroundImageView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: model.config.containerConfig.componentsInsets.right),
            alertBackgroundImageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: model.config.containerConfig.componentsInsets.top),
            alertBackgroundImageView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: model.config.containerConfig.componentsInsets.bottom),
            
            contentStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: model.config.containerConfig.componentsInsets.left),
            contentStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: model.config.containerConfig.componentsInsets.right),
            contentStackView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: model.config.containerConfig.componentsInsets.top),
            contentStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: model.config.containerConfig.componentsInsets.bottom),
            contentStackViewHeightConstraint,
            
            closeButtonSideConstraint,
            closeButtonTopConstraint,
            closeButton.widthAnchor.constraint(equalToConstant: model.config.closeButtonConfig.size.width),
            closeButton.heightAnchor.constraint(equalToConstant: model.config.closeButtonConfig.size.height),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Actions
extension AlertScreenViewController {
    
    @objc
    private func closeButtonTapped(_ sender: UIButton) {
        self.hideView {
            self.model?.didDismissButtonTapped?()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc
    private func handleBackgroundContainerTap(_ sender: UITapGestureRecognizer) {
        self.hideView {
            self.model?.didDismissButtonTapped?()
            self.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - Module methods
extension AlertScreenViewController {
    
    internal func setupView() {
        guard let model = self.model else {
            return
        }
        self.view.layoutSubviews()
        
        self.contentStackView.stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        self.footerButtonsView.reset()
        var stackHeight: CGFloat = 0.0
        
        let containerInsets = model.config.containerConfig.containerInsets.left + abs(model.config.containerConfig.containerInsets.right)
        let alertInsets = model.config.containerConfig.componentsInsets.left + abs(model.config.containerConfig.componentsInsets.right)
        let parentWidth = self.view.frame.width - containerInsets - alertInsets
        
        model.alert.components.map({ $0.createComponent(parentWidth: parentWidth) }).forEach({ (component, height) in
            self.contentStackView.stackView.addArrangedSubview(component)
            
            stackHeight += height
            stackHeight += self.contentStackView.spacing
            stackHeight += self.contentStackView.spacing
            self.view.layoutIfNeeded()
        })
        
        self.contentStackView.stackView.addArrangedSubview(self.footerButtonsView)
        
        switch model.alert.buttonsLayout {
        case let .auto(buttons, position):
            buttons.forEach({ button in
                footerButtonsView.addCustomButton(button, position: position)
            })
        case let .manual(buttonsGroup):
            footerButtonsView.addCustomGroups(buttonsGroup)
        case .none:
            break
        }
        self.view.layoutSubviews()
        
        footerButtonsView.layoutIfNeeded()
        let footerViewHeight = footerButtonsView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        stackHeight += footerViewHeight
        
        let alertHeight = stackHeight + model.config.containerConfig.componentsInsets.top + model.config.containerConfig.componentsInsets.bottom
        
        if alertHeight > self.containerView.frame.height / 1.5 {
            stackHeight = self.containerView.frame.height / 1.5
            self.contentStackView.scrollView.isScrollEnabled = true
        } else {
            self.contentStackView.scrollView.isScrollEnabled = false
        }
        
        self.contentStackViewHeightConstraint?.constant = stackHeight
        
        self.view.layoutIfNeeded()
    }
    
    private func showView() {
        self.model?.config.presentableService.showView(
            backgroundView: self.containerView,
            alertView: self.alertView
        )
    }
    
    func hideView(_ finished: (() -> Void)? = nil) {
        self.model?.config.presentableService.hideView(
            backgroundView: self.containerView,
            alertView: self.alertView,
            finished: {
                finished?()
            }
        )
    }
}
