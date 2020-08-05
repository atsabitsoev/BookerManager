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
        print("Показать alert с вводом строки для создания скидки")
    }
    
    func checkDiscountCamera() {
        print("Открыть камеру для сканирования штрихкода скидки и проверки ее актуальности")
    }
}
