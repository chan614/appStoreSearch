//
//  TextUtil.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/24.
//

import Foundation

class TextUtil {
    static func unitFormatted(_ num: Int) -> String {
        switch num {
        case 1000..<10000:
            return String(format: "%.1f천", Double(num) / 1000)
        case 10000..<100000:
            return String(format: "%.1f만", Double(num) / 10000)
        case 100000..<1000000:
            return String(format: "%d만", num / 10000)
        default:
            return num.description
        }
    }
}
