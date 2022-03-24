//
//  MainInteractor.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import RIBs
import RxSwift

protocol MainRouting: ViewableRouting {
    func routeToSearch()
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
}

protocol MainListener: AnyObject {
    
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {

    weak var router: MainRouting?
    weak var listener: MainListener?
    
    override init(presenter: MainPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToSearch()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
