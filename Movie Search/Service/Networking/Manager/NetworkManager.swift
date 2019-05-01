//
//  NetworkManager.swift
//  NetworkLayer
//
//

import Foundation


protocol TMDbAPINetworkProtocol {
    init(environment: NetworkEnvironment, apiKey: String)
    /**
     Search movies data, that contain query's string,  based on TMDbAPI
     - Parameter query: search keyword for movie list
     - Parameter completion: block to handle the Search results
     */
    func searchMovie(query: String, completion: @escaping (_ movieResponse: MovieResponse?,_ error: String?)->())
    
}

class TMDbAPINetworkManager: TMDbAPINetworkProtocol {
    static var environment : NetworkEnvironment = .production
    let router = Router<TMDbAPI>()
    private var apiKey = ""
    
    required init(environment: NetworkEnvironment, apiKey: String) {
        TMDbAPINetworkManager.environment = environment
        self.apiKey = apiKey
    }
    
    /**
     Search movies data, that contain query's string,  based on TMDbAPI
     - Parameter query: search keyword for movie list
     - Parameter completion: block to handle the Search results
     */
    func searchMovie(query: String, completion: @escaping (_ movieResponse: MovieResponse?,_ error: String?)->()) {
        router.request(.searchMovie(query: query, apiKey: apiKey) ) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                /*let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(jsonData)*/
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(movieResponse, nil)
            }catch {
                print(error)
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        }
    }
}
