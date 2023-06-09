//
//  SelectedCategoryModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation

struct selectedCategoryResponse: Codable {

    let data: [selectedCategory]
}

struct selectedCategory: Codable{
    let id: Int
    let name: String
    let picture: URL
    let pictureSmall: URL
    let pictureMedium: URL
    let pictureBig: URL
    let pictureXl: URL
    let radio: Bool
    let tracklist: URL
    let type: String
}


