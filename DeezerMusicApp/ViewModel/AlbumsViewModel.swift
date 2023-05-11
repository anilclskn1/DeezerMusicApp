//
//  AlbumsModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit
import Foundation
import SDWebImage

class AlbumsViewModel {
    
    private let apiClient: AlbumAPIClient
    
    var albums: [albums] = []
    
    init(apiClient: AlbumAPIClient) {
        self.apiClient = apiClient
    }
    
  
    
    func fetchAlbums(completion: @escaping (Result<Void, APIError>) -> Void) {
        apiClient.getAlbums { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let albums):
                self.albums = albums
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configure(cell: TableViewCell, for indexPath: IndexPath) {
        let album = albums[indexPath.row]
        cell.albumNameLabel.text = album.title
        cell.releaseTimeLabel.text = album.releaseDate
        
        // Set the image view to use a placeholder image for now
        cell.albumImageView.image = UIImage(named: "placeholder")
        
        cell.albumImageView.sd_setImage(with: album.coverXl)
        cell.bgImageView.sd_setImage(with: album.coverXl)
        
     
    }
    
    func numberOfItems() -> Int{
        return albums.count
    }
    
    func getArtistID(index: Int) -> Int{
        return albums[index].id
    }
    
    func getArtistName(index: Int) -> String{
        return albums[index].title
    }
    
    func getImageURL(index: Int) -> URL{
        return albums[index].coverXl
    }
    
}
