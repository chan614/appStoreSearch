//
//  SearchListCell.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import UIKit
import Cosmos

class SearchListCell: UITableViewCell {
    static let reuseID = "SearchListCell"
    
    @IBOutlet weak var appImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var ratingCountLabel: UILabel!
    
    @IBOutlet weak var firstThumbnailView: UIImageView!
    @IBOutlet weak var secondThumbnailView: UIImageView!
    @IBOutlet weak var thirdThumbnailView: UIImageView!
    
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: AppInfoDTO) {
        let url = URL(string: data.artworkUrl100)!
        appImageView.setImage(url: url)
        titleLabel.text = data.trackName
        subTitleLabel.text = data.primaryGenreName
        ratingCountLabel.text = TextUtil.unitFormatted(data.userRatingCount)
        starRatingView.rating = data.averageUserRating
        
        if data.screenshotUrls.count >= 3 {
            let fThumbnailURL = URL(string: data.screenshotUrls[0])!
            let sThumbnailURL = URL(string: data.screenshotUrls[1])!
            let tThumbnailURL = URL(string: data.screenshotUrls[2])!
            
            firstThumbnailView.setImage(url: fThumbnailURL)
            secondThumbnailView.setImage(url: sThumbnailURL)
            thirdThumbnailView.setImage(url: tThumbnailURL)
        }
    }
}

extension UIImageView {
    func setImage(url: URL) {
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

