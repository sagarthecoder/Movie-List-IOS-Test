//
//  MovieListTableViewCell.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        overviewLabel.lineBreakMode = .byWordWrapping;
        overviewLabel.numberOfLines = 0;
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = ""
        overviewLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
