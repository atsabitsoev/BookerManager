//
//  OrdersService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 13.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseFirestore

final class OrdersService {
    
    func getAllOrders(_ handler: @escaping ([Order]?, String?) -> ()) {
        
        let db = Firestore.firestore()
        guard let restaurantId = UserInfoService().restaurantId else {
            handler(nil, "Ресторан не найден")
            return
        }
        
        db
            .collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .addSnapshotListener { (query, error) in
                
            if let error = error {
                handler(nil, error.localizedDescription)
                return
            }
            
            guard let documents = query?.documents else {
                handler(nil, "Неизвестная ошибка")
                return
            }
            
            print(documents.count)
            
            let orders = documents.compactMap { [weak self] (document) -> Order? in
                let documentData = document.data()
                let order = self?.parseJsonToOrder(documentData, orderId: document.documentID)
                return order
            }
            handler(orders, nil)
        }
    }
    
    func confirmOrder(orderId: String,
                      _ handler: @escaping (Bool, String?) -> ()) {
        let db = Firestore.firestore()
        guard let restaurantId = UserInfoService().restaurantId else {
            handler(false, "Ресторан не найден")
            return
        }
        let fieldsToUpdate = ["status": "ready"]
        
        db
            .collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .document(orderId)
            .updateData(fieldsToUpdate) { (error) in
                if let error = error {
                    handler(false, error.localizedDescription)
                } else {
                    handler(true, nil)
                }
        }
    }
    
    func denieOrder(orderId: String,
                    userPhone: String,
                    message: String,
                    _ handler: @escaping (Bool, String?) -> ()) {
        let db = Firestore.firestore()
        db.collection("users").whereField("phone", isEqualTo: userPhone).getDocuments { (query, error) in
            guard let documents = query?.documents else {
                handler(false, error?.localizedDescription ?? "Неизвестная ошибка")
                return
            }
            guard let document = documents.first else {
                handler(false, "Пользователь не найден")
                return
            }
            
            let fieldsToUpdate = ["activeMessage": message]
            document.reference.updateData(fieldsToUpdate) { [weak self] (error) in
                if let error = error {
                    handler(false, error.localizedDescription)
                } else {
                    self?.deleteOrder(orderId: orderId, handler)
                }
            }
        }
    
    }
    
    private func deleteOrder(orderId: String,
                             _ handler: @escaping (Bool, String?) -> ()) {
        
        guard let restaurantId = UserInfoService().restaurantId else {
            handler(false, "Ресторан не найден")
            return
        }
        let db = Firestore.firestore()
        
        db
            .collection("restaurants")
            .document(restaurantId)
            .collection("orders")
            .document(orderId)
            .delete { (error) in
                
            if let error = error {
                handler(false, error.localizedDescription)
            } else {
                handler(true, nil)
            }
        }
    }
    
    private func parseJsonToOrder(_ json: [String: Any], orderId: String) -> Order? {
        guard let name = json["customerName"] as? String,
        let dateTimeStamp = json["dateTime"] as? Timestamp,
        let personNumber = json["personNumber"] as? Int,
        let status = json["status"] as? String,
        let phone = json["phone"] as? String else {
            print("Ошибка парсинга")
            return nil
        }
        let dateTime = dateTimeStamp.dateValue()
        let order = Order(date: dateTime, personsCount: personNumber, name: name, state: status, phone: phone, orderId: orderId)
        return order
    }
    
}
