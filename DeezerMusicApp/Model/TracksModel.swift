//
//  TracksModel.swift
//  DeezerMusicApp
//
//  Created by Anıl Çalışkan on 12.05.2023.
//

import Foundation

struct TrackResponse: Codable {
    let data: [Track]
}

struct Track: Codable {
    let id: Int
    let readable: Bool
    let title: String
    let titleShort: String
    let titleVersion: String?
    let isrc: String
    let link: URL
    let duration: Int
    let trackPosition: Int
    let diskNumber: Int
    let rank: Int
    let explicitLyrics: Bool
    let explicitContentLyrics: Int
    let explicitContentCover: Int
    let preview: URL
    let md5Image: String
    let artist: Artist
    let type: String

}

struct Artist: Codable {
    let id: Int
    let name: String
    let tracklist: URL
    let type: String
}
