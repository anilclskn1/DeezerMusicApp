//
//  TracksAPIClient.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import Foundation


class TracksAPIClient {
    
    let baseURL: URL
    let albumID: Int
    
    init(baseURL: URL, albumID: Int) {
        self.baseURL = baseURL
        self.albumID = albumID
    }
    
    func getTracks(completion: @escaping (Result<[Track], APIError>) -> Void) {
        let endpoint = "/album/\(albumID)/tracks"
        let url = buildURL(endpoint: endpoint)
        
        var request = URLRequest(url: url)
        //request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error2: \(error)")
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("error3: \(error)")
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
                print(String(data: data, encoding: .utf8))
                let tracksResponse = try decoder.decode(TrackResponse.self, from: data)
                completion(.success(tracksResponse.data))
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
