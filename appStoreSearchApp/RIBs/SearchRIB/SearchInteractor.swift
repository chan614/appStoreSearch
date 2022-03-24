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
    func routeToDetail(appInfoDTO: AppInfoDTO)
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
    
    var searchListRelay = ReplayRelay<[AppInfoDTO]>.create(bufferSize: 1)
    
    // MARK: - PresentableListener property
    
    var searchListObservable: Observable<[AppInfoDTO]> {
        searchListRelay.asObservable()
    }
    
    init(presenter: SearchPresentable, service: SearchService) {
        self.service = service
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func loadSearchList(term: String) {
        guard !term.isEmpty else {
            searchListRelay.accept([])
            return
        }
        
        service.loadList(term: term)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(
                with: self,
                onSuccess: { owner, result in
                    owner.searchListRelay.accept(result.results)
                },
                onFailure: { owner, error in
                    print(error)
                }
            ).disposeOnDeactivate(interactor: self)
    }
}


extension SearchInteractor: SearchInteractable {
    func detachDetail() {
        router?.detachDetail()
    }
}

extension SearchInteractor: SearchPresentableListener {
    func showDetail(item: AppInfoDTO) {
        router?.routeToDetail(appInfoDTO: item)
    }
    
    func search(term: String) {
        loadSearchList(term: term)
    }
}
