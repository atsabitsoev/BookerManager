//
//  DefaultDiscountView.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 16.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultDiscountView: UIView, DiscountViewing {
    
    private unowned let controller: DiscountControlling
    
    private let qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    init(controller: DiscountControlling) {
        self.controller = controller
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setQrImageViewConstraints()
        super.updateConstraints()
    }
    
    
    func configureView(image: UIImage) {
        backgroundColor = UIColor.Background.primary
        addSubview(qrImageView)
        qrImageView.image = image
        setNeedsUpdateConstraints()
    }
    
    
    private func setQrImageViewConstraints() {
        NSLayoutConstraint.activate([
            qrImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            qrImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            qrImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -48),
            qrImageView.heightAnchor.constraint(equalTo: qrImageView.widthAnchor)
        ])
    }
    
}
