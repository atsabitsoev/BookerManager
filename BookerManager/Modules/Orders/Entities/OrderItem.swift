//
//  OrderItem.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation

struct OrderItem {
    var date: String
    var personsCount: Int
    var name: String
    var state: OrderState
    var orderId: String
}
