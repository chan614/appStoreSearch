//
//  DetailInteractor.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import Foundation
import RIBs
import RxSwift
import RxRelay

protocol DetailRouting: ViewableRouting {
    
}

protocol DetailPresentable: Presentable {
    var listener: DetailPresentableListener? { get set }
    
}

protocol DetailListener: AnyObject {
    
}

final class DetailInteractor: PresentableInteractor<DetailPresentable> {

    weak var router: DetailRouting?
    weak var listener: DetailListener?
    
    let service: SearchService
    let bundleID: String
    
    let infoListRelay = PublishRelay<[AppInfoType]>()
    let screenShotsRelay = PublishRelay<[URL]>()
    
    init(presenter: DetailPresentable, service: SearchService, bundleID: String) {
        self.service = service
        self.bundleID = bundleID
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        loadDetail()
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func loadDetail() {
        service.loadDetail(bundleID: bundleID)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe(
                with: self,
                onSuccess: { owner, result in
                    guard let infoDTO = result.results.first else {
                        return
                    }
                    let appInfoList = owner.buildAppInfoTypes(dto: infoDTO)
                    
                    owner.infoListRelay.accept(appInfoList)
                },
                onFailure: { owenr, error in
                    
                }
            ).disposeOnDeactivate(interactor: self)
    }
    
    func buildAppInfoTypes(dto: AppInfoDTO) -> [AppInfoType] {
        let rating = AppInfoType.rating(count: dto.userRatingCount, rating: dto.averageUserRating)
        let advisory = AppInfoType.advisory(rating: dto.contentAdvisoryRating.rawValue)
        let ranking = AppInfoType.ranking(rank: 1, category: dto.primaryGenreName)
        let developer = AppInfoType.developer(name: dto.sellerName)
        let language = AppInfoType.language(code: dto.languageCodesISO2A.first ?? "", desc: "")
        
        return [rating, advisory, ranking, developer, language]
    }
}

extension DetailInteractor: DetailInteractable {
    
}

extension DetailInteractor: DetailPresentableListener {
    var infoListObservable: Observable<[AppInfoType]> {
        infoListRelay.asObservable()
    }
    
    var screenShotsObservable: Observable<[URL]> {
        screenShotsRelay.asObservable()
    }
}
