//
//  AlertManager.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 29.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class AlertManager {
    
    private var vc: UIViewController
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    func showAlert(title: String, message: String, action: (() -> Void)?) {
        let alert = SimpleAlertController(title: title, message: message, action: action)
        vc.present(alert, animated: true, completion: nil)
    }
}
