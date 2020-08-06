//
//  DefaultEnterPhoneController.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 28.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultEnterPhoneController: UIViewController, EnterPhoneController {
    
    private var enterPhoneView: EnterPhoneView!
    private var alertManager: AlertManager!
    
    override func loadView() {
        super.loadView()
        enterPhoneView = DefaultEnterPhoneView(controller: self)
        enterPhoneView.configureView()
        view = enterPhoneView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        self.alertManager = AlertManager(vc: self)
    }
    
    func sendCodeButtonTapped(phoneNumber: String?) {
        if let _ = phoneNumber {
            enterPhoneView.showSmsTextField(true)
        } else {
            alertManager.showAlert(title: "Ошибка", message: "Введен неверный номер телефона", action: nil)
        }
    }
}
