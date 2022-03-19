//
//  APIType.swift
//  appStoreFilterApp
//
//  Created by 박지찬 on 2022/03/19.
//

import Foundation

protocol APIType {
    var baseURL: URL { get }
    var path: String { get }
    var params: [String: Any] { get }
}

