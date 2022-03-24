//
//  DetailRouter.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs

protocol DetailInteractable: Interactable {
    var router: DetailRouting? { get set }
    var listener: DetailListener? { get set }
}

protocol DetailViewControllable: ViewControllable {
    
}

final class DetailRouter: ViewableRouter<DetailInteractable, DetailViewControllable>, DetailRouting {
    
    override init(interactor: DetailInteractable, viewController: DetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
