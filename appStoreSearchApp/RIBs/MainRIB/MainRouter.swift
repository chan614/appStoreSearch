//
//  MainRouter.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import RIBs

protocol MainInteractable: Interactable, SearchListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: ViewControllable {
    func addViewController(viewController: ViewControllable)
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    let searchBuilder: SearchBuildable
    var searchRouting: SearchRouting?
    
    init(
        interactor: MainInteractable,
        viewController: MainViewControllable,
        searchBuidler: SearchBuildable
    ) {
        self.searchBuilder = searchBuidler
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToSearch() {
        let routing = searchBuilder.build(withListener: interactor)
        self.searchRouting = routing
        attachChild(routing)
        viewController.addViewController(viewController: routing.viewControllable)
    }
    
    func detachSearch() {
        
    }
}
