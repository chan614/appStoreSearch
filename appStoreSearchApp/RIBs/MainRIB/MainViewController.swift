//
//  MainViewController.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs
import RxSwift
import UIKit

protocol MainPresentableListener: AnyObject {
    
}

class MainViewController: UITabBarController, MainPresentable, MainViewControllable {
    var listener: MainPresentableListener?
    
    func addViewController(viewController: ViewControllable) {
        
        let tabBarItem = UITabBarItem()
        tabBarItem.title = "Search"
        tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        let targetController = UINavigationController(rootViewController: viewController.uiviewController)
        targetController.tabBarItem = tabBarItem
        
        if viewControllers == nil {
            viewControllers = [targetController]
        } else {
            viewControllers?.append(targetController)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
