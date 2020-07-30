//
//  TypeAlertController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 31.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class TypeAlertController: UIViewController {
    
    private var alertTitle: String
    private var buttonTitle: String
    private var buttonState: BMButton.State
    private var placeholder: String
    private var textInputNecessary: Bool
    private var action: (String?) -> ()
    
    
    private lazy var backgroundView: UIView = { [unowned self] in
        let view = UIView()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(recognizer)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Background.primary
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.Shadow.main.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Alert.title
        label.textColor = UIColor.Alert.title
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainTextField: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.font = UIFont.Alert.textField
        textField.textColor = UIColor.Alert.title
        textField.backgroundColor = UIColor.Background.secondary
        textField.layer.cornerRadius = 16
        textField.placeholder = self.placeholder
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 1))
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var actionButton: BMButton = { [unowned self] in
        let button = BMButton(buttonState: self.buttonState, title: self.buttonTitle)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor.Button.cancel, for: .normal)
        button.titleLabel?.font = UIFont.Button.cancel
        return button
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(
        alertTitle: String,
        buttonTitle: String,
        buttonState: BMButton.State,
        placeholder: String,
        textInputNecessary: Bool = true,
        action: @escaping (String?) -> ()
    ) {
        self.alertTitle = alertTitle
        self.buttonTitle = buttonTitle
        self.buttonState = buttonState
        self.placeholder = placeholder
        self.textInputNecessary = textInputNecessary
        self.action = action
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = alertTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateViewConstraints() {
        setupBackgroundViewConstraints()
        setupMainViewConstraints()
        setupVerticalStackConstraints()
        setupActionButtonConstraints()
        setupMainTextFieldConstraints()
        setupTitleLabelConstraints()
        super.updateViewConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(backgroundView)
        view.addSubview(mainView)
        mainView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(mainTextField)
        verticalStack.addArrangedSubview(actionButton)
        verticalStack.addArrangedSubview(cancelButton)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainTextField.becomeFirstResponder()
    }
    
    private func setupBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.center.y/3),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26)
        ])
    }
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            verticalStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
            verticalStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 26),
            verticalStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -26)
        ])
    }
    
    private func setupActionButtonConstraints() {
        NSLayoutConstraint.activate([
            actionButton.widthAnchor.constraint(equalTo: mainTextField.widthAnchor, constant: -24),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupMainTextFieldConstraints() {
        NSLayoutConstraint.activate([
            mainTextField.heightAnchor.constraint(equalToConstant: 44),
            mainTextField.widthAnchor.constraint(equalTo: verticalStack.widthAnchor)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    @objc private func actionButtonTapped() {
        guard let text = mainTextField.text else { return }
        action(text)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func backgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
