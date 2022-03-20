//
//  RootRouter.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import RIBs

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable> {
    private let mainBuilder: MainBuildable
    private var mainRouting: MainRouting?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuilder: MainBuildable
    ) {
        self.mainBuilder = mainBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

extension RootRouter: RootRouting {
    func routeToMain() {
        let routing = mainBuilder.build(withListener: interactor)
        self.mainRouting = routing
        attachChild(routing)
        viewController.present(viewController: routing.viewControllable)
    }
}
