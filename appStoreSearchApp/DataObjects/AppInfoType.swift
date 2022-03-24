//
//  AppInfoType.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/23.
//

import Foundation

enum AppInfoType {
    case rating(count: Int, rating: Double)
    case advisory(rating: String)
    case ranking(rank: Int, category: String)
    case developer(name: String)
    case language(code: String, count: Int)
}
