//
//  DefaultPromotionsController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 25.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultPromotionsListController: UIViewController, PromotionsListControlling {
    
    private var promotionsListView: PromotionsListViewing!
    private let promotionService = PromotionService()
    private lazy var alertManager = AlertManager(vc: self)
    
    private var promotions: [Promotion] = [] {
        didSet {
            self.promotionsListView.setPromotionItems(
                promotions
                    .sorted(by: { (promotion1, promotion2) -> Bool in
                        guard promotion1.creationDate != nil && promotion2.creationDate != nil else { return true }
                        if let creationDate1 = promotion1.creationDate {
                            return creationDate1 > (promotion2.creationDate ?? Date(timeIntervalSince1970: 0))
                        } else {
                            return true
                        }
                    })
                    .map({ (promotion) -> PromotionItem in
                        let title = promotion.title
                        let description = promotion.description
                        let image = promotion.image
                        return PromotionItem(
                            id: promotion.id,
                            imageUrl: image,
                            title: title,
                            description: description
                        )
                    })
            )
        }
    }
    
    override func loadView() {
        super.loadView()
        let newPromotionItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPromotionItemTapped))
        navigationItem.setRightBarButton(newPromotionItem, animated: true)
        promotionsListView = DefaultPromotionsListView(controller: self)
        promotionsListView.configureView()
        view = promotionsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Акции"
        fetchPromotions()
    }
    
    func showDeleteAlert(forPromotionId promotionId: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
            if let imageUrl = self.promotions.first(where: { (promotion) -> Bool in
                return promotion.id == promotionId
            })?.image {
                self.showConfirmDeleteAlert(promotionId: promotionId, imageUrl: imageUrl)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func fetchPromotions() {
        promotionService.getAllPromotions { [weak self] (promotions, errorString) in
            if let promotions = promotions {
                self?.promotions = promotions
            } else {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: nil)
            }
        }
    }
    
    private func showConfirmDeleteAlert(promotionId: String, imageUrl: String) {
        let alert = UIAlertController(title: "Вы уверены?", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { (_) in
            self.deleteAction(promotionId: promotionId, imageUrl: imageUrl)
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteAction(promotionId: String, imageUrl: String) {
        promotionService.deletePromotion(withId: promotionId, imageUrl: imageUrl) { [weak self] (succeed, errorString) in
            if !succeed {
                self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: nil)
            }
        }
    }
    
    @objc private func newPromotionItemTapped() {
        navigationController?.show(DefaultNewPromotionController(), sender: nil)
    }
    
}
