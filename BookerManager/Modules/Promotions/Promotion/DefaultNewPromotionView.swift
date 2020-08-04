//
//  DefaultPromotionView.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 04.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultNewPromotionView: UIView, NewPromotionViewing {
    
    private let controller: NewPromotionControlling
    
    private lazy var mainImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.Background.secondary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private lazy var setImageButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.setTitle("Выбрать изображение", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var nameTextField: ShadowTitlableTextField = { [unowned self] in
        let textField = ShadowTitlableTextField(
            title: "Название акции",
            placeholder: "Название акции",
            textType: nil,
            keyboardType: nil
        )
        textField.tag = 1
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var descriptionTextField: ShadowTitlableTextField = { [unowned self] in
        let textField = ShadowTitlableTextField(
            title: "Описание",
            placeholder: "Введите описание",
            textType: nil,
            keyboardType: nil
        )
        textField.tag = 2
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var mainButton: BMButton = { [unowned self] in
        var button: BMButton
        button = BMButton(buttonState: .standard, title: "Создать акцию")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delaysContentTouches = false
        return scrollView
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(controller: NewPromotionControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupScrollViewConstraints()
        setupVerticalStackConstraints()
        setupMainButtonConstraints()
        setupSetImageButtonConstraints()
        setupMainImageViewConstraints()
        setupTextFieldsConstraints()
        super.updateConstraints()
    }
    
    func configureView() {
        backgroundColor = UIColor.Background.primary
        [nameTextField, descriptionTextField].forEach { (textField) in
            textField.delegate = self
        }
        setImageButton.addTarget(self, action: #selector(setImageButtonTapped), for: .touchUpInside)
        addSubview(scrollView)
        addSubview(mainButton)
        scrollView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(mainImageView)
        mainImageView.addSubview(setImageButton)
        verticalStack.addArrangedSubview(nameTextField)
        verticalStack.addArrangedSubview(descriptionTextField)
        verticalStack.setCustomSpacing(24, after: mainImageView)
        setNeedsUpdateConstraints()
    }
    
    func setImage(_ image: UIImage) {
        mainImageView.image = image
        setImageButton.setTitle("", for: .normal)
    }
    
    func setFilled(_ filled: Bool) {
        mainButton.isEnabled = filled
    }
    
    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -8),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
            verticalStack.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -24),
            verticalStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            verticalStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            verticalStack.widthAnchor.constraint(equalTo: widthAnchor, constant: -48)
        ])
    }
    
    private func setupMainButtonConstraints() {
        NSLayoutConstraint.activate([
            mainButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            mainButton.heightAnchor.constraint(equalToConstant: 48),
            mainButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
    
    private func setupSetImageButtonConstraints() {
        NSLayoutConstraint.activate([
            setImageButton.topAnchor.constraint(equalTo: mainImageView.topAnchor),
            setImageButton.bottomAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            setImageButton.leadingAnchor.constraint(equalTo: mainImageView.leadingAnchor),
            setImageButton.trailingAnchor.constraint(equalTo: mainImageView.trailingAnchor)
        ])
    }
    
    private func setupMainImageViewConstraints() {
        NSLayoutConstraint.activate([
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func setupTextFieldsConstraints() {
        [nameTextField, descriptionTextField].forEach { (tf) in
            NSLayoutConstraint.activate([
                tf.heightAnchor.constraint(equalToConstant: 96)
            ])
        }
    }
    
    @objc private func setImageButtonTapped() {
        controller.showImagePicker()
    }
}

extension DefaultNewPromotionView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            controller.setName(to: textField.text)
        case 2:
            controller.setDescription(to: textField.text)
        default:
            break
        }
    }
    
}
