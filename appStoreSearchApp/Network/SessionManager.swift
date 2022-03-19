//
//  SessionManager.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import Foundation
import RxSwift

enum NetworkError: Error {
    case notResponse
    case invaildParam
}

class SessionManager {
    static let shared = SessionManager()
    
    private let session = URLSession.shared
    
    func request<T: Codable>(apiType: APIType) -> Single<T> {
        guard let components = self.urlComponents(apiType: apiType),
              let url = components.url
        else {
            return .error(NetworkError.invaildParam)
        }
        
        return .create { [weak self] single in
            
            self?.session.dataTask(with: url) { data, response, error in
                do {
                    let successRange = 200..<300
                    
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                    
                    if !successRange.contains(statusCode), let error = error {
                        throw error
                    }
                    
                    guard let data = data else {
                        throw NetworkError.notResponse
                    }
                
                    let model = try JSONDecoder().decode(T.self, from: data)
                    single(.success(model))
                    
                } catch {
                    single(.failure(error))
                }
            }.resume()
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
    }
    
    private func urlComponents(apiType: APIType) -> URLComponents? {
        let url = apiType.baseURL
            .appendingPathComponent(apiType.path)
            .appendingPathComponent("?")
        
        let queryItems = apiType.params.map {
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        }
        
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems?.append(contentsOf: queryItems)
        
        return components
    }
}
