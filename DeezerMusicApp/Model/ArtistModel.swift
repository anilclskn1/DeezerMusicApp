//
//  ArtistModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation

struct albumsResponse: Codable {

    let data: [albums]
}

struct albums: Codable{
    let id: Int
    let title: String
    let link: URL
    let cover: URL
    let coverSmall: URL
    let coverMedium: URL
    let coverBig: URL
    let coverXl: URL
    let md5Image: String
    let genreId: Int
    let fans: Int
    let releaseDate: String
    let recordType: String
    let tracklist: URL
    let explicitLyrics: Bool
    let type: String
}
