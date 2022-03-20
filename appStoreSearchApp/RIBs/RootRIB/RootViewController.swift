//
//  RootViewController.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {

    weak var listener: RootPresentableListener?
    
    func present(viewController: ViewControllable) {
        let vc = viewController.uiviewController
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
    }
}
