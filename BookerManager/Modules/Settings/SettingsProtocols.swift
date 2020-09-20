//
//  SettingsProtocols.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 05.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol SettingsViewing: UIView {
    func configureView()
}

protocol SettingsControlling: UIViewController {
    func workModeChanged(isWorking: Bool)
    func createDiscontAlert()
    func checkDiscountCamera()
    func quitButtonTapped()
}
