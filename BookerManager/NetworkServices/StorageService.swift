//
//  StorageService.swift
//  BookerManager
//
//  Created by Ацамаз Бицоев on 15.09.2020.
//  Copyright © 2020 Ацамаз Бицоев. All rights reserved.
//

import FirebaseStorage
import UIKit

final class StorageService {
    
    func uploadImage(_ image: UIImage,
                     _ handler: @escaping (_ url: String?, _ errorString: String?) -> ()) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH-mm-ss-dd-MM-yyyy"
        let dateString = dateFormatter.string(from: currentDate)
        
        let imageRef = storageRef.child("images/promotions/\(dateString + " promotion").jpg")
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            handler(nil, "Картинка имеет неправильный формат")
            return
        }
        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard let _ = metadata else {
                handler(nil, error?.localizedDescription ?? "Что-то пошло не так...")
                return
            }
            imageRef.downloadURL { (url, error) in
                if let url = url {
                    handler(url.absoluteString, nil)
                } else {
                    handler(nil, error?.localizedDescription ?? "Что-то пошло не так...")
                }
            }
        }
    }
    
    func deleteFile(url: String,
                    _ handler: @escaping (Bool, String?) -> ()) {
        
        let storage = Storage.storage()
        let fileRef = storage.reference(forURL: url)
        fileRef.delete { (error) in
            if let error = error {
                handler(false, error.localizedDescription)
            } else {
                handler(true, nil)
            }
        }
    }
    
}
