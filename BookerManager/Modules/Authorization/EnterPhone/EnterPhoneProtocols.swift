//
//  EnterPhoneProtocols.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 28.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol EnterPhoneView: UIView {
    func configureView()
    func showSmsTextField(_ show: Bool)
}

protocol EnterPhoneController: UIViewController {
    func sendCodeButtonTapped(phoneNumber: String?)
    func smsCodeEntered(code: String)
}
