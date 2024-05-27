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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleAlertContainerTap(_:)))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
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
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = self.model?.config.closeButtonConfig.tintColor
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
        })
    }
    
    deinit {
        removeKeyboardObservers()
    }
}

// MARK: - Setup methods
private extension AlertScreenViewController {
    
    func setupInitialState() {
        self.setupConstraints()
        self.setupComponents()
        self.setupKeyboardObservers()
        self.setupActions()
    }
    
    func setupComponents() {
        guard let model = self.model else {
            return
        }
        self.navigationItem.title = ""
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
    
    func setupConstraints() {
        guard let model = self.model else {
            return
        }
        clearSubviewsAndConstraints()
        configureVisibility()
        addSubviews()
        configureCloseButtonConstraints()
        contentStackViewHeightConstraint = contentStackView.heightAnchor.constraint(equalToConstant: 0.0)
        addConstraints()
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Constraints methods
private extension AlertScreenViewController {
    
    func clearSubviewsAndConstraints() {
        view.subviews.forEach { $0.removeFromSuperview() }
        NSLayoutConstraint.deactivate(constraints)
        constraints = []
    }
    
    func addSubviews() {
        if !blurView.isHidden {
            view.addSubview(blurView)
        }
        view.addSubview(containerView)
        
        if !backgroundImageView.isHidden {
            view.addSubview(backgroundImageView)
        }
        view.addSubview(backgroundTouchView)
        
        backgroundTouchView.addSubview(alertView)
        if !alertBackgroundImageView.isHidden {
            alertView.addSubview(alertBackgroundImageView)
        }
        
        alertView.addSubview(contentStackView)
        if !closeButton.isHidden {
            alertView.addSubview(closeButton)
        }
    }
    
    func configureVisibility() {
        guard let model = self.model else {
            return
        }
        
        blurView.isHidden = !model.config.backgroundConfig.isNeedBlur
        backgroundImageView.isHidden = model.config.backgroundConfig.backgroundImage == nil
        alertBackgroundImageView.isHidden = model.config.containerConfig.backgroundImage == nil
        closeButton.isHidden = !model.config.closeButtonConfig.isShowCloseButton
    }
    
    func configureCloseButtonConstraints() {
        guard let model = self.model else {
            return
        }
        
        let closeBtnPosition = model.config.closeButtonConfig.position
        switch closeBtnPosition {
        case let .left(inset):
            closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: inset.top)
            closeButtonSideConstraint = closeButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: inset.side)
        case let .right(inset):
            closeButtonTopConstraint = closeButton.topAnchor.constraint(equalTo: alertView.topAnchor, constant: inset.top)
            closeButtonSideConstraint = closeButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: inset.side)
        }
    }
    
    func addConstraints() {
        guard let model = self.model,
              let contentStackViewHeightConstraint = contentStackViewHeightConstraint,
              let closeButtonTopConstraint = closeButtonTopConstraint,
              let closeButtonSideConstraint = closeButtonSideConstraint else {
            return
        }
        
        if !blurView.isHidden {
            constraints += [
                blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                blurView.topAnchor.constraint(equalTo: view.topAnchor),
                blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        }
        
        if !backgroundImageView.isHidden {
            constraints += [
                backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        }
        
        if !alertBackgroundImageView.isHidden {
            constraints += [
                alertBackgroundImageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: model.config.containerConfig.componentsInsets.left),
                alertBackgroundImageView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: model.config.containerConfig.componentsInsets.right),
                alertBackgroundImageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: model.config.containerConfig.componentsInsets.top),
                alertBackgroundImageView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: model.config.containerConfig.componentsInsets.bottom)
            ]
        }
        
        if !closeButton.isHidden {
            constraints += [
                closeButtonTopConstraint,
                closeButtonSideConstraint,
                closeButton.widthAnchor.constraint(equalToConstant: model.config.closeButtonConfig.size.width),
                closeButton.heightAnchor.constraint(equalToConstant: model.config.closeButtonConfig.size.height)
            ]
        }
        
        constraints += [
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
            
            contentStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: model.config.containerConfig.componentsInsets.left),
            contentStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: model.config.containerConfig.componentsInsets.right),
            contentStackView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: model.config.containerConfig.componentsInsets.top),
            contentStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: model.config.containerConfig.componentsInsets.bottom),
            contentStackViewHeightConstraint
        ]
    }
}

// MARK: - Actions
private extension AlertScreenViewController {
    
    @objc
    func closeButtonTapped(_ sender: UIButton) {
        self.hideView {
            self.model?.alert.didDismissButtonTapped?()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc
    func handleBackgroundContainerTap(_ sender: UITapGestureRecognizer) {
        self.hideView {
            self.model?.alert.didDismissButtonTapped?()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc
    func handleAlertContainerTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        var contentInset = self.contentStackView.scrollView.contentInset
        contentInset.bottom = keyboardSize.height
        self.contentStackView.scrollView.contentInset = contentInset
        self.contentStackView.scrollView.isScrollEnabled = true
    }
    
    @objc
    func keyboardWillHide(notification: Notification) {
        self.contentStackView.scrollView.contentInset = .zero
        self.setAlertScroll()
    }
}

// MARK: - External module methods
extension AlertScreenViewController {
    
    /// Dismisses the alert and calls the optional completion handler after dismissal.
    /// - Parameter finished: An optional closure to be executed after the alert is dismissed.
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

// MARK: - Internal module methods
private extension AlertScreenViewController {
    
    func setupView() {
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
        
        model.alert.components.map({ $0.createComponent(parentWidth: parentWidth) }).enumerated().forEach({ (index, data) in
            self.contentStackView.stackView.addArrangedSubview(data.0)
            
            stackHeight += data.1
            if index != model.alert.components.count - 1 {
                stackHeight += self.contentStackView.spacing
            }
            self.view.layoutIfNeeded()
        })
        
        if !model.alert.components.isEmpty {
            // Spacing between buttons and components
            stackHeight += self.contentStackView.spacing
        }
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
        self.contentStackViewHeightConstraint?.constant = stackHeight
        self.setAlertScroll()
        
        self.view.layoutIfNeeded()
    }
    
    func setAlertScroll() {
        guard let stackHeight = self.contentStackViewHeightConstraint?.constant,
              let model = self.model else {
            return
        }
        
        let alertHeight = stackHeight + model.config.containerConfig.componentsInsets.top + model.config.containerConfig.componentsInsets.bottom
        let maxAlertHeight = containerView.frame.height * (CGFloat(model.config.containerConfig.maxAlertHeightIntPercentage) / 100.0)
        
        if alertHeight > maxAlertHeight {
            self.contentStackViewHeightConstraint?.constant = maxAlertHeight
            self.contentStackView.scrollView.isScrollEnabled = true
        } else {
            self.contentStackView.scrollView.isScrollEnabled = false
        }
    }
    
    func showView() {
        self.model?.config.presentableService.showView(
            backgroundView: self.containerView,
            alertView: self.alertView
        )
    }
}
