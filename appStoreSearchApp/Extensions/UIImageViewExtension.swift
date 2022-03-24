//
//  UIImageViewExtension.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/24.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(url: URL) {
        ImageCache.shared.caching(url: url) { [weak self] uiImage in
            DispatchQueue.main.async {
                self?.image = uiImage
            }
        }
    }
}
