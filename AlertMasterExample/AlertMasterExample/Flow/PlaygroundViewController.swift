//
//  PlaygroundViewController.swift
//  AlertMasterExample
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import UIKit
import AlertMaster
import AppViewUtilits

class PlaygroundViewController: UIViewController {
    
    var viewModel = PlaygroundViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
}

// MARK: - Module methods
private extension PlaygroundViewController {
    
    func setupView() {
        let scrollView = UIScrollView()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12.0
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        let bigButton = UIButton()
        bigButton.setTitle("Show alert", for: .normal)
        bigButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        bigButton.titleLabel?.textColor = .white
        bigButton.backgroundColor = .systemRed
        bigButton.layer.cornerRadius = 15.0
        bigButton.addTarget(self, action: #selector(bigButtonTapped), for: .touchUpInside)
        
        stackView.addArrangedSubview(self.label(text: AlertParams.BackgroundContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.BackgroundContent.allCases.map({ $0.fieldName }), selectedIndex: 1, id: AlertParams.BackgroundContent.id))
        
        stackView.addArrangedSubview(self.label(text: AlertParams.ContainerContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.ContainerContent.allCases.map({ $0.fieldName }), selectedIndex: 0, id: AlertParams.ContainerContent.id))
        
        stackView.addArrangedSubview(self.label(text: AlertParams.CloseButtonContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.CloseButtonContent.allCases.map({ $0.fieldName }), selectedIndex: 1, id: AlertParams.CloseButtonContent.id))
        
        stackView.addArrangedSubview(self.label(text: AlertParams.ComponentsContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.ComponentsContent.allCases.map({ $0.fieldName }), selectedIndex: 0, id: AlertParams.ComponentsContent.id))
        
        
        stackView.addArrangedSubview(self.label(text: AlertParams.ActionButtonsContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.ActionButtonsContent.allCases.map({ $0.fieldName }), selectedIndex: 0, id: AlertParams.ActionButtonsContent.id))
        
        stackView.addArrangedSubview(self.label(text: AlertParams.AnimationContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.AnimationContent.allCases.map({ $0.fieldName }), selectedIndex: 0, id: AlertParams.AnimationContent.id))
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        view.addSubview(bigButton)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bigButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bigButton.topAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            bigButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bigButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bigButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bigButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - Components builder
private extension PlaygroundViewController {
    
    func label(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }
    
    func segment(items: [String], selectedIndex: Int, id: Int) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = selectedIndex
        segmentedControl.tag = id
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
        return segmentedControl
    }
}

// MARK: - Actions
private extension PlaygroundViewController {
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.tag {
        case AlertParams.BackgroundContent.id:
            guard let val = AlertParams.BackgroundContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            
            switch val {
            case .withBlur:
                self.viewModel.alertConfig.backgroundConfig = AlertBackgroundConfig(isNeedBlur: true, blurStyle: .regular, backgroundColor: .clear)
            case .withColor:
                self.viewModel.alertConfig.backgroundConfig = AlertBackgroundConfig(isNeedBlur: false, backgroundColor: .black.withAlphaComponent(0.3))
            case .image:
                self.viewModel.alertConfig.backgroundConfig = AlertBackgroundConfig(backgroundColor: .clear, backgroundImage: UIImage(named: "sky"))
            }
        case AlertParams.ContainerContent.id:
            guard let val = AlertParams.ContainerContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            switch val {
            case .white:
                self.viewModel.alertConfig.containerConfig = AlertContainerConfig(cornerRadius: 15, backgroundColor: .white)
            case .border:
                self.viewModel.alertConfig.containerConfig = AlertContainerConfig(cornerRadius: 19, borderWidth: 3, borderColor: UIColor.red.cgColor, backgroundColor: .white, shadowParams: AlertContainerConfig.ShadowParams(shadowColor: UIColor.black.cgColor, shadowOpacity: 1.0, shadowOffset: .zero, shadowRadius: 10))
            case .image:
                self.viewModel.alertConfig.containerConfig = AlertContainerConfig(cornerRadius: 15, backgroundColor: .white, backgroundImage: UIImage(named: "fireworks"))
            }
        case AlertParams.CloseButtonContent.id:
            guard let val = AlertParams.CloseButtonContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            switch val {
            case .left:
                self.viewModel.alertConfig.closeButtonConfig.isShowCloseButton = true
                self.viewModel.alertConfig.closeButtonConfig.position = .left(inset: AlertCloseButtonConfig.PositionInset(top: 20, side: 20))
            case .right:
                self.viewModel.alertConfig.closeButtonConfig.isShowCloseButton = true
                self.viewModel.alertConfig.closeButtonConfig.position = .right(inset: AlertCloseButtonConfig.PositionInset(top: 20, side: -20))
            case .none:
                self.viewModel.alertConfig.closeButtonConfig.isShowCloseButton = false
            }
        case AlertParams.ActionButtonsContent.id:
            guard let val = AlertParams.ActionButtonsContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            viewModel.buttonsParam = val
        case AlertParams.AnimationContent.id:
            guard let val = AlertParams.AnimationContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            switch val {
            case .default:
                self.viewModel.alertConfig.presentableService = AlertScreenPresentation()
            case .zoom:
                self.viewModel.alertConfig.presentableService = PlaygroundAnimations.ZoomPresentable()
            case .slide:
                self.viewModel.alertConfig.presentableService = PlaygroundAnimations.SlidePresentable()
            case .rotate:
                self.viewModel.alertConfig.presentableService = PlaygroundAnimations.RotatePresentable()
            }
        case AlertParams.ComponentsContent.id:
            guard let val = AlertParams.ComponentsContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            viewModel.componentsContent = val
        default:
            break
        }
    }
    
    @objc
    func bigButtonTapped() {
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        let regularFont = UIFont.systemFont(ofSize: 14)
        let boldFont = UIFont.boldSystemFont(ofSize: 14)
        
        let regularAttributes: [NSAttributedString.Key: Any] = [.font: regularFont, .foregroundColor: UIColor.black]
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont, .foregroundColor: UIColor.black]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: regularAttributes)
        
