//
//  String+Extensions.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 04.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation

extension String {
    func onlyNumbers() -> String {
        let chars = self.compactMap { (char) -> String? in
            if Set(["1","2","3","4","5","6","7","8","9","0"]).contains(char) {
                return "\(char)"
            } else {
                return nil
            }
        }
        return chars.joined(separator: "")
    }
}
