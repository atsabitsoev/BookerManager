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
}
