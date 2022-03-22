//
//  SearchService.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import Foundation
import RxSwift

protocol SearchServiceable {
    func loadList(term: String) -> Single<AppListDTO>
    func loadDetail(name: String) -> Single<Bool>
}

class SearchService: SearchServiceable {
    func loadList(term: String) -> Single<AppListDTO> {
        let apiType = SearchAPI.list(term: term)
        return SessionManager.shared.request(apiType: apiType)
    }
    
    func loadDetail(name: String) -> Single<Bool> {
        .just(true)
    }
}
