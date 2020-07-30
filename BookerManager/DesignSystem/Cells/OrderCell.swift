//
//  OrderCell.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class OrderCell: UITableViewCell {
    
    static let identifier = "OrderCell"
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Background.primary
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.Shadow.main.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Cell.bigTitle
        label.textColor = UIColor.Background.title
        return label
    }()
    private let personsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.Cell.title
        label.textColor = UIColor.Cell.title
        return label
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.Cell.title
        label.textColor = UIColor.Cell.title
        return label
    }()
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupMainViewConstraints()
        setupVerticalStackConstraints()
        super.updateConstraints()
    }
    
    func configureCell(
        date: String,
        personsCount: Int,
        name: String) {
        dateLabel.text = date
        personsCountLabel.text = personsString(from: personsCount)
        nameLabel.text = name
    }
    
    private func configureView() {
        contentView.backgroundColor = UIColor.Background.primary
        contentView.addSubview(mainView)
        mainView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(dateLabel)
        verticalStack.addArrangedSubview(personsCountLabel)
        verticalStack.addArrangedSubview(nameLabel)
        setNeedsUpdateConstraints()
        selectionStyle = .none
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupVerticalStackConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            verticalStack.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -12),
            verticalStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ])
    }
    
    private func personsString(from count: Int) -> String {
        var additionalString: String
        if (count > 0 && count < 11) || count > 14 {
            if count % 10 == 1 {
                additionalString = "персона"
            } else if count % 10 > 1 && count % 10 < 5 {
                additionalString = "персоны"
            } else {
                additionalString = "персон"
            }
        } else {
            additionalString = "персон"
        }
        return "\(count) \(additionalString)"
    }
    
    private func animateSelection(_ selected: Bool) {
        let transformScale: CGFloat = selected ? 0.9 : 1
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1) {
                self.mainView.transform = CGAffineTransform(scaleX: transformScale, y: transformScale)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        animateSelection(selected)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            animateSelection(true)
        } else if !isSelected {
            animateSelection(false)
        }
    }
    
}
