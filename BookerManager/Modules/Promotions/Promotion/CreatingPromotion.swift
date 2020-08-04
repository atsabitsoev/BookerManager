//
//  CreatingPromotion.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 04.08.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import UIKit

struct CreatingPromotion {
    var name: String?
    var description: String?
    var image: UIImage?
    
    var isFilled: Bool {
        get {
            if let name = self.name,
                let description = self.description,
                let _ = self.image,
                !name.isEmpty,
                !description.isEmpty {
                return true
            } else {
                return false
            }
        }
    }
}
