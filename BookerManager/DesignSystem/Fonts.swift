//
//  Fonts.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

extension UIFont {
    
    struct Cell {
        static let bigTitle = UIFont.systemFont(ofSize: 24, weight: .bold)
        static let title = UIFont.systemFont(ofSize: 20)
    }
    
    struct Alert {
        static let title = UIFont.systemFont(ofSize: 18, weight: .semibold)
        static let textField = UIFont.systemFont(ofSize: 14)
    }
    
    struct Button {
        static let main = UIFont.systemFont(ofSize: 14)
        static let cancel = UIFont.systemFont(ofSize: 14)
    }
}
