//
//  NetworkService.swift
//  TintHW
//
//  Created by Ting on 2024/3/30.
//

import Foundation
import Alamofire
import UIKit

protocol ObserveDelegate: AnyObject {
    func didReceiveData() -> Void
}

protocol APIEndpoint {
    var path: String { get }
}

enum APIEndpoints: APIEndpoint {
    
    //可依據不同 path 網址
    case photos
    case photoPage(page: Int, limit: Int)
    
    var path: String {
        switch self {
        case .photos:
            return "/photos"
        case .photoPage(let page, let limit):
            return "/photos?_page=\(page)&_limit=\(limit)"
        }
    }
}

enum TintError: Error {
    case urlMissing, requestError(String)
    case afError(AFError)
}


final class APIManager {
    
    static let shared: APIManager = .init()
    
    private let baseURL: String = "https://jsonplaceholder.typicode.com"

    func fetchGenericJSONData<T: Codable>(endPoint: APIEndpoint, completion: @escaping (Result<T, TintError>) -> Void) {
        
        let endpoint = baseURL + endPoint.path
        
        print("fetchGenericJSONData", endpoint)
        
        AF.request(endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(TintError.afError(error)))
                }
            }
    }
}
