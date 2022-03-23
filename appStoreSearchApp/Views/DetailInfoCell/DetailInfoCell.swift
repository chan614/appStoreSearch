//
//  DetailInfoCell.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/23.
//

import UIKit

class DetailInfoCell: UICollectionViewCell {
    static let reuseID = "DetailInfoCell"
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(item: AppInfoType) {
        let labels = labels(item: item)
        
        self.topLabel.text = labels.0
        self.centerLabel.text = labels.1
        self.bottomLabel.text = labels.2
    }
    
    func labels(item: AppInfoType) -> (String, String, String) {
        switch item {
        case .rating(let count, let rating):
            return ("\(count)개의 평가", rating.description, rating.description)
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
