//
//  AlbumAPIClient.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation


class AlbumAPIClient {
    
    let baseURL: URL
    let artistID: Int
    
    init(baseURL: URL, artistID: Int) {
        self.baseURL = baseURL
        self.artistID = artistID
    }
    
    func getAlbums(completion: @escaping (Result<[albums], APIError>) -> Void) {
        let endpoint = "/artist/\(artistID)/albums"
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
                let albumsResponse = try decoder.decode(albumsResponse.self, from: data)
                completion(.success(albumsResponse.data))
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
