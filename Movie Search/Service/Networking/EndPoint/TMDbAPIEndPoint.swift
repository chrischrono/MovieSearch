//
//  TMDbAPIEndPoint.swift
//  NetworkLayer
//
// source: https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import Foundation


public enum TMDbAPI {
    case searchMovie(query: String, apiKey: String)
    case getPosterImage(posterPath: String)
}

extension TMDbAPI: EndPointType {
    
    /** API base urls. */
    var environmentBaseURL : String {
        switch TMDbAPINetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/"
        default:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    /** API path for specific request. */
    var path: String {
        switch self {
        case .searchMovie:
            return "search/movie"
        case .getPosterImage(let posterPath):
            return "https://image.tmdb.org/t/p/w600_and_h900_bestv2/\(posterPath)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    /** generate task based on requested TMDbAPI. */
    var task: HTTPTask {
        switch self { //https://api.themoviedb.org/3/search/movie?api_key=2a61185ef6a27f400fd92820ad9e8537&query=Harry%20Potter
        case .searchMovie(let query, let apiKey):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding ,
                                      urlParameters: ["query": query,
                                                      "api_key": apiKey])
        case .getPosterImage:
            return .externalRequest
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}



