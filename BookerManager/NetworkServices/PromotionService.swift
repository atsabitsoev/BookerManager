//
//  PromotionService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 14.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore

final class PromotionService {
    
    func getAllPromotions(_ handler: @escaping ([Promotion]?, String?) -> ()) {
        
        let db = Firestore.firestore()
        guard let restaurantId = UserInfoService().restaurantId else {
            handler(nil, "Ресторан не найден")
            return
        }
        
        db.collection("restaurants").document(restaurantId).collection("promotions").addSnapshotListener { (query, error) in
            
            guard let promotionDocuments = query?.documents else {
                handler(nil, "Что-то пошло не так...")
                return
            }
            
            let promotions = promotionDocuments.compactMap { (promotionDocument) -> Promotion? in
                let promotionDict = promotionDocument.data()
                if let title = promotionDict["title"] as? String,
                    let description = promotionDict["description"] as? String,
                    let image = promotionDict["image"] as? String {
                    let promotion = Promotion(id: promotionDocument.documentID, title: title, description: description, image: image)
                    return promotion
                } else {
                    return nil
                }
            }
            handler(promotions, nil)
        }
    }
    
    func deletePromotion(withId promotionId: String,
                         _ handler: @escaping (Bool, String?) -> ()) {
        
        let db = Firestore.firestore()
        guard let restaurantId = UserInfoService().restaurantId else {
            handler(false, "Ресторан не найден")
            return
        }
        
        db.collection("restaurants").document(restaurantId).collection("promotions").document(promotionId).getDocument { (document, error) in
            if let promotionDocument = document {
                promotionDocument.reference.delete { (error) in
                    if let error = error {
                        handler(false, error.localizedDescription)
                    } else {
                        handler(true, nil)
                    }
                }
            } else {
                handler(false, error?.localizedDescription ?? "Ресторан не найден")
            }
        }
    }
    
}
