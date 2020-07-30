//
//  BMNavigationController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class BMNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = UIColor.Background.secondary
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Background.title]
        navigationBar.tintColor = UIColor.Button.tapOnMe
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .default }
}
