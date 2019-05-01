//
//  MovieCellViewModel.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import UIKit

class MovieCellViewModel {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    
    weak var networkManager: TMDbAPINetworkProtocol?
    
    init(with movie: Movie) {
        id = movie.id
        title = movie.title
        overview = movie.overview
        posterPath = movie.posterPath
    }
    
    func getPosterImage(completion: @escaping (UIImage?)->()) {
        guard let posterPath = posterPath else {
            return
        }
        networkManager?.getPosterImage(posterPath: posterPath, completion: {(image, error) in
            if let error = error {
                print(">>getPosterImage error: \(error)")
            }
            completion(image)
        })
    }
}
