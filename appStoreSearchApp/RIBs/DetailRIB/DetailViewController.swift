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
    var infoListObservable: Observable<[AppInfoType]> { get }
    var screenShotsObservable: Observable<[URL]> { get }
}

final class DetailViewController: UIViewController, DetailPresentable, DetailViewControllable {

    weak var listener: DetailPresentableListener?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subTitleView: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        bind()
    }
    
    func setUp() {
        let infoCellNib = UINib(nibName: "DetailInfoCell", bundle: nil)
        infoCollectionView.register(infoCellNib, forCellWithReuseIdentifier: DetailInfoCell.reuseID)
        
        let screenShotCellNib = UINib(nibName: "DetailScreenShotCell", bundle: nil)
        infoCollectionView.register(screenShotCellNib, forCellWithReuseIdentifier: DetailScreenShotCell.reuseID)
        
        infoCollectionView.collectionViewLayout = {
           let layout = UICollectionViewFlowLayout()
            layout.itemSize = .init(width: 80, height: 80)
            layout.scrollDirection = .horizontal
            return layout
        }()
    }
    
    func bind() {
        listener?.infoListObservable
            .observe(on: MainScheduler.instance)
            .bind(to: infoCollectionView.rx.items(
                cellIdentifier: DetailInfoCell.reuseID,
                cellType: DetailInfoCell.self)
            ) { index, element, cell in
                cell.configure(item: element)
            }
            .disposed(by: disposeBag)
        
        listener?.screenShotsObservable
            .observe(on: MainScheduler.instance)
            .bind(to: screenShotCollectionView.rx.items(
                cellIdentifier: DetailScreenShotCell.reuseID,
                cellType: DetailScreenShotCell.self)
            ) { index, element, cell in
                cell.configure(url: element)
            }
            .disposed(by: disposeBag)
            
    }
}
