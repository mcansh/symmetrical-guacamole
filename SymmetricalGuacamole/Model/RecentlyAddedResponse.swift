import Foundation

// MARK: - RecentlyAddedResponse
struct RecentlyAddedResponse: Codable {
    let next: String
    let data: [Datum]
        
    init(next: String, data: [Datum]) {
        self.data = data
        self.next = next
    }
}

// MARK: - Datum
struct Datum: Codable, Identifiable {
    let id: String
    let type: TypeEnum
    let href: String
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let playParams: PlayParams
    let name: String
    let dateAdded: String
    let trackCount: Int
    let artwork: Artwork?
    let artistName: String
}

// MARK: - Artwork
struct Artwork: Codable {
    let width, height: Int?
    let url: String
}

// MARK: - PlayParams
struct PlayParams: Codable {
    let id: String
    let kind: Kind
    let isLibrary: Bool
}

enum Kind: String, Codable {
    case album = "album"
}

enum TypeEnum: String, Codable {
    case libraryAlbums = "library-albums"
}
