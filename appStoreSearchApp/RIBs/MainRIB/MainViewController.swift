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
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

class MainViewController: UITabBarController, MainPresentable, MainViewControllable {
    var listener: MainPresentableListener?
    
    func addViewController(viewController: ViewControllable) {
        
        let tabBarItem = UITabBarItem()
        tabBarItem.title = "Search"
//        tabBarItem.image = UIImage(systemName: "")
//        tabBarItem.selectedImage =  UIImage(systemName: "")
//        viewController.uiviewController.tabBarItxem = tabBarItem
        
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

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
