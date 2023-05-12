//
//  TracksViewModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import UIKit
import Foundation
import SDWebImage

class TracksViewModel {
    
    private let apiClient: TracksAPIClient
    
    var tracks: [Track] = []
    
    private let dataRepository: FavoriteSongsRepository
    private var favoriteSongs: [Track] = []


    
    init(apiClient: TracksAPIClient, dataRepository: FavoriteSongsRepository) {
        self.apiClient = apiClient
        self.dataRepository = dataRepository
    }
    
  
    
    func fetchTracks(completion: @escaping (Result<Void, APIError>) -> Void) {
        apiClient.getTracks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let tracks):
                self.tracks = tracks
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func configure(cell: TracksTableViewCell, for indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        cell.trackNameLabel.text = track.title
        cell.durationTimeLabel.text = formatTimeFromSeconds(track.duration)
        
        // Set the image view to use a placeholder image for now
        cell.trackImageView.image = UIImage(named: "placeholder")
        cell.trackImageView.sd_setImage(with: getImageURL(index: indexPath.row))
        cell.bgImageView.sd_setImage(with: getImageURL(index: indexPath.row))
        
     
    }
    
    func getPreview(at index: Int) -> URL{
        return tracks[index].preview
    }
    
    func getSong(at index: Int) -> Track {
        return tracks[index]
    }
    
    func isSongFavorite(_ song: Track) -> Bool {
        return favoriteSongs.contains { $0.title == song.title }
    }
    
    
    func addToFavorites(_ song: Track) {
        favoriteSongs.append(song)
        dataRepository.saveFavoriteSong(song)
    }
    
    func removeFromFavorites(_ song: Track) {
        guard let index = favoriteSongs.firstIndex(where: { $0.title == song.title }) else { return }
        favoriteSongs.remove(at: index)
        dataRepository.deleteFavoriteSong(song)
    }
    
    
    func formatTimeFromSeconds(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return "\(minutes).\(String(format: "%02d", remainingSeconds))"
    }
    
    func numberOfItems() -> Int{
        return tracks.count
    }
    
    func getTrackID(index: Int) -> Int{
        return tracks[index].id
    }
    
    func getTrackName(index: Int) -> String{
        return tracks[index].title
    }
    
    func getImageURL(index: Int) -> URL{
        return buildImageURL(md5: tracks[index].md5Image)
    }
    
    func buildImageURL(md5: String) -> URL{
        return URL(string: "https://e-cdns-images.dzcdn.net/images/cover/\(md5)/500x500.jpg")!
    }
    
}
