//
//  SearchInteractor.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs
import RxSwift
import RxRelay

protocol SearchRouting: ViewableRouting {
    func routeToDetail(bundleID: String)
    func detachDetail()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    
}

protocol SearchListener: AnyObject {
    
}

final class SearchInteractor: PresentableInteractor<SearchPresentable> {

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    let service: SearchService
    
    var searchListRelay = ReplaySubject<[AppInfoDTO]>.create(bufferSize: 1)
    
    init(presenter: SearchPresentable, service: SearchService) {
        self.service = service
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        loadSearchList(term: "카카오")
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func loadSearchList(term: String) {
        service.loadList(term: term)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(
                with: self,
                onSuccess: { owner, result in
                    owner.searchListRelay.onNext(result.results)
                },
                onFailure: { owner, error in
                    print(error)
                }
            ).disposeOnDeactivate(interactor: self)
    }
}


extension SearchInteractor: SearchInteractable {
    
}

extension SearchInteractor: SearchPresentableListener {
    var searchListObservable: Observable<[AppInfoDTO]> {
        searchListRelay.asObservable()
    }
    
    func showDetail(item: AppInfoDTO) {
        router?.routeToDetail(bundleID: item.bundleID)
    }
    
    func search(term: String) {
        loadSearchList(term: term)
    }
}
