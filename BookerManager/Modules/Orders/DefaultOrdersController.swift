//
//  DefaultOrdersController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultOrdersController: UIViewController, OrdersControlling {
    
    private var ordersView: OrdersView!
    
    override func loadView() {
        super.loadView()
        ordersView = DefaultOrdersView(controller: self)
        ordersView.configureView()
        view = ordersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Брони"
    }
    
    func confirmAction(forOrderId orderId: String) {
        print("Подтвердить заказ с id: \(orderId)")
    }
    func rejectAction(forOrderId orderId: String) {
        print("Отменить заказ с id: \(orderId)")
        let alert = TypeAlertController(
            alertTitle: "Причина отказа",
            buttonTitle: "Отправить отказ",
            buttonState: .destructive,
            placeholder: "Сообщение...") { (newText) in
                print("Отправить отказ с текстом: \(newText ?? "Текст отсутствует")")
        }
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
    func callAction(forOrderId orderId: String) {
        print("Позвонить по заказу с id: \(orderId)")
    }
}
