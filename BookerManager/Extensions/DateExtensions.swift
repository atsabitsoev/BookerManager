//
//  DateExtensions.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 13.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation


extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        return "\(dateFormatter.string(from: self)), \(timeFormatter.string(from: self))"
    }
}
