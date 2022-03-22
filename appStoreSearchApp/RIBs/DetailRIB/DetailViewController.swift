//
//  DetailViewController.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import RIBs
import RxSwift
import UIKit

protocol DetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DetailViewController: UIViewController, DetailPresentable, DetailViewControllable {

    weak var listener: DetailPresentableListener?
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subTitleView: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    func setUp() {
        
    }
}
