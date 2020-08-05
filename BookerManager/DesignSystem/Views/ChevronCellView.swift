//
//  ChevronCellView.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 05.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class ChevronCellView: UIView {
    
    private var action: (() -> Void)?
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.title
        label.font = UIFont.Cell.description
        return label
    }()
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chevronRight"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private let mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(title: String, action: (() -> Void)? = nil) {
        self.action = action
        mainLabel.text = title
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupHorizontalStackConstraints()
        setupChevronImageViewConstraints()
        setupMainButtonConstraints()
        super.updateConstraints()
    }
    
    private func configureView() {
        backgroundColor = UIColor.Background.secondary
        layer.cornerRadius = 16
        mainButton.addTarget(self, action: #selector(mainButtonTapped), for: .touchUpInside)
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(mainLabel)
        horizontalStack.addArrangedSubview(chevronImageView)
        addSubview(mainButton)
        setNeedsUpdateConstraints()
    }
    
    private func setupHorizontalStackConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupChevronImageViewConstraints() {
        NSLayoutConstraint.activate([
            chevronImageView.heightAnchor.constraint(equalToConstant: 16),
            chevronImageView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func setupMainButtonConstraints() {
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: topAnchor),
            mainButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc private func mainButtonTapped() {
        action?()
    }
    
}
