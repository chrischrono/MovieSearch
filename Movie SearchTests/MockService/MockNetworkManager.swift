//
//  MockNetworkManager.swift
//  Movie SearchTests
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation
import UIKit
@testable import Movie_Search


class MockNetworkManager: TMDbAPINetworkProtocol {
    
    var mockMovieResponse: MovieResponse?
    var mockError: String?
    var mockImage: UIImage?
    
    required init(environment: NetworkEnvironment, apiKey: String) {
    }
    
    func searchMovie(query: String, completion: @escaping (MovieResponse?, String?) -> ()) {
        completion(mockMovieResponse, mockError)
    }
    
    func getPosterImage(posterPath: String, completion: @escaping (UIImage?, String?) -> ()) {
        completion(mockImage, mockError)
    }
}
