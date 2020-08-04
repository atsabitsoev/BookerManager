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
    }
    
    func showDeleteAlert(forPromotionId promotionId: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (_) in
            self.showConfirmDeleteAlert(promotionId: promotionId)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showConfirmDeleteAlert(promotionId: String) {
        let alert = UIAlertController(title: "Вы уверены?", message: nil, preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { (_) in
            self.deleteAction(promotionId: promotionId)
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func deleteAction(promotionId: String) {
        print("Удаляю акцию с id \(promotionId)")
    }
    
    @objc private func newPromotionItemTapped() {
        navigationController?.show(DefaultNewPromotionController(), sender: nil)
    }
    
}
