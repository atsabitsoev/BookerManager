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
    private lazy var alertManager = AlertManager(vc: self)
    private let ordersService = OrdersService()
    
    override func loadView() {
        super.loadView()
        ordersView = DefaultOrdersView(controller: self)
        ordersView.configureView()
        view = ordersView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Брони"
        reloadOrders()
    }
    
    private func reloadOrders() {
        ordersService.getAllOrders { [weak self] (orders, error) in
            guard let orders = orders else {
                self?.alertManager.showAlert(title: "Ошибка", message: error ?? "Что-то пошло не так...", action: nil)
                return
            }
            let orderItems = orders.map { (order) -> OrderItem in
                let date = order.date
                let personsCount = order.personsCount
                let name = order.name
                let state = OrderState(rawValue: order.state) ?? .waiting
                let orderId = order.orderId
                let orderItem = OrderItem(date: date.toString(), personsCount: personsCount, name: name, state: state, orderId: orderId)
                return orderItem
            }
            self?.ordersView.setAllOrderItems(orderItems)
        }
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
