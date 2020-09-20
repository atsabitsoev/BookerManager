//
//  DefaultSettingsView.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 05.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultSettingsView: UIView, SettingsViewing {
    
    private let controller: SettingsControlling
    
    private var switchView: SwitchView!
    private var checkDiscountView: ChevronCellView!
    private var createDiscountView: ChevronCellView!
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let quitButton: BMButton = {
        let button = BMButton(buttonState: .quit, title: "Выйти")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    init(controller: SettingsControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupVerticalStackConstraints()
        setupSwitchViewConstraints()
        setupCheckDescountViewConstraints()
        setupCreateDiscountViewConstraints()
        setupQuitButtonConstriants()
        super.updateConstraints()
    }
        
    func configureView() {
        backgroundColor = UIColor.Background.primary
        initiateViews()
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(switchView)
        verticalStack.addArrangedSubview(checkDiscountView)
        verticalStack.addArrangedSubview(createDiscountView)
        verticalStack.setCustomSpacing(44, after: switchView)
        addSubview(quitButton)
        setNeedsUpdateConstraints()
        
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
    }
    
    private func initiateViews() {
        switchView = SwitchView(title: "Сейчас работаю", isOn: false, action: { [unowned self] (isOn) in
            self.controller.workModeChanged(isWorking: isOn)
        })
        checkDiscountView = ChevronCellView(title: "Проверить скидку", action: { [unowned self] in
            self.controller.checkDiscountCamera()
        })
        createDiscountView = ChevronCellView(title: "Создать скидку", action: { [unowned self] in
            self.controller.createDiscontAlert()
        })
        [switchView, checkDiscountView, createDiscountView].forEach { (view) in
            view?.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 26),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26)
        ])
    }
    
    private func setupSwitchViewConstraints() {
        NSLayoutConstraint.activate([
            switchView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupCheckDescountViewConstraints() {
        NSLayoutConstraint.activate([
            checkDiscountView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupCreateDiscountViewConstraints() {
        NSLayoutConstraint.activate([
            createDiscountView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupQuitButtonConstriants() {
        NSLayoutConstraint.activate([
            quitButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36),
            quitButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            quitButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            quitButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func quitButtonTapped() {
        controller.quitButtonTapped()
    }
}
