//
//  BMTabBarController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BMTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor.Background.secondary
        tabBar.tintColor = UIColor.Button.standard
        let ordersVC = BMNavigationController(rootViewController: DefaultOrdersController())
        ordersVC.tabBarItem = UITabBarItem(title: "Брони", image: UIImage(named: "orderTabBarItem"), tag: 0)
        let promotionsVC = BMNavigationController(rootViewController: DefaultPromotionsController())
        promotionsVC.tabBarItem = UITabBarItem(title: "Акции", image: UIImage(named: "promotionsTabBarItem"), tag: 1)
        viewControllers = [ordersVC, promotionsVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
