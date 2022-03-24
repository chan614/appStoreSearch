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
        case let .rating(count, rating):
            return ("\(TextUtil.unitFormatted(count))개의 평가", rating.description, "")
        case let .advisory(rating):
            return ("연령", rating, "세")
        case let .ranking(rank, category):
            return ("차트", "#\(rank)", category)
        case let .developer(name):
            return ("개발자", "", name)
        case let .language(code, count):
            let bottomLabel = count < 1 ? String() : "+ \(count)개의 언어"
            return ("언어", code, bottomLabel)
        }
    }
}
