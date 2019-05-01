//
//  MovieSearchViewModelTests.swift
//  Movie SearchTests
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import XCTest
@testable import Movie_Search

class MovieSearchViewModelTests: XCTestCase {
    
    var movieSearchViewModel = MovieSearchViewModel()
    var mockNetworkManager = MockNetworkManager(environment: .qa, apiKey: "testApiKey")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        movieSearchViewModel.networkManager = mockNetworkManager
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchMovieError() {
        mockNetworkManager.mockMovieResponse = nil
        mockNetworkManager.mockError = "This is an error"
        
        movieSearchViewModel.refreshSearchMovie()
        XCTAssertEqual(movieSearchViewModel.status, mockNetworkManager.mockError)
    }
    
    func testSearchMovie() {
        let data = loadDataFromBundle(withName: "searchMovie", extension: "json")
        let movieResponse = try! JSONDecoder().decode(MovieResponse.self, from: data)
        mockNetworkManager.mockMovieResponse = movieResponse
        mockNetworkManager.mockError = nil
        
        movieSearchViewModel.query = "harry potter"
        
        XCTAssertEqual(movieSearchViewModel.status, nil)
        XCTAssertEqual(movieSearchViewModel.getMoviesCount(), 20)
        
    }

}
