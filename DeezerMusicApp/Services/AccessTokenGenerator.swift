//
//  AccessTokenGenerator.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation

func getAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
    let endpoint = "https://connect.deezer.com/oauth/access_token.php"
    let url = URL(string: endpoint)!
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    let body = "grant_type=client_credentials&client_id=604244&client_secret=63b9ad4e09ef7362bb817b6e97c8c3cd"
    request.httpBody = body.data(using: .utf8)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        guard let data = data else {
            completion(.failure(APIError.invalidResponse))
            return
        }
        
        let responseString = String(data: data, encoding: .utf8)!
        let token = parseAccessToken(responseString: responseString)
        completion(.success(token))
    }
    
    task.resume()
}

private func parseAccessToken(responseString: String) -> String {
    let pattern = "access_token=(.*?)&"
    let regex = try! NSRegularExpression(pattern: pattern)
    let matches = regex.matches(in: responseString, range: NSRange(location: 0, length: responseString.count))
    let range = matches[0].range(at: 1)
    return (responseString as NSString).substring(with: range)
}


