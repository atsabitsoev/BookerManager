//
//  DefaultPromotionsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultPromotionsController: UIViewController, PromotionsControlling {
    
    private var promotionsView: PromotionsViewing!

    
    override func loadView() {
        super.loadView()
        title = "Акции"
        let newPromotionItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPromotionItemTapped))
        navigationItem.setRightBarButton(newPromotionItem, animated: true)
        promotionsView = DefaultPromotionsView(controller: self)
        promotionsView.configureView()
        view = promotionsView
    }
    
    @objc private func newPromotionItemTapped() {
        print("Переход на экран создания новой акции")
    }
    
}
