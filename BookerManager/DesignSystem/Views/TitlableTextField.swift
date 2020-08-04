//
//  TitlableTextField.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 28.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import PhoneNumberKit

class TitlableTextField: UIView {
    
    var delegate: UITextFieldDelegate? {
        didSet {
            mainTextField.delegate = delegate
        }
    }
    var text: String? {
        get {
            return mainTextField.text
        } set {
            mainTextField.text = newValue
        }
    }
    override var tag: Int {
        didSet {
            mainTextField.tag = tag
        }
    }
    
    private var title: String
    private var placeholder: String
    var textColor: UIColor { return UIColor.Background.title }
    var textFieldBackgroundColor: UIColor { return UIColor.Background.title }
    var keyboardAppearance: UIKeyboardAppearance { return .dark }
    
    private let titleInsetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.font = UIFont.Label.forTextField
        label.textColor = self.textColor
        label.text = self.title
        return label
    }()
    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private lazy var mainTextField: UITextField = { [unowned self] in
        let textField = self.getBaseTextField()
        textField.placeholder = self.placeholder
        textField.font = UIFont.TextField.autorization
        textField.textColor = self.textColor
        textField.backgroundColor = self.textFieldBackgroundColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 1))
        textField.layer.cornerRadius = 16
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.keyboardAppearance = self.keyboardAppearance
        return textField
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(
        title: String,
        placeholder: String = "",
        textType: UITextContentType? = nil,
        keyboardType: UIKeyboardType? = nil
        ) {
        self.title = title
        self.placeholder = placeholder
        super.init(frame: .zero)
        if let textType = textType {
            mainTextField.textContentType = textType
        }
        if let keyboardType = keyboardType {
            mainTextField.keyboardType = keyboardType
        }
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            horizontalStackView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            titleInsetView.widthAnchor.constraint(equalToConstant: 16)
        ])
        super.updateConstraints()
    }
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        mainTextField.becomeFirstResponder()
        return true
    }
    
    func addTarget(target: Any?, action: Selector, for event: UIControl.Event) {
        mainTextField.addTarget(target, action: action, for: event)
    }
    
    func getBaseTextField() -> UITextField {
        return UITextField()
    }
    
    private func configureView() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(titleInsetView)
        horizontalStackView.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(mainTextField)
        setNeedsUpdateConstraints()
    }
    
}