        let boldRange = (text as NSString).range(of: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
        attributedString.setAttributes(boldAttributes, range: boldRange)
        
        let headerStyle: DecorateWrapper<UILabel> = .wrap(style: {
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textAlignment = .center
        })
        let textViewStyle: DecorateWrapper<UITextView> = .wrap(style: {
            $0.textAlignment = .left
        })
        let textViewEditedStyle: DecorateWrapper<UITextView> = .wrap(style: {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = UIColor(hex: "097969").cgColor
            $0.layer.borderWidth = 1.5
            $0.tintColor = UIColor(hex: "097969")
            $0.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        })
        
        let textFieldStyle: DecorateWrapper<UITextField> = .wrap(style: {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 16, weight: .regular)
            $0.borderStyle = .roundedRect
            $0.placeholder = "Name"
        })
        let datePickerStyle: DecorateWrapper<UIDatePicker> = .wrap(style: {
            $0.datePickerMode = .date
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            }
        })
        
        let alert = AlertMasterService(
            components: [],
            buttonsLayout: .none
        )
        
        let buttons = self.createButtonsList(count: 3, prefix: "")
        buttons.forEach({
            $0.addAction {
                alert.dismiss()
            }
        })
        
        switch viewModel.buttonsParam {
        case .horizontal:
            alert.buttonsLayout = .auto(buttons: buttons, position: .horizontal)
        case .vertical:
            alert.buttonsLayout = .auto(buttons: buttons, position: .vertical)
        case .manual:
            let buttonsOne = self.createButtonsList(count: 2, prefix: "(0)")
            buttonsOne.forEach({
                $0.addAction {
                    alert.dismiss()
                }
            })
            
            let buttonsTwo = self.createButtonsList(count: 2, prefix: "(1)")
            buttonsTwo.forEach({
                $0.addAction {
                    alert.dismiss()
                }
            })
            
            let buttonsThree = self.createButtonsList(count: 3, prefix: "(2)")
            buttonsThree.forEach({
                $0.addAction {
                    alert.dismiss()
                }
            })
            
            let buttonsGroup = [
                AlertButtonsGroup(position: .horizontal, buttons: buttonsOne),
                AlertButtonsGroup(position: .vertical, buttons: buttonsTwo),
                AlertButtonsGroup(position: .horizontal, buttons: buttonsThree)
            ]
            
            alert.buttonsLayout = .manual(buttonsGroup: buttonsGroup)
        case .none:
            alert.buttonsLayout = .none
        }
        
        let sendFeedbackButton = AppButton()
        
        if viewModel.componentsContent == .textView {
            sendFeedbackButton.setTitle("Send", for: [])
            sendFeedbackButton.layer.cornerRadius = 15
            sendFeedbackButton.regularStyle = .wrap(style: {
                $0.backgroundColor = UIColor(hex: "097969")
            })
            sendFeedbackButton.highlightedStyle = .wrap(style: {
                $0.backgroundColor = UIColor(hex: "097969").withAlphaComponent(0.7)
            })
            sendFeedbackButton.disabledStyle = .wrap(style: {
                $0.backgroundColor = UIColor(hex: "097969").withAlphaComponent(0.3)
            })
            sendFeedbackButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
            sendFeedbackButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            sendFeedbackButton.isEnabled = false
            sendFeedbackButton.addAction {
                alert.dismiss()
            }
            
            alert.buttonsLayout = .auto(buttons: [sendFeedbackButton], position: .horizontal)
        }
        
        var components: [AlertComponents] {
            switch viewModel.componentsContent {
            case .variantOne:
                let imageView = UIImageView(image: UIImage(systemName: "bolt.shield"))
                imageView.tintColor = .systemRed
                imageView.contentMode = .scaleAspectFit
                
                return [
                    .image(imageView, height: 64),
                    .text(value: "Important headline", style: headerStyle),
                    .textView(value: attributedString, style: textViewStyle)
                ]
            case .variantTwo:
                return []
            case .textField:
                return [
                    .text(value: "What is your name?", style: headerStyle),
                    .textField(value: "", style: textFieldStyle, height: 44, callback: { _ in
                        
                    })
                ]
            case .textView:
                return [
                    .text(value: "Leave your feedback", style: headerStyle),
                    .editedTextView(value: "", style: textViewEditedStyle, height: 140, callback: { text in
                        sendFeedbackButton.isEnabled = !(text ?? "").isEmpty
                    })
                ]
            case .datePicker:
                return [
                    .text(value: "Select date of birth", style: headerStyle),
                    .timePicker(date: Date(), style: datePickerStyle, height: AlertDatePicker.HeightConstant.wheel.rawValue, callback: { _ in
                    })
                ]
            }
        }
        alert.components = components
        
        alert.didDismissButtonTapped = {
            print("Dismiss btn tapped")
        }
        
        alert.show(in: self, with: viewModel.alertConfig)
    }
    
    private func createButtonsList(count: Int, prefix: String) -> [AppButton] {
        var buttons: [AppButton] = []
        
        for i in 0...count - 1 {
            let button = AppButton()
            button.setTitle("\(prefix) Button \(i)", for: [])
            button.layer.cornerRadius = 15
            button.regularStyle = .wrap(style: {
                $0.backgroundColor = .systemBlue
            })
            button.highlightedStyle = .wrap(style: {
                $0.backgroundColor = .systemBlue.withAlphaComponent(0.7)
            })
            button.titleLabel?.font = .boldSystemFont(ofSize: 16)
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            buttons += [button]
        }
        
        return buttons
    }
    
    private func showTestableAlert() {
        let text = "Fill a profile now to get access to all the incredible features of the app"
        
        let regularFont = UIFont.systemFont(ofSize: 14)
        let boldFont = UIFont.boldSystemFont(ofSize: 14)
        
        let regularAttributes: [NSAttributedString.Key: Any] = [.font: regularFont, .foregroundColor: UIColor.black]
        let boldAttributes: [NSAttributedString.Key: Any] = [.font: boldFont, .foregroundColor: UIColor.black]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: regularAttributes)
        
        let boldRange = (text as NSString).range(of: "all the incredible features")
        attributedString.setAttributes(boldAttributes, range: boldRange)
        
        let tintColor = UIColor(hex: "7F00FF")

        let headerStyle: DecorateWrapper<UILabel> = .wrap(style: {
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 22, weight: .bold)
            $0.textAlignment = .center
        })
        let subHeaderStyle: DecorateWrapper<UILabel> = .wrap(style: {
            $0.numberOfLines = 0
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 16, weight: .bold)
            $0.textAlignment = .left
        })
        let textViewStyle: DecorateWrapper<UITextView> = .wrap(style: {
            $0.textAlignment = .center
        })
        let textViewEditedStyle: DecorateWrapper<UITextView> = .wrap(style: {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .regular)
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = tintColor.cgColor
            $0.layer.borderWidth = 1.5
            $0.tintColor = tintColor
            $0.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        })
        
        let textFieldStyle: DecorateWrapper<UITextField> = .wrap(style: {
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 16, weight: .regular)
            $0.borderStyle = .roundedRect
            $0.tintColor = tintColor
            $0.layer.cornerRadius = 15
            $0.layer.borderColor = tintColor.cgColor
            $0.layer.borderWidth = 1.5
            $0.placeholder = "Name"
        })

        let alert = AlertMasterService(
            components: [],
            buttonsLayout: .none
        )
        
        let applyButton = AppButton()
        let cancelButton = AppButton()
        applyButton.addAction {
            alert.dismiss()
        }
        cancelButton.addAction {
            alert.dismiss()
        }
        
        applyButton.setTitle("Apply", for: [])
        applyButton.setTitleColor(.white, for: [])
        applyButton.layer.cornerRadius = 15
        applyButton.regularStyle = .wrap(style: {
            $0.backgroundColor = tintColor
        })
        applyButton.highlightedStyle = .wrap(style: {
            $0.backgroundColor = tintColor.withAlphaComponent(0.7)
        })
        applyButton.disabledStyle = .wrap(style: {
            $0.backgroundColor = tintColor.withAlphaComponent(0.3)
        })
        applyButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        applyButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        applyButton.isEnabled = false

        cancelButton.setTitle("Cancel", for: [])
        cancelButton.setTitleColor(tintColor, for: [])
        cancelButton.layer.cornerRadius = 15
        cancelButton.backgroundColor = .clear
        cancelButton.layer.borderWidth = 1.5
        cancelButton.regularStyle = .wrap(style: {
            $0.layer.borderColor = tintColor.cgColor
        })
        cancelButton.highlightedStyle = .wrap(style: {
            $0.layer.borderColor = tintColor.withAlphaComponent(0.7).cgColor
        })
        cancelButton.disabledStyle = .wrap(style: {
            $0.layer.borderColor = tintColor.withAlphaComponent(0.3).cgColor
        })
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        cancelButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        alert.buttonsLayout = .auto(buttons: [cancelButton, applyButton], position: .horizontal)
        
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = tintColor
        imageView.contentMode = .scaleAspectFit
        
        let components: [AlertComponents] = [
            .image(imageView, height: 64),
            .text(value: "Fill profile", style: headerStyle),
            .textView(value: attributedString, style: textViewStyle),
            .text(value: "What is your name?", style: subHeaderStyle),
            .textField(value: "", style: textFieldStyle, height: 44, callback: { text in
                applyButton.isEnabled = !(text ?? "").isEmpty
            }),
            .text(value: "Tell us briefly about yourself", style: subHeaderStyle),
            .editedTextView(value: "", style: textViewEditedStyle, height: 80, callback: { _ in })
        ]
        
        alert.components = components
        
        alert.show(in: self, with: viewModel.alertConfig)
    }
}
