//
//  DefaultSettingsController.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 05.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

final class DefaultSettingsController: UIViewController, SettingsControlling {
    
    private var settingsView: SettingsViewing!
    private lazy var alertManager = AlertManager(vc: self)
    private let discountsService = DiscountsQRService()
    
    override func loadView() {
        settingsView = DefaultSettingsView(controller: self)
        settingsView.configureView()
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Настройки"
    }
    
    func workModeChanged(isWorking: Bool) {
        print(isWorking ? "Сейчас работаю" : "Сейчас не работаю")
    }
    
    func createDiscontAlert() {
        let alert = TypeAlertController(
            alertTitle: "Новая скидка",
            buttonTitle: "Создать",
            buttonState: .standard,
            placeholder: "Описание скидки",
            textInputNecessary: true) { [weak self] (discountDescription) in
                guard let self = self,
                    let discountDescription = discountDescription,
                    let qrCode = self.discountsService.generateNewDiscountQR(description: discountDescription) else { return }
                self.navigationController?.show(DefaultDiscountController(qrCode: qrCode, discountDescription: discountDescription), sender: nil)
        }
        alert.modalPresentationStyle = .overCurrentContext
        alert.modalTransitionStyle = .crossDissolve
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
    
    func checkDiscountCamera() {
        self.navigationController?.show(ScannerViewController(), sender: nil)
    }
    
    func quitButtonTapped() {
        alertQuit()
    }
    
    @objc private func alertQuit() {
        let alert = UIAlertController(title: "Выйти?", message: "Вы уверены, что хотите выйти из своего аккаунта?", preferredStyle: .actionSheet)
        let quitAction = UIAlertAction(title: "Выйти", style: .destructive) { (_) in
            self.quit()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(quitAction)
        alert.addAction(cancelAction)
        self.tabBarController?.present(alert, animated: true, completion: nil)
    }
    
    private func quit() {
        do {
            try AuthService().logout()
            let authVC = DefaultEnterPhoneController()
            let authNav = BMNavigationController(rootViewController: authVC)
            authNav.modalPresentationStyle = .fullScreen
            authNav.modalTransitionStyle = .flipHorizontal
            self.tabBarController?.present(authNav, animated: true, completion: nil)
        } catch {
            return
        }
    }
}
