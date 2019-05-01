//
//  MovieViewCell.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {
    
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var overviewLabel: UILabel!
    
    var movieCellViewModel: MovieCellViewModel?
    
    static let imagePlaceHolder = UIImage(named: "MoviePlaceholder")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(model: MovieCellViewModel) {
        self.movieCellViewModel = model
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        
        model.getPosterImage { [weak self] (image) in
            guard let image = image, let movieCellViewModel = self?.movieCellViewModel, movieCellViewModel.posterPath == model.posterPath else {
                return
            }
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        self.movieCellViewModel = nil
        posterImageView.image = MovieViewCell.imagePlaceHolder
        titleLabel.text = nil
        overviewLabel.text = nil
    }
    
}
