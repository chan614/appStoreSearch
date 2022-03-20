//
//  RootBuilder.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController(nibName: "RootViewController", bundle: nil)
        let interactor = RootInteractor(presenter: viewController)
        let mainBuilder = MainBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            mainBuilder: mainBuilder)
    }
}
