//
//  SearchBuilder.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs

protocol SearchDependency: Dependency {
}

final class SearchComponent: Component<SearchDependency> {
}

// MARK: - Builder

protocol SearchBuildable: Buildable {
    func build(withListener listener: SearchListener) -> SearchRouting
}

final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {

    override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListener) -> SearchRouting {
        let component = SearchComponent(dependency: dependency)
        let viewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let interactor = SearchInteractor(presenter: viewController, service: SearchService())
        interactor.listener = listener
        
        let detailBuilder = DetailBuilder(dependency: component)
        
        return SearchRouter(
            interactor: interactor,
            viewController: viewController,
            detailBuilder: detailBuilder)
    }
}
