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
    private let authService = AuthService()
    
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
        if let phone = phoneNumber {
            authService.sendSmsCode(toPhone: phone) { (exists, error) in
                if !exists {
                    let errorString = error?.localizedDescription ?? "Менедженра с таким номером не существует"
                    self.alertManager.showAlert(title: "Ошибка", message: errorString, action: nil)
                } else {
                    self.enterPhoneView.showSmsTextField(true)
                }
            }
        } else {
            alertManager.showAlert(title: "Ошибка", message: "Введен неверный номер телефона", action: nil)
        }
    }
    
    func smsCodeEntered(code: String) {
        authService.authenticate(
            verificationCode: code) { (succeed, wasRegistered, error) in
                switch succeed {
                case true:
                    let mainTabBar = BMTabBarController()
                    mainTabBar.modalTransitionStyle = .crossDissolve
                    mainTabBar.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(
                        mainTabBar,
                        animated: true,
                        completion: nil
                    )
                case false:
                    self.alertManager.showAlert(
                        title: "Ошибка",
                        message: error?.localizedDescription ?? "Неизвестная ошибка",
                        action: nil
                    )
                }
        }
    }
}
