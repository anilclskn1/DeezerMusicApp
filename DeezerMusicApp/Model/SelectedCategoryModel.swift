//
//  SelectedCategoryModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 11.05.2023.
//

import Foundation

struct selectedCategoryResponse: Codable{
    let id: Int
    let name: String
    let link: URL
    let share: URL
    let picture: URL
    let pictureSmall: URL
    let pictureMedium: URL
    let pictureBig: URL
    let pictureXl: URL
    let nbAlbum: Int
    let nbFan: Int
    let radio: Bool
    let tracklist: URL
}
