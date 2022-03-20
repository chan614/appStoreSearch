//
//  MainBuilder.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import RIBs
import Foundation

protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {

    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener) -> MainRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController(nibName: "MainViewController", bundle: nil)
        let interactor = MainInteractor(presenter: viewController)
        interactor.listener = listener
        
        let searchBuidler = SearchBuilder(dependency: component)
        
        return MainRouter(
            interactor: interactor,
            viewController: viewController,
            searchBuidler: searchBuidler)
    }
}
