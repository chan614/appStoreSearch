//
//  SearchAPI.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import Foundation

enum SearchAPI: APIType {
    case list(term: String)
    case detail(id: Int)
}

extension SearchAPI {
    var baseURL: URL {
        URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .list:
            return "search"
        case .detail:
            return "lookup"
        }
    }
    
    var params: [String: Any] {
        switch self {
        case .list(let term):
            return [
                "term": term,
                "media": "software"
            ]
        case .detail(let id):
            return [
                "bundleId": id
            ]
        }
    }

}
