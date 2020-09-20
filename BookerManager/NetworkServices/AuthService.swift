//
//  AuthService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 8/15/20.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import Firebase

final class AuthService {
    
    var verificationId: String? {
        get {
            return UserDefaults.standard.string(forKey: "verificationId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "verificationId")
        }
    }
    
    private func checkManagerExist(withPhone phone: String, handler: @escaping (Bool, Error?) -> ()) {
        let db = Firestore.firestore()
        
        db.collection("restaurants").whereField("managers", arrayContains: phone).getDocuments { [weak self] (query, error) in
            if let error = error {
                handler(false, error)
                return
            }
            guard let restaurantDoc = query?.documents.first else {
                handler(false, nil)
                return
            }
            let restaurantId = restaurantDoc.documentID
            self?.saveRestaurantId(restaurantId)
            
            handler(true, nil)
        }
    }
    
    func sendSmsCode(toPhone phone: String, handler: @escaping (Bool, Error?) -> ()) {
        checkManagerExist(withPhone: phone) { (exists, error) in
            if !exists {
                handler(exists, error)
            } else {
                PhoneAuthProvider.provider().verifyPhoneNumber("+" + phone, uiDelegate: nil) { (verificationId, error) in
                    if let verificationId = verificationId {
                        self.verificationId = verificationId
                    }
                    handler(verificationId != nil, error)
                }
            }
        }
    }
    
    func authenticate(verificationCode: String,
                      handler: @escaping (_ succeed: Bool, _ wasRegistered: Bool, _ error: Error?) -> ()) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId ?? "",
            verificationCode: verificationCode
        )
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                handler(false, false, error)
                return
            }
            guard let user = result?.user,
                let userInfo = result?.additionalUserInfo else {
                handler(false, false, nil)
                return
            }
            let wasRegisteredEarlier = !userInfo.isNewUser
            handler(true, wasRegisteredEarlier, nil)
            print(user)
        }
    }
    
    func logout() throws {
        do {
            try Auth.auth().signOut()
            UserInfoService().clearAll()
        } catch {
            return
        }
    }
    
    private func saveRestaurantId(_ id: String) {
        UserInfoService().restaurantId = id
    }

    
}
