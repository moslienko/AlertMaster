//
//  PlaygroundViewController.swift
//  AlertMasterExample
//
//  Created by Pavel Moslienko on 22.05.2024.
//

import UIKit
import AlertMaster

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
        
        stackView.addArrangedSubview(self.label(text: AlertParams.ActionButtonsContent.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.ActionButtonsContent.allCases.map({ $0.fieldName }), selectedIndex: 0, id: AlertParams.ActionButtonsContent.id))
        
        stackView.addArrangedSubview(self.label(text: AlertParams.ActionButtonsLayout.groupName))
        stackView.addArrangedSubview(self.segment(items: AlertParams.ActionButtonsLayout.allCases.map({ $0.fieldName }), selectedIndex: 0, id: AlertParams.ActionButtonsLayout.id))
        
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
                self.viewModel.alertConfig.backgroundConfig.isNeedBlur = true
                self.viewModel.alertConfig.backgroundConfig.backgroundColor = .clear
            case .withColor:
                self.viewModel.alertConfig.backgroundConfig.isNeedBlur = false
                self.viewModel.alertConfig.backgroundConfig.backgroundColor = .black.withAlphaComponent(0.3)
            }
        case AlertParams.ContainerContent.id:
            guard let val = AlertParams.ContainerContent(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            switch val {
            case .white:
                self.viewModel.alertConfig.containerConfig.backgroundColor = .white
                self.viewModel.alertConfig.containerConfig.cornerRadius = 15
            case .red:
                self.viewModel.alertConfig.containerConfig.backgroundColor = .red
                self.viewModel.alertConfig.containerConfig.cornerRadius = 0
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
        case AlertParams.ActionButtonsLayout.id:
            guard let val = AlertParams.ActionButtonsLayout(rawValue: sender.selectedSegmentIndex) else {
                return
            }
            viewModel.actionButtonsLayout = val
        default:
            break
        }
    }
    
    @objc
    func bigButtonTapped() {
        let alert = AlertMasterService(
            components: [
                .image(UIImage(named: "cube-transparent")!, height: 100),
                .text(value: "Текстовый компонент!", textAlignment: .center)
            ],
            buttonsLayout: .none
        )
        
        let buttons = self.createButtonsList(count: 3, prefix: "")
        buttons.forEach({
            $0.action = {
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
            buttons.forEach({
                $0.action = {
                    alert.dismiss()
                }
            })
            
            let buttonsTwo = self.createButtonsList(count: 2, prefix: "(1)")
            buttons.forEach({
                $0.action = {
                    alert.dismiss()
                }
            })
            
            let buttonsThree = self.createButtonsList(count: 3, prefix: "(2)")
            buttons.forEach({
                $0.action = {
                    alert.dismiss()
                }
            })
            
            let buttonsGroup = [
                AlertButtonsGroup(position: .horizontal, buttons: buttonsOne),
                AlertButtonsGroup(position: .vertical, buttons: buttonsTwo),
                AlertButtonsGroup(position: .horizontal, buttons: buttonsThree)
            ]
            
            switch viewModel.actionButtonsLayout {
            case .auto:
                alert.buttonsLayout = .auto(buttons: buttonsOne + buttonsTwo + buttonsThree, position: .horizontal)
            case .manual:
                alert.buttonsLayout = .manual(buttonsGroup: buttonsGroup)
            }
        case .none:
            alert.buttonsLayout = .none
        }
        
        alert.didDismissButtonTapped = {
            print("Dismiss btn tapped")
        }
        
        alert.show(in: self, with: viewModel.alertConfig)
    }
    
    private func createButtonsList(count: Int, prefix: String) -> [AlertActionButton] {
        var buttons: [AlertActionButton] = []

        for i in 0...count - 1 {
            let button = AlertActionButton()
            button.title = "\(prefix) Button \(i)"
            button.cornerRadius = 15
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            buttons += [button]
        }
        
        return buttons
    }
}