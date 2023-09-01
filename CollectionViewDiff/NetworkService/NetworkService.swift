//
//  NetworkService.swift
//  CollectionViewDiff
//
//  Created by Mac on 8/29/23.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func makePexelsRequest(page: String, completion: @escaping (Result<PhotoModel, Error>) -> Void) {
        
        let apiKey = "zW9FssWnr4GvHAC3pI1i4dLp2uhWXNTUkBnADoQVTVoXE5opbj5f7Lp5"
        
        let urlConfigure = "https://api.pexels.com/v1/curated?page=\(page)&per_page=80"
        
        
        guard let url = URL(string: urlConfigure) else {return}
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization" : apiKey]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            if let error = error {
                print("error \(error)")
            }
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let serverData = try decoder.decode(PhotoModel.self, from: data)
                completion(.success(serverData))
                
            } catch let error {
                completion(.failure(error))
                print(error)
            }
        }
        task.resume()
    }
}
