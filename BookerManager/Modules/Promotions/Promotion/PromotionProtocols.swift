//
//  PromotionProtocols.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 04.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol NewPromotionViewing: UIView {
    func configureView()
    func setImage(_ image: UIImage)
    func setFilled(_ filled: Bool)
}

protocol NewPromotionControlling: UIViewController {
    var creatingPromotion: CreatingPromotion { get }
    
    func setName(to newName: String?)
    func setDescription(to newDescription: String?)
    func showImagePicker()
    func createPromotionAction()
}
