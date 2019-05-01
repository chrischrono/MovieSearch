//
//  MovieCellViewModel.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class MovieCellViewModel {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    
    
    init(with movie: Movie) {
        id = movie.id
        title = movie.title
        overview = movie.overview
        posterPath = movie.posterPath
    }
}
