//
//  SearchService.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import Foundation
import RxSwift

protocol SearchServiceable {
    func loadList(term: String, offset: Int) -> Single<AppListDTO>
}

class SearchService: SearchServiceable {
    func loadList(term: String, offset: Int = .zero) -> Single<AppListDTO> {
        let apiType = SearchAPI.list(term: term, offset: offset)
        return SessionManager.shared.request(apiType: apiType)
    }
}
