//
//  EnterNameProtocols.swift
//  Booker
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

protocol EnterNameViewing: UIView {
    func configureView()
}

protocol EnterNameControlling: UIViewController {
    func nextButtonTapped(name: String, lastname: String?)
}
