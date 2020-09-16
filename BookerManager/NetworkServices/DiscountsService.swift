//
//  DiscountsService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 16.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore
import EFQRCode

final class DiscountsBackendService {
    
    func deleteDiscount(withId id: String,
                        userId: String,
                        handler: @escaping (Bool, String?) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userId).collection("discounts").document(id)
        docRef.delete { (error) in
            if let error = error {
                handler(false, error.localizedDescription)
            } else {
                handler(true, nil)
            }
        }
    }
    
    func checkDiscountExists(discountId: String,
                             userId: String,
                             handler: @escaping (Bool, String?) -> ()) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userId).collection("discounts").document(discountId)
        docRef.getDocument { (document, errorString) in
            if let document = document, document.exists {
                handler(true, nil)
            } else {
                handler(false, "Скидка недействительна")
            }
        }
    }
    
    
    fileprivate func generateNewDiscountId() -> String {
        let db = Firestore.firestore()
        return db.collection("users").document().documentID
    }
}

final class DiscountsQRService {
    
    private let devider = "•¶§∞¶∞£¢§£∞¢∞"
    
    func generateNewDiscountQR(description: String) -> UIImage? {
        let discountBackendService = DiscountsBackendService()
        let id = discountBackendService.generateNewDiscountId()
        let content = "\(id)\(devider)\(description)"
        
        if let qrCode = EFQRCode.generate(content: content) {
            return UIImage(cgImage: qrCode)
        } else {
            return nil
        }
    }
    
    func getDiscount(from string: String) -> Discount? {
        let components = string.components(separatedBy: devider)
        guard components.count == 3 else { return nil }
        let id = components[0]
        let description = components[1]
        let userId = components[2]
        return Discount(id: id, userId: userId, description: description)
    }
    
}
