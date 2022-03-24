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

struct DetailData {
    let title: String
    let subTitle: String
    let appImageURL: URL?
    let version: String
    let date: String
    let releaseNote: String
}

protocol DetailRouting: ViewableRouting {
    
}

protocol DetailPresentable: Presentable {
    var listener: DetailPresentableListener? { get set }
}

protocol DetailListener: AnyObject {
    func detachDetail()
}

final class DetailInteractor: PresentableInteractor<DetailPresentable> {

    weak var router: DetailRouting?
    weak var listener: DetailListener?
    
    let appInfoDTO: AppInfoDTO
    
    let infoListRelay = ReplayRelay<[AppInfoType]>.create(bufferSize: 1)
    let screenShotsRelay = ReplayRelay<[URL]>.create(bufferSize: 1)
    let detailDataRelay = ReplayRelay<DetailData>.create(bufferSize: 1)
    
    // MARK: - PresentableListener property
    
    var detailDataObservable: Observable<DetailData> {
        detailDataRelay.asObservable()
    }
    var infoListObservable: Observable<[AppInfoType]> {
        infoListRelay.asObservable()
    }
    var screenShotsObservable: Observable<[URL]> {
        screenShotsRelay.asObservable()
    }
    
    init(presenter: DetailPresentable, appInfoDTO: AppInfoDTO) {
        
        self.appInfoDTO = appInfoDTO
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        setDetail()
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func setDetail() {
        let detail = buildDetail(dto: appInfoDTO)
        let appInfoList = buildAppInfoTypes(dto: appInfoDTO)
        let screenShots = buildScreenShots(dto: appInfoDTO)
        
        detailDataRelay.accept(detail)
        infoListRelay.accept(appInfoList)
        screenShotsRelay.accept(screenShots)
    }
    
    func buildAppInfoTypes(dto: AppInfoDTO) -> [AppInfoType] {
        let rating = AppInfoType.rating(count: dto.userRatingCount, rating: round(dto.averageUserRating * 100) / 100)
        let advisory = AppInfoType.advisory(rating: dto.contentAdvisoryRating)
        let ranking = AppInfoType.ranking(rank: 1, category: dto.primaryGenreName)
        let developer = AppInfoType.developer(name: dto.sellerName)
        let primaryLang = dto.languageCodesISO2A.filter {
            $0.uppercased() == Locale.current.languageCode?.uppercased()
        }.first ?? dto.languageCodesISO2A.first ?? String()
        let language = AppInfoType.language(code: primaryLang, count: dto.languageCodesISO2A.count - 1)
        
        return [rating, advisory, ranking, developer, language]
    }
    
    func buildDetail(dto: AppInfoDTO) -> DetailData {
        let appImageURL = URL(string: dto.artworkUrl512)
        
        return DetailData(
            title: dto.trackName,
            subTitle: dto.sellerName,
            appImageURL: appImageURL,
            version: dto.version,
            date: dto.currentVersionReleaseDate,
            releaseNote: dto.releaseNotes)
    }
    
    func buildScreenShots(dto: AppInfoDTO) -> [URL] {
        return dto.screenshotUrls.compactMap {
            URL(string: $0)
        }
    }
}

extension DetailInteractor: DetailInteractable {
    
}

extension DetailInteractor: DetailPresentableListener {
    func shutdown() {
        listener?.detachDetail()
    }
}
