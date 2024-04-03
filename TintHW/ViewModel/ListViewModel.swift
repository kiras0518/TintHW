//
//  ListViewModel.swift
//  TintHW
//
//  Created by Ting on 2024/3/31.
//

import Foundation
import UIKit

class PhotoViewModel {
    
    var photos = [PhotosCellModel]()

    func fetchPhotos(completion: @escaping (Result<[PhotosCellModel], TintError>) -> Void) {
        
        APIManager.shared.fetchGenericJSONData(endPoint: APIEndpoints.photos) { (result: Result<[PhotosCellModel], TintError>) in
            switch result {
            case .success(let photos):
                self.photos = photos
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadImage(photoPath: String, completion: @escaping (UIImage?) -> Void) {
        
        // 先檢查緩存中是否存在圖片資料
        if let cachedImage = ImageCache.shared.image(for: photoPath) {
            print("cachedImage", cachedImage, photoPath)
            completion(cachedImage)
            return
        }
        // 如果緩存中不存在，從網路下載圖片資料
        guard let url = URL(string: photoPath) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            // 下載完成後圖片資料緩存到 NSCache 中
            if let image = UIImage(data: data) {
                ImageCache.shared.save(image, for: photoPath)
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

