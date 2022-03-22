//
//  DetailBuilder.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs

protocol DetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class DetailComponent: Component<DetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol DetailBuildable: Buildable {
    func build(withListener listener: DetailListener, bundleID: String) -> DetailRouting
}

final class DetailBuilder: Builder<DetailDependency>, DetailBuildable {

    override init(dependency: DetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailListener, bundleID: String) -> DetailRouting {
        let component = DetailComponent(dependency: dependency)
        let viewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let interactor = DetailInteractor(
            presenter: viewController,
            service: SearchService(),
            bundleID: bundleID)
        interactor.listener = listener
        return DetailRouter(interactor: interactor, viewController: viewController)
    }
}
