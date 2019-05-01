//
//  Movie.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}


struct Movie: Decodable {
    let id: Int
    let title: String
    let originalTitle: String?
    let originalLanguange: String?
    let overview: String
    let video: Bool
    let voteCount: Int
    let voteAverage: Float
    let popularity: Float
    let posterPath: String?
    let backdropPath: String?
    let genreIds: [Int]
    let adult: Bool
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguange = "original_languange"
        case overview
        case video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case adult
        case releaseDate
    }
}
