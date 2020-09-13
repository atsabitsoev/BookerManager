//
//  OrdersProtocols.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol OrdersView: UIView {
    func configureView()
    func setAllOrderItems(_ items: [OrderItem])
    func alertOrderActions()
}

protocol OrdersControlling: UIViewController {
    func confirmAction(forOrderId orderId: String)
    func rejectAction(forOrderId orderId: String)
    func callAction(forOrderId orderId: String)
}
