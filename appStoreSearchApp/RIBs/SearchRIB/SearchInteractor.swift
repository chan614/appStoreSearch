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
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchInteractor: PresentableInteractor<SearchPresentable> {

    weak var router: SearchRouting?
    weak var listener: SearchListener?

    let service: SearchService
    
    var searchList: Observable<[AppInfoDTO]> {
        searchListRelay.asObservable()
    }
    var searchListRelay = ReplayRelay<[AppInfoDTO]>.create(bufferSize: 1)
    
    init(presenter: SearchPresentable, service: SearchService) {
        self.service = service
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func loadSearchList(term: String) {
        service.loadList(term: term)
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
    
}

extension SearchInteractor: SearchPresentableListener {
    func search(term: String) {
        loadSearchList(term: term)
    }
}
