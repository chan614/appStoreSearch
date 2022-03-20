//
//  SearchListCell.swift
//  appStoreSearchApp
//
//  Created by 박지찬 on 2022/03/20.
//

import UIKit

class SearchListCell: UITableViewCell {
    
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var subTitleView: UILabel!
    @IBOutlet weak var scoreView: UILabel!
    
    @IBOutlet weak var openButton: UIButton!
    @IBOutlet weak var firstThumbnailView: UIImageView!
    @IBOutlet weak var secondThumbnailView: UIImageView!
    @IBOutlet weak var thirdThumbnailView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
