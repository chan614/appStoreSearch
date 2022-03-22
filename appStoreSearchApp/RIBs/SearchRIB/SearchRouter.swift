//
//  SearchRouter.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs

protocol SearchInteractable: Interactable, DetailListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
}

protocol SearchViewControllable: ViewControllable {
    func push(viewController: ViewControllable)
    func pop()
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {
    let detailBuilder: DetailBuildable
    var detailRouting: DetailRouting?
    
    init(
        interactor: SearchInteractable, 
        viewController: SearchViewControllable,
        detailBuilder: DetailBuildable
    ) {
        self.detailBuilder = detailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToDetail(bundleID: String) {
        let routing = detailBuilder.build(withListener: interactor, bundleID: bundleID)
        self.detailRouting = routing
        attachChild(routing)
        viewController.push(viewController: routing.viewControllable)
    }
    
    func detachDetail() {
        guard let routing = detailRouting else {
            return
        }
        
        viewController.pop()
        detachChild(routing)
        detailRouting = nil
    }
}
