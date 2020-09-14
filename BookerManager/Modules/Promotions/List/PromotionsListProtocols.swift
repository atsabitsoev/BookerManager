//
//  Protocols.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit


protocol PromotionsListViewing: UIView {
    func configureView()
    func setPromotionItems(_ items: [PromotionItem])
}

protocol PromotionsListControlling: UIViewController {
    func showDeleteAlert(forPromotionId promotionId: String)
}
