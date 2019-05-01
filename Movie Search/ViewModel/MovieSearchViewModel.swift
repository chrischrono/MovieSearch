//
//  MovieSearchViewModel.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import Foundation


class MovieSearchViewModel {
    var query = "harry potter" {
        didSet {
            refreshSearchMovie()
        }
    }
    private var movies = [Movie]()
    private(set) var movieCellViewModels = [MovieCellViewModel]() {
        didSet{
            reloadTableViewClosure?()
        }
    }
    
    private(set) var status: String? {
        didSet {
            showStatusViewClosure?(status)
        }
    }
    private(set) var isLoading = false {
        didSet {
            showLoadingViewClosure?(isLoading)
        }
    }
    
    var networkManager: TMDbAPINetworkProtocol = TMDbAPINetworkManager(environment: .production, apiKey: Constants.TMDbAPIKey)
    
    var reloadTableViewClosure: (()->())?
    var showStatusViewClosure: ((String?)->())?
    var showLoadingViewClosure: ((Bool)->())?
}

//MARK:- searchMovie related
extension MovieSearchViewModel {
    func refreshSearchMovie() {
        searchMovie(query: query)
    }
    
    func searchMovie(query: String) {
        guard isLoading == false else {
            return
        }
        isLoading = true
        status = "network_loading"
        
        networkManager.searchMovie(query: query) { (movieResponse, error) in
            self.isLoading = false
            self.status = error
            guard error == nil else {
                return
            }
            guard let movieResponse = movieResponse else {
                return
            }
            
            self.processMovieResponse(movieResponse)
        }
    }
    
    private func processMovieResponse(_ movieResponse: MovieResponse) {
        let movieCellViewModels = movieResponse.results.map { (movie) -> MovieCellViewModel in
            return MovieCellViewModel(with: movie)
        }
        self.movieCellViewModels = movieCellViewModels
    }
}

//MARK:- listView related
extension MovieSearchViewModel {
    func getMoviesCount() -> Int {
        return movieCellViewModels.count
    }
    
    func getMovieCellViewModel(at index: Int) -> MovieCellViewModel {
        return movieCellViewModels[index]
    }
}
