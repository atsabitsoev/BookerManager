//
//  DefaultEnterNameView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultEnterNameView: UIView, EnterNameViewing {
    
    private var controller: EnterNameControlling
    
    private let nameTextField: TitlableTextField = {
        let textField = ShadowTitlableTextField(
            title: "Имя",
            placeholder: "Иван",
            textType: .name,
            keyboardType: .default
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    fileprivate let lastnameTextField: TitlableTextField = {
        let textField = ShadowTitlableTextField(
            title: "Фамилия (необязательно)",
            placeholder: "Иванов",
            textType: .familyName,
            keyboardType: .default
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let nextButton: UIButton = {
        let button = BMButton(buttonState: .standard, title: "Войти")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(controller: EnterNameControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupVerticalStackConstraints()
        setupNextButtonConstraints()
        setupTextFieldsConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        nameTextField.delegate = self
        lastnameTextField.delegate = self
        nameTextField.addTarget(target: self, action: #selector(nameChanged), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        validateNextButton()
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(nameTextField)
        verticalStack.addArrangedSubview(lastnameTextField)
        addSubview(nextButton)
        setNeedsUpdateConstraints()
    }
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.centerYAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 4 - 8),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26)
        ])
    }
    
    private func setupNextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 16),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            nextButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupTextFieldsConstraints() {
        [nameTextField, lastnameTextField].forEach { (textField) in
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: 96)
            ])
        }
    }
    
    private func validateNextButton() {
        var buttonShouldBeEnabled = false
        if let textCount = nameTextField.text?.count, textCount > 1 {
            buttonShouldBeEnabled = true
        }
        nextButton.isEnabled = buttonShouldBeEnabled
    }
    
    
    @objc private func nameChanged() {
        validateNextButton()
    }
    
    @objc private func nextButtonTapped() {
        guard let name = nameTextField.text else { return }
        let lastname = lastnameTextField.text
        controller.nextButtonTapped(name: name, lastname: lastname)
    }
    
}

extension DefaultEnterNameView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b") == -92
            if isBackSpace {
                return true
            }
        }
        return "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЁЯЧСМИТЬБЮйцукенгшщзхъфывапролджэёячсмитьбюQWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm".contains(string)
    }
}
