//
//  UserInfoService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 13.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Foundation

final class UserInfoService {
    
    var restaurantId: String? {
        get {
            return UserDefaults.standard.string(forKey: "restaurantId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "restaurantId")
        }
    }
    
    func clearAll() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
