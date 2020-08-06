//
//  DefaultEnterPhoneView.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 28.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultEnterPhoneView: UIView, EnterPhoneView {
    
    private var controller: EnterPhoneController
    
    private let phoneTextField: PhoneTitlableTextField = {
        let textField = PhoneTitlableTextField(
            title: "Номер телефона",
            placeholder: "+7 (000) 000-00-00",
            keyboardType: .numberPad
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let smsCodeTextField: TitlableTextField = {
        var textType: UITextContentType?
        if #available(iOS 12.0, *) {
            textType = .oneTimeCode
        }
        let textField = ShadowTitlableTextField(
            title: "Код из СМС",
            placeholder: "******",
            textType: textType,
            keyboardType: .numberPad
        )
        textField.isHidden = true
        textField.alpha = 0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private let verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let sendCodeButton: BMButton = {
        let button = BMButton(buttonState: .standard, title: "Отправить код")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(controller: EnterPhoneController) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupVerticalStackConstraints()
        setupTextFieldsConstraints()
        setupSendCodeButtonConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        addSubview(verticalStackView)
        addSubview(sendCodeButton)
        verticalStackView.addArrangedSubview(phoneTextField)
        verticalStackView.addArrangedSubview(smsCodeTextField)
        setNeedsUpdateConstraints()
        sendCodeButton.addTarget(self, action: #selector(sendCodeButtonTapped), for: .touchUpInside)
        _ = phoneTextField.becomeFirstResponder()
    }
    
    func showSmsTextField(_ show: Bool) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.smsCodeTextField.alpha = show ? 1 : 0
                self.smsCodeTextField.isHidden = !show
        })
        sendCodeButton.isEnabled = false
        sendCodeButton.setTitle("Ожидайте СМС", for: .normal)
        _ = self.smsCodeTextField.becomeFirstResponder()
    }
    
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.centerYAnchor.constraint(equalTo: topAnchor, constant: bounds.height / 4 - 8),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26)
        ])
    }
    
    private func setupTextFieldsConstraints() {
        [phoneTextField, smsCodeTextField].forEach { (textField) in
            NSLayoutConstraint.activate([
                textField.heightAnchor.constraint(equalToConstant: 96)
            ])
        }
    }
    
    private func setupSendCodeButtonConstraints() {
        NSLayoutConstraint.activate([
            sendCodeButton.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 16),
            sendCodeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26),
            sendCodeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26),
            sendCodeButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func sendCodeButtonTapped() {
        var phone: String?
        if phoneTextField.isValidNumber {
            phone = phoneTextField.text?.onlyNumbers()
        } else {
            phone = nil
        }
        controller.sendCodeButtonTapped(phoneNumber: phone)
    }
        
}
