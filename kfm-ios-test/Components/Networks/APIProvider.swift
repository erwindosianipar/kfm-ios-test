//
//  APIProvider.swift
//  kfm-ios-test
//
//  Created by Erwindo Sianipar on 12/02/22.
//

import UIKit

enum ErrorType: Error {
    case networkError(Error)
    case parsingError(Error)
    case dataNotFound
    
    var localizedDescription: String {
        switch self {
        case .networkError(let error):
            return error.localizedDescription
        case .parsingError:
            return scParsingError
        case .dataNotFound:
            return scDataNotFound
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(ErrorType)
}

internal final class APIProvider {
    
    static func dataRequest<T: Decodable>(endpoint: Endpoint, response: T.Type, completion: @escaping (Result<T>) -> Void) {
        guard let url = URL(string: endpoint.base + endpoint.path) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(Result.failure(ErrorType.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(ErrorType.dataNotFound))
                return
            }
            
            do {
                let decode = try JSONDecoder().decode(response.self, from: data)
                completion(Result.success(decode))
            } catch let error {
                completion(Result.failure(ErrorType.parsingError(error)))
            }
        }
        
        task.resume()
    }
}
