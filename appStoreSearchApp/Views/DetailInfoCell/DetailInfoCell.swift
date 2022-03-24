//
//  DetailInfoCell.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/23.
//

import UIKit
import Cosmos

class DetailInfoCell: UICollectionViewCell {
    static let reuseID = "DetailInfoCell"
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = .init(systemName: "person.crop.square")?.withTintColor(.darkGray)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLabel.preferredMaxLayoutWidth = topLabel.frame.size.width
        bottomLabel.preferredMaxLayoutWidth = bottomLabel.frame.size.width
    }
    
    func configure(item: AppInfoType) {
        let labels = labels(item: item)
        topLabel.text = labels.0
        centerLabel.text = labels.1
        bottomLabel.text = labels.2
        
        switch item {
        case .rating(_, let rating):
            ratingView.rating = rating
            centerLabel.isHidden = false
            bottomLabel.isHidden = true
            ratingView.isHidden = false
            imageView.isHidden = true
        case .developer:
            centerLabel.isHidden = true
            bottomLabel.isHidden = false
            ratingView.isHidden = true
            imageView.isHidden = false
        default:
            centerLabel.isHidden = false
            bottomLabel.isHidden = false
            ratingView.isHidden = true
            imageView.isHidden = true
        }
    }
    
    func labels(item: AppInfoType) -> (String, String, String) {
        switch item {
        case .rating(let count, let rating):
            return ("\(TextUtil.unitFormatted(count))개의 평가", rating.description, "")
        case .advisory(let rating):
            return ("연령", rating, "세")
        case .ranking(let rank, let category):
            return ("차트", "#\(rank)", category)
        case .developer(let name):
            return ("개발자", "", name)
        case .language(let code, let desc):
            return ("언어", code, desc)
        }
    }
}
