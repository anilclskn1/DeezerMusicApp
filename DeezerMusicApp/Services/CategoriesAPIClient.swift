//
//  CategoriesAPIClient.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(Error)
    case decodingFailed(Error)
}

class CategoriesAPIClient {
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getMusicGenres(completion: @escaping (Result<[DeezerGenre], APIError>) -> Void) {
        let endpoint = "/genre"
        let url = buildURL(endpoint: endpoint)
        
        var request = URLRequest(url: url)
        //request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let genresResponse = try decoder.decode(DeezerGenreResponse.self, from: data)
                completion(.success(genresResponse.data))
            } catch {
                print("error4: \(error)")
                completion(.failure(.decodingFailed(error)))
            }
        }
        
        task.resume()
    }
    
    private func buildURL(endpoint: String) -> URL {
        let url = baseURL.appendingPathComponent(endpoint)
        return url
    }
}
