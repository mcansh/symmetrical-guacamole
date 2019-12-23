//
//  MusicKit.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/21/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import Foundation
import StoreKit
import SwiftUI

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

//==========================================================================
// MARK: - AlbumAPIResponse
struct AlbumAPIResponse: Codable {
    let data: [AlbumAPIResponseDatum]
}

// MARK: - AlbumAPIResponseDatum
struct AlbumAPIResponseDatum: Codable {
    let id, type, href: String
    let attributes: PurpleAttributes
    let relationships: Relationships
}

// MARK: - PurpleAttributes
struct PurpleAttributes: Codable {
    let dateAdded: String
    let playParams: PurplePlayParams
    let artwork: Artwork
    let trackCount: Int
    let artistName: String
    let name: String
}

// MARK: - PurplePlayParams
struct PurplePlayParams: Codable {
    let id, kind: String
    let isLibrary: Bool
}

// MARK: - Relationships
struct Relationships: Codable {
    let tracks: Tracks
}

// MARK: - Tracks
struct Tracks: Codable {
    let data: [TracksDatum]
    let href: String
    let next: String?
    let meta: Meta
}

// MARK: - TracksDatum
struct TracksDatum: Codable {
    let id: String
    let type: String
    let href: String
    let attributes: FluffyAttributes
}

// MARK: - FluffyAttributes
struct FluffyAttributes: Codable {
    let durationInMillis, trackNumber: Int
    let playParams: FluffyPlayParams
    let artwork: Artwork
    let genreNames: [String]
    let artistName: String
    let name: String
    let albumName: String
}

// MARK: - FluffyPlayParams
struct FluffyPlayParams: Codable {
    let id: String
    let kind: String
    let isLibrary, reporting: Bool
    let catalogID: String?

    enum CodingKeys: String, CodingKey {
        case id, kind, isLibrary, reporting
        case catalogID
    }
}

// MARK: - Meta
struct Meta: Codable {
    let total: Int
}

class MusicKit {
    @State private var developerToken: String
    @State private var userToken: String
    
    func recentlyAdded(completion: @escaping (APIResponse) -> ()) {
        let request = AppleMusicRequestFactory.createRecentlyAddedRequest(developerToken: self.developerToken, userToken: self.userToken)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            let json = try! JSONDecoder().decode(APIResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(json)
            }
        }.resume()
    }
    
    func getAlbumById(albumId: String, completion: @escaping (AlbumAPIResponse) -> ()) {
        let request = AppleMusicRequestFactory.createAlbumRequest(albumId: albumId, developerToken: self.developerToken, userToken: self.userToken)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            let json = try! JSONDecoder().decode(AlbumAPIResponse.self, from: data!)
            DispatchQueue.main.async {
                completion(json)
            }
        }.resume()
    }
}
