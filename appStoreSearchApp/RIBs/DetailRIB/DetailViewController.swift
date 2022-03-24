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
    var detailDataObservable: Observable<DetailData> { get }
    
    func shutdown()
}

final class DetailViewController: UIViewController {
    
    weak var listener: DetailPresentableListener?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var releaseNoteLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        subscribeUI()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            listener?.shutdown()
        }
    }
    
    func setUp() {
        navigationItem.largeTitleDisplayMode = .never
        
        let infoCellNib = UINib(nibName: "DetailInfoCell", bundle: nil)
        infoCollectionView.register(infoCellNib, forCellWithReuseIdentifier: DetailInfoCell.reuseID)
        
        let screenShotCellNib = UINib(nibName: "DetailScreenShotCell", bundle: nil)
        screenShotCollectionView.register(screenShotCellNib, forCellWithReuseIdentifier: DetailScreenShotCell.reuseID)
        
        infoCollectionView.collectionViewLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 24
            layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
            layout.estimatedItemSize = .init(width: 80, height: 80)
            layout.scrollDirection = .horizontal
            return layout
        }()
        
        screenShotCollectionView.collectionViewLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = .init(width: 140, height: 300)
            layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
            layout.scrollDirection = .horizontal
            return layout
        }()
        
        addMoreButtonGradient()
    }
    
    func bind() {
        listener?.detailDataObservable
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, data in
                owner.setDetail(data)
            })
            .disposed(by: disposeBag)
        
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
    
    func subscribeUI() {
        moreButton.rx.tap
            .subscribe(with: self, onNext: { owner, _ in
                owner.releaseNoteLabel.numberOfLines = 0
                owner.moreButton.isHidden = true
            })
            .disposed(by: disposeBag)
    }
    
    func setDetail(_ data: DetailData) {
        if let url = data.appImageURL {
            appImageView.setImage(url: url)
        }
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        versionLabel.text = "버전 \(data.version)"
        dateLabel.text = data.date
        releaseNoteLabel.text = data.releaseNote
    }
    
    func addMoreButtonGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = .init(x: -20, y: 0, width: 20, height: 20)
        gradientLayer.colors = [UIColor(white: 1, alpha: 0).cgColor, UIColor.white.cgColor]
        gradientLayer.startPoint = .init(x: 0.0, y: 0.5)
        gradientLayer.endPoint = .init(x: 0.7, y: 0.5)
        moreButton.layer.addSublayer(gradientLayer)
    }
}

extension DetailViewController: DetailPresentable {
    
}

extension DetailViewController: DetailViewControllable {
    
}
