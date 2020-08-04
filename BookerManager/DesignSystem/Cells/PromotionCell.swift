//
//  PromotionCell.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 04.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit
import SDWebImage

final class PromotionCell: UITableViewCell {
    
    static let identifier = "PromotionCell"
    
    private let horizontalInset: CGFloat = 26
    private let verticalInset: CGFloat = 20
    
    private let promotionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Cell.mainView
        return view
    }()
    private let shadowView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Cell.mainView
        view.layer.shadowColor = UIColor.Shadow.main.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.18
        return view
    }()
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Cell.mainView
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.title
        label.font = UIFont.Cell.bigTitle
        label.numberOfLines = 0
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Cell.description
        label.font = UIFont.Cell.description
        label.numberOfLines = 0
        return label
    }()
    private let descriptionStack: UIStackView = {
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
        setupPromotionImageConstraints()
        setupMainViewConstraints()
        setupShadowViewConstraints()
        setupDescriptionViewConstraints()
        setupDescriptionStackConstraints()
        super.updateConstraints()
    }
    
    func configureCell(
        imageUrl: String,
        title: String,
        description: String) {
        let placeholderImage = UIImage(named: "placeholder")
        if let url = URL(string: imageUrl) {
            promotionImage.sd_setImage(with: url, placeholderImage: placeholderImage)
        } else {
            promotionImage.image = placeholderImage
        }
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
    
    private func configureView() {
        selectionStyle = .none
        clipsToBounds = true
        contentView.backgroundColor = UIColor.Cell.background
        contentView.addSubview(shadowView)
        contentView.addSubview(mainView)
        mainView.addSubview(promotionImage)
        mainView.addSubview(descriptionView)
        descriptionView.addSubview(descriptionStack)
        descriptionStack.addArrangedSubview(titleLabel)
        descriptionStack.addArrangedSubview(descriptionLabel)
        setNeedsUpdateConstraints()
    }
    
    private func setupPromotionImageConstraints() {
        let imageWidth = UIScreen.main.bounds.width - 2 * horizontalInset
        let imageHeight = imageWidth
        NSLayoutConstraint.activate([
            promotionImage.heightAnchor.constraint(equalToConstant: imageHeight),
            promotionImage.widthAnchor.constraint(equalToConstant: imageWidth),
            promotionImage.topAnchor.constraint(equalTo: mainView.topAnchor),
            promotionImage.bottomAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 16),
            promotionImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            promotionImage.trailingAnchor.constraint(equalTo: promotionImage.trailingAnchor)
        ])
    }
    
    private func setupMainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalInset),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalInset),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset)
        ])
    }
    
    private func setupShadowViewConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: mainView.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor)
        ])
    }
    
    private func setupDescriptionViewConstraints() {
        NSLayoutConstraint.activate([
            descriptionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            descriptionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
        ])
    }
    
    private func setupDescriptionStackConstraints() {
        NSLayoutConstraint.activate([
            descriptionStack.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 16),
            descriptionStack.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: -16),
            descriptionStack.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16),
            descriptionStack.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16)
        ])
    }
}

