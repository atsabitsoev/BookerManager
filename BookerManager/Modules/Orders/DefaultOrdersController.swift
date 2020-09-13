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
    
    private var allOrders: [Order] = [] {
        didSet {
            self.setOrderItemsToView(orders: allOrders)
        }
    }
    
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
            self?.allOrders = orders
        }
    }
    
    private func setOrderItemsToView(orders: [Order]) {
        let orderItems = orders.map { (order) -> OrderItem in
            let date = order.date
            let personsCount = order.personsCount
            let name = order.name
            let state = OrderState(rawValue: order.state) ?? .waiting
            let orderId = order.orderId
            let orderItem = OrderItem(date: date.toString(), personsCount: personsCount, name: name, state: state, orderId: orderId)
            return orderItem
        }
        self.ordersView.setAllOrderItems(orderItems)
    }
    
    func confirmAction(forOrderId orderId: String) {
        ordersService.confirmOrder(orderId: orderId) { [weak self] (succeed, errorString) in
            if !succeed {
                self?.alertManager.showAlert(
                    title: "Ошибка",
                    message: errorString ?? "Что-то пошло не так...",
                    action: nil
                )
            }
        }
    }
    
    func rejectAction(forOrderId orderId: String) {
        print("Отменить заказ с id: \(orderId)")
        let alert = TypeAlertController(
            alertTitle: "Причина отказа",
            buttonTitle: "Отправить отказ",
            buttonState: .destructive,
            placeholder: "Сообщение...") { [weak self] (newText) in
                guard let message = newText else {
                    self?.alertManager.showAlert(title: "Ошибка", message: "Причина отказа не указана", action: nil)
                    return
                }
                if let currentOrder = self?.allOrders.first(where: { (order) -> Bool in
                    return order.orderId == orderId
                }) {
                    self?.ordersService.denieOrder(orderId: orderId,
                                                   userPhone: currentOrder.phone,
                                                   message: message, { (succeed, errorString) in
                        if !succeed {
                            self?.alertManager.showAlert(title: "Ошибка", message: errorString ?? "Что-то пошло не так...", action: nil)
                            return
                        }
                    })
                }
                
        }
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
    
    func callAction(forOrderId orderId: String) {
        if let currentOrder = allOrders.first(where: { (order) -> Bool in
            return order.orderId == orderId
        }) {
            let url = URL(string: "tel://+\(currentOrder.phone)")!

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }
}
