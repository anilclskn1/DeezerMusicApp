//
//  CategoriesViewModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import UIKit
import Foundation
import SDWebImage

class CategoriesViewModel {
    
    private let apiClient: CategoriesAPIClient
    
    var genres: [DeezerGenre] = []
    
    init(apiClient: CategoriesAPIClient) {
        self.apiClient = apiClient
    }
    
  
    
    func fetchCategories(completion: @escaping (Result<Void, APIError>) -> Void) {
        apiClient.getMusicGenres { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let genres):
                self.genres = genres
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configure(cell: CategoriesCollectionViewCell, for indexPath: IndexPath) {
        let genre = genres[indexPath.row]
        cell.label.text = genre.name
        
        // Set the image view to use a placeholder image for now
        cell.imageView.image = UIImage(named: "placeholder")
        
        cell.imageView.sd_setImage(with: genre.pictureXl)
        
    }


    
    func numberOfItems() -> Int{
        return genres.count
    }
    
    func getGenreID(index: Int) -> Int{
        return genres[index].id
    }
    
    func getCategoryName(index: Int) -> String{
        return genres[index].name
    }
    
}
