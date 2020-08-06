//
//  SimpleAlertController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 24.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class SimpleAlertController: UIViewController {
    
    private var action: (() -> Void)?
    
    private let alertView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor.Alert.mainView
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Alert.title
        label.font = UIFont.Alert.title
        return label
    }()
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Alert.message
        label.font = UIFont.Alert.message
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private let okButton = BMButton(buttonState: .standard, title: "Ок")
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    init(title: String?, message: String?, action: (() -> (Void))?) {
        self.action = action
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        messageLabel.text = message
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        configureView()
    }
    
    override func updateViewConstraints() {
        setupAlertViewConstraints()
        setupVerticalStackConstraints()
        setupOkButtonConstraints()
        super.updateViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor.Alert.background
        view.addSubview(alertView)
        alertView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(messageLabel)
        verticalStack.addArrangedSubview(okButton)
        verticalStack.setCustomSpacing(30, after: messageLabel)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        view.setNeedsUpdateConstraints()
    }
    
    private func setupAlertViewConstraints() {
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            verticalStack.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            verticalStack.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupOkButtonConstraints() {
        NSLayoutConstraint.activate([
            okButton.heightAnchor.constraint(equalToConstant: 48),
            okButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 160)
        ])
    }
    
    @objc private func okButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        action?()
    }
}
