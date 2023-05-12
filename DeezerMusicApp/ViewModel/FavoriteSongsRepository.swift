//
//  FavoriteMusicsRepository.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import Foundation

class FavoriteSongsRepository {
    
    private let userDefaults: UserDefaults
    private let favoriteTVShowsKey = "favoriteSongs"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveFavoriteSong(_ song: Track) {
        var favoriteSongs = getFavoriteSongs()
        favoriteSongs.append(song)
        saveFavoriteSongs(favoriteSongs)
    }
    
    func deleteFavoriteSong(_ song: Track) {
        var favoriteSongs = getFavoriteSongs()
        guard let index = favoriteSongs.firstIndex(where: { $0.title == song.title }) else { return }
        favoriteSongs.remove(at: index)
        saveFavoriteSongs(favoriteSongs)
    }
    
    func getFovoriteImage(indexPath: Int) -> URL{
        return buildImageURL(md5: getFavoriteSongs()[indexPath].md5Image)
    }
    
    func getSong(indexPath: Int) -> Track{
        return getFavoriteSongs()[indexPath]
    }
    
    func formatTimeFromSeconds(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return "\(minutes).\(String(format: "%02d", remainingSeconds))"
    }

    func getSongName(indexPath: Int) -> String{
        return getFavoriteSongs()[indexPath].title
    }
    
    func getSongDuration(IndexPath: Int) -> String{
        return formatTimeFromSeconds(getFavoriteSongs()[IndexPath].duration)
    }
    
    func buildImageURL(md5: String) -> URL{
        return URL(string: "https://e-cdns-images.dzcdn.net/images/cover/\(md5)/500x500.jpg")!
    }
    
    func getFavoriteSongs() -> [Track] {
        guard let data = userDefaults.data(forKey: favoriteTVShowsKey) else { return [] }
        guard let favoriteSongs = try? PropertyListDecoder().decode([Track].self, from: data) else { return [] }
        return favoriteSongs
    }
    
    private func saveFavoriteSongs(_ favoriteSongs: [Track]) {
        guard let data = try? PropertyListEncoder().encode(favoriteSongs) else { return }
        userDefaults.set(data, forKey: favoriteTVShowsKey)
    }
    
}
