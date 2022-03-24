//
//  SearchAPI.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import Foundation

enum SearchAPI: APIType {
    case list(term: String, offset: Int)
    case detail(bundleID: String)
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
        case let .list(term, offset):
            return [
                "term": term,
                "media": "software",
                "entity": "software",
                "country": "KR",
                "offset": offset
            ]
        case .detail(let bundleID):
            return [
                "bundleId": bundleID
            ]
        }
    }

}
