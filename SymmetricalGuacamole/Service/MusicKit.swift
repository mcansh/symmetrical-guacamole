//
//  MusicKit.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/21/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import Foundation

struct PlayParams: Codable {
    let id: String
    let Kind: String?
    let isLibrary: Bool
}

struct Artwork: Codable {
    let width, height: Int?
    let url: String?
}

struct Attributes: Codable {
    let name, artistName, dateAdded: String
    let trackCount: Int
    let playParams: PlayParams
    let artwork: Artwork?
}

struct MediaItem: Codable {
    let id, type, href: String
    let attributes: Attributes
}

struct APIResponse: Codable {
    let next: String
    let data: [MediaItem]
}

struct AlbumAPIResponse: Codable {
    let data: [APIResponseDatum]
}

struct APIResponseDatum: Codable {
    let id, type, href: String
    let attributes: Attributes
    let relationships: Relationships
}

struct Relationships: Codable {
    let tracks: Tracks
}

struct Tracks: Codable {
    let data: [TracksDatum]
    let href, next: String
     let meta: Meta
}

struct Meta: Codable {
    let total: Int
}

struct TracksDatum: Codable {
    let id, type, href: String
    let attributes: FluffyAttributes
}

struct FluffyAttributes: Codable {
    let playParams: PlayParams
    let genreNames, name, albumName, artistName: String
    let durationInMillis, trackNumber: Int
    let artwork: Artwork
}

class MusicKit {
    func recentlyAdded(completion: @escaping (APIResponse) -> ()) {
        let request = AppleMusicRequestFactory.createRecentlyAddedRequest(developerToken: "", userToken: "")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            let json = try! JSONDecoder().decode(APIResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(json)
            }
        }.resume()
    }
}
