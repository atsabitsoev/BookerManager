//
//  DefaultPromotionController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 04.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultNewPromotionController: UIViewController, NewPromotionControlling {
    
    fileprivate var newPromotionView: NewPromotionViewing!
    private var imagePicker: ImagePicker!
    private let promotionService = PromotionService()
    private lazy var alertManager = AlertManager(vc: self)
    
    private(set) var creatingPromotion = CreatingPromotion()
    
    override func loadView() {
        super.loadView()
        newPromotionView = DefaultNewPromotionView(controller: self)
        newPromotionView.configureView()
        newPromotionView.setFilled(false)
        view = newPromotionView
    }
    
    override func viewDidLoad() {
        title = "Новая акция"
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    func setName(to newName: String?) {
        creatingPromotion.name = newName
        newPromotionView.setFilled(creatingPromotion.isFilled)
    }
    
    func setDescription(to newDescription: String?) {
        creatingPromotion.description = newDescription
        newPromotionView.setFilled(creatingPromotion.isFilled)
    }
    
    func showImagePicker() {
        imagePicker.present(from: newPromotionView)
    }
    
    func createPromotionAction() {
        if creatingPromotion.isFilled {
            promotionService.createPromotion(
                withTitle: creatingPromotion.name!,
                description: creatingPromotion.description!,
                image: creatingPromotion.image!) { [weak self] (succeed, errorString) in
                    if succeed {
                        self?.alertManager.showAlert(title: "Ура!", message: "Акция успешно загружена", action: {
                            self?.navigationController?.popViewController(animated: true)
                        })
                    } else {
                        self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: nil)
                    }
            }
        }
    }
    
}

extension DefaultNewPromotionController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let image = image else { return }
        creatingPromotion.image = image
        newPromotionView.setImage(image)
        newPromotionView.setFilled(creatingPromotion.isFilled)
    }
}
