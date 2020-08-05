//
//  SwitchView.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 05.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class SwitchView: UIView {
    
    private var action: ((Bool) -> Void)?
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.title
        label.font = UIFont.Cell.description
        return label
    }()
    private let mainSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = UIColor.Button.standard
        return switchControl
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(
        title: String,
        isOn: Bool,
        action: ((Bool) -> Void)?
    ) {
        mainLabel.text = title
        mainSwitch.setOn(isOn, animated: false)
        self.action = action
        super.init(frame: .zero)
        configureView()
    }
    
    private func configureView() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(mainLabel)
        horizontalStack.addArrangedSubview(mainSwitch)
        backgroundColor = UIColor.Background.secondary
        layer.cornerRadius = 16
        mainSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupHorizontalStackConstraints()
        super.updateConstraints()
    }
    
    private func setupHorizontalStackConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func switchChanged() {
        action?(mainSwitch.isOn)
    }
}
