//
//  CategoryModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation

struct DeezerGenreResponse: Codable {

    let data: [DeezerGenre]
}

struct DeezerGenre: Codable{
    let id: Int
    let name: String
    let picture: URL
    let pictureSmall: URL
    let pictureMedium: URL
    let pictureBig: URL
    let pictureXl: URL
    let type: String
}


