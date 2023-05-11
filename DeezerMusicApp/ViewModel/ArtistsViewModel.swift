//
//  ArtistsViewModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit
import Foundation
import SDWebImage

class ArtistsViewModel {
    
    private let apiClient: ArtistsAPIClient
    
    var artists: [selectedCategory] = []
    
    init(apiClient: ArtistsAPIClient) {
        self.apiClient = apiClient
    }
    
  
    
    func fetchArtists(completion: @escaping (Result<Void, APIError>) -> Void) {
        apiClient.getArtists { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let artists):
                self.artists = artists
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configure(cell: CategoriesCollectionViewCell, for indexPath: IndexPath) {
        let artist = artists[indexPath.row]
        cell.label.text = artist.name
        
        // Set the image view to use a placeholder image for now
        cell.imageView.image = UIImage(named: "placeholder")
        
        DispatchQueue.global(qos: .background).async {
            if let image = UIImage(data: try! Data(contentsOf: artist.pictureXl)) {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
    }
    
    func numberOfItems() -> Int{
        return artists.count
    }
    
    func getArtistID(index: Int) -> Int{
        return artists[index].id
    }
    
    func getArtistName(index: Int) -> String{
        return artists[index].name
    }
    
}
