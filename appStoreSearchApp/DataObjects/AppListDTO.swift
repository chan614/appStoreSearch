//
//  AppListDTO.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/22.
//

import Foundation

// MARK: - Welcome
struct AppListDTO: Codable {
    let resultCount: Int
    let results: [AppInfoDTO]
}

// MARK: - AppInfoDTO
struct AppInfoDTO: Codable {
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let advisories: [String]
    let trackCensoredName: String
    let languageCodesISO2A: [String]
    let contentAdvisoryRating: String
    let averageUserRating: Double
    let releaseNotes: String
    let currentVersionReleaseDate: String
    let trackName: String
    let releaseDate: String
    let primaryGenreName: String
    let sellerName: String
    let genres: [String]
    let version: String
    let userRatingCount: Int
}
