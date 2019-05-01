//
//  NetworkManager.swift
//  NetworkLayer
//
//

import Foundation
import UIKit


protocol TMDbAPINetworkProtocol: class {
    init(environment: NetworkEnvironment, apiKey: String)
    /**
     Search movies data, that contain query's string,  based on TMDbAPI
     - Parameter query: search keyword for movie list
     - Parameter completion: block to handle the Search results
     */
    func searchMovie(query: String, completion: @escaping (_ movieResponse: MovieResponse?,_ error: String?)->())
    
    /**
     Get poster image, using posterPath based on TMDbAPI
     - Parameter posterPath: posterPath for the requested image
     - Parameter completion: block to handle the Search results
     */
    func getPosterImage(posterPath: String, completion: @escaping (_ image: UIImage?,_ error: String?)->())
    
}

class TMDbAPINetworkManager: TMDbAPINetworkProtocol {
    static var environment : NetworkEnvironment = .production
    let router = Router<TMDbAPI>()
    private var apiKey = ""
    private var posterImageCache = NSCache<NSString, UIImage>()
    
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
    
    
    /**
     Get poster image, using posterPath based on TMDbAPI
     - Parameter posterPath: posterPath for the requested image
     - Parameter completion: block to handle the Search results
     */
    func getPosterImage(posterPath: String, completion: @escaping (_ image: UIImage?,_ error: String?)->()) {
        
        if let image = posterImageCache.object(forKey: posterPath as NSString) {
            completion(image, nil)
        } else {
            router.request(.getPosterImage(posterPath: posterPath)) {[weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    completion(nil, error)
                    return
                }
                guard let image = UIImage(data: data) else {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                    return
                }
                
                self?.posterImageCache.setObject(image, forKey: posterPath as NSString)
                completion(image, nil)
            }
        }
    }
}
