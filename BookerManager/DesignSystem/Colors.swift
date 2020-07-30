//
//  Colors.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 30.07.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct Background {
        static let primary = UIColor(named: "backgroundPrimary")!
        static let secondary = UIColor(named: "backgroundSecondary")!
        static let title = UIColor(named: "backgroundTitle")!
    }
    
    struct Button {
        static let standard = UIColor(named: "buttonTapOnMe")!
        static let destructive = UIColor(named: "buttonDestructive")!
        static let title = UIColor(named: "buttonTitle")!
        static let cancel = UIColor(named: "buttonCancel")!
    }
    
    struct Shadow {
        static let main = UIColor(named: "shadowMain")!
    }
    
    struct Cell {
        static let title = UIColor(named: "cellTitle")!
    }
    
    struct Alert {
        static let confirm = UIColor(named: "alertConfirm")!
        static let reject = UIColor(named: "alertReject")!
        static let simple = UIColor(named: "alertSimple")!
        static let title = UIColor(named: "alertTitle")!
    }
}
