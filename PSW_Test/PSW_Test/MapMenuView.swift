//
//  MapMenuView.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import UIKit

/// Вью с меню настроек
final class MapMenuView: UIView {
    // MARK: - Visual components
    
    private let settingsButtonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.axis = .vertical
        stack.distribution = .equalCentering
        return stack
    }()
    
    // MARK: - Private properties
    
    private var settingButtons: [UIButton] = []
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createStackViewAnchors()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        addSubview(settingsButtonsStackView)
        addSettingsButtonToStack()
    }
    
    private func addSettingsButtonToStack() {
        (Constants.buttonsRange).forEach { index in
            let button = UIButton()
            button.setTitle(Constants.buttonsTitles[index], for: .normal)
            button.tag = index
            button.setTitleColor(.black, for: .normal)
            button.semanticContentAttribute = .forceLeftToRight
            button.setImage(UIImage(systemName: Constants.buttonsImagesNames[index]), for: .normal)
            settingButtons.append(button)
            settingsButtonsStackView.addArrangedSubview(button)
        }
    }
    
    private func createStackViewAnchors() {
        NSLayoutConstraint.activate([
            settingsButtonsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            settingsButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsButtonsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}

private extension MapMenuView {
    enum Constants {
        static let buttonsTitles = ["Center", "Focus"]
        static let buttonsImagesNames = ["location.viewfinder", "hand.tap"]
        static let buttonsRange: ClosedRange = 0 ... 1
    }
}
