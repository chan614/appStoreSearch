//
//  DetailInteractor.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs
import RxSwift

protocol DetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol DetailPresentable: Presentable {
    var listener: DetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol DetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class DetailInteractor: PresentableInteractor<DetailPresentable> {

    weak var router: DetailRouting?
    weak var listener: DetailListener?
    
    let service: SearchService
    let bundleID: String
    
    init(presenter: DetailPresentable, service: SearchService, bundleID: String) {
        self.service = service
        self.bundleID = bundleID
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
    
    func loadDetail() {
        
    }
}

extension DetailInteractor: DetailInteractable {
    
}

extension DetailInteractor: DetailPresentableListener {
    
}
