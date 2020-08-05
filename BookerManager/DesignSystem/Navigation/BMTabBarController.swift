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
        tabBar.barTintColor = UIColor.Background.tabBar
        tabBar.tintColor = UIColor.Button.standard
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        let ordersVC = BMNavigationController(rootViewController: DefaultOrdersController())
        ordersVC.tabBarItem = UITabBarItem(title: "Брони", image: UIImage(named: "orderTabBarItem"), tag: 0)
        let promotionsVC = BMNavigationController(rootViewController: DefaultPromotionsListController())
        promotionsVC.tabBarItem = UITabBarItem(title: "Акции", image: UIImage(named: "promotionsTabBarItem"), tag: 1)
        let settingsVC = BMNavigationController(rootViewController: DefaultSettingsController())
        settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "settingsTabBarItem"), tag: 2)
        viewControllers = [ordersVC, promotionsVC, settingsVC]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
