//
//  DefaultDiscountController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 16.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultDiscountController: UIViewController, DiscountControlling {
    
    private var discountView: DiscountViewing!
    
    private let qrCode: UIImage
    private let discountDescription: String
    
    
    init(qrCode: UIImage, discountDescription: String) {
        self.qrCode = qrCode
        self.discountDescription = discountDescription
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        discountView = DefaultDiscountView(controller: self)
        discountView.configureView(image: qrCode)
        self.view = discountView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = discountDescription
    }
    
}
