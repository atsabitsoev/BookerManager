//
//  PromotionService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 14.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore

final class PromotionService {
    
    private let storageService = StorageService()
    
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
                    let creationDateTS = promotionDict["creationDate"] as? Timestamp
                    let creationDate = Date(timeIntervalSince1970: Double(creationDateTS?.seconds ?? 0))
                    let promotion = Promotion(id: promotionDocument.documentID, title: title, description: description, image: image, creationDate: creationDate)
                    return promotion
                } else {
                    return nil
                }
            }
            handler(promotions, nil)
        }
    }
    
    func createPromotion(withTitle title: String,
                         description: String,
                         image: UIImage,
                         _ handler: @escaping (Bool, String?) -> ()) {
        
        storageService.uploadImage(image) { (url, error) in
            guard let url = url else {
                handler(false, "Не удалось загрузить картинку")
                return
            }
            let db = Firestore.firestore()
            guard let restaurantId = UserInfoService().restaurantId else {
                handler(false, "Ресторан не найден")
                return
            }
            let newPromotionData: [String: Any] = [
                "title": title,
                "description": description,
                "image": url,
                "creationDate": Date()
            ]
            db
                .collection("restaurants")
                .document(restaurantId)
                .collection("promotions")
                .addDocument(data: newPromotionData) { (error) in
                    if let error = error {
                        handler(false, error.localizedDescription)
                    } else {
                        handler(true, nil)
                    }
            }
        }
    }
    
    func deletePromotion(withId promotionId: String,
                         imageUrl: String,
                         _ handler: @escaping (Bool, String?) -> ()) {
        
        let db = Firestore.firestore()
        guard let restaurantId = UserInfoService().restaurantId else {
            handler(false, "Ресторан не найден")
            return
        }
        
        db.collection("restaurants").document(restaurantId).collection("promotions").document(promotionId).getDocument { (document, error) in
            if let promotionDocument = document {
                promotionDocument.reference.delete { [weak self] (error) in
                    if let error = error {
                        handler(false, error.localizedDescription)
                    } else {
                        self?.storageService.deleteFile(url: imageUrl, { (succeed, errorString) in
                            let finalErrorString = succeed ? nil : (errorString ?? "Что-то пошло не так...")
                            handler(succeed, finalErrorString)
                        })
                    }
                }
            } else {
                handler(false, error?.localizedDescription ?? "Ресторан не найден")
            }
        }
    }
    
}
