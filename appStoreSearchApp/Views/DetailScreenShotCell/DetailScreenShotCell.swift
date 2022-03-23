//
//  DetailScreenShotCell.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/23.
//

import UIKit

class DetailScreenShotCell: UICollectionViewCell {
    static let reuseID = "DetailScreenShotCell"
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(url: URL) {
        imageView.setImage(url: url)
    }
}
