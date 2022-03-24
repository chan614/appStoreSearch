//
//  DetailBuilder.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs

protocol DetailDependency: Dependency {
    
}

final class DetailComponent: Component<DetailDependency> {

}

// MARK: - Builder

protocol DetailBuildable: Buildable {
    func build(withListener listener: DetailListener, appInfoDTO: AppInfoDTO) -> DetailRouting
}

final class DetailBuilder: Builder<DetailDependency>, DetailBuildable {

    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailListener, appInfoDTO: AppInfoDTO) -> DetailRouting {
        let _ = DetailComponent(dependency: dependency)
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let interactor = DetailInteractor(presenter: viewController, appInfoDTO: appInfoDTO)
        interactor.listener = listener
        return DetailRouter(interactor: interactor, viewController: viewController)
    }
}
