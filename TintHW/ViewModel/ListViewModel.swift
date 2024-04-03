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
    
    var currentPage = 1
    var limitCount = 40

    func fetchNextPhotos(completion: @escaping (Result<[PhotosCellModel], Error>) -> Void) {

        APIManager.shared.fetchGenericJSONData(endPoint: APIEndpoints.photoPage(page: currentPage, limit: limitCount)) { (result: Result<[PhotosCellModel], TintError>) in
            switch result {
            case .success(let photos):
             
                self.photos.append(contentsOf: photos)
               
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPhotos(completion: @escaping (Result<[PhotosCellModel], Error>) -> Void) {
        
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
        
        guard let url = URL(string: photoPath) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            completion(image)
            
        }.resume()
    }
}
