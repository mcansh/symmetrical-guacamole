//
//  AK.swift
//  SymmetricalGuacamole
//
//  Created by Logan McAnsh on 12/21/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import Foundation

struct AppleMusicRequestFactory {
    
    // MARK: Types
    
    /// The base URL for all Apple Music API network calls.
    static let appleMusicAPIBaseURLString = "api.music.apple.com"
    
    /// The Apple Music API endpoint for requesting a list of recently played items.
    static let recentlyPlayedPathURLString = "/v1/me/recent/played"
    
    /// The Apple Music API endpoint for requesting a list of recently added items.
    static let recentlyAddedPathURLString = "/v1/me/library/recently-added"
    
    /// The Apple Music API endpoint for requesting the storefront of the currently logged in iTunes Store account.
    static let userStorefrontPathURLString = "/v1/me/storefront"
    
    /// The Apple Music API endpoint for requesting an album.
    static let albumPathURLString = "/v1/me/library/albums"
    
    static func createSearchRequest(with term: String, countryCode: String, developerToken: String) -> URLRequest {
        
        // Create the URL components for the network call.
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AppleMusicRequestFactory.appleMusicAPIBaseURLString
        urlComponents.path = "/v1/catalog/\(countryCode)/search"
        
        let expectedTerms = term.replacingOccurrences(of: " ", with: "+")
        let urlParameters = ["term": expectedTerms,
                             "limit": "10",
                             "types": "songs,albums"]
        
        var queryItems = [URLQueryItem]()
        for (key, value) in urlParameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems
        
        // Create and configure the `URLRequest`.
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    static func createStorefrontsRequest(regionCode: String, developerToken: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AppleMusicRequestFactory.appleMusicAPIBaseURLString
        urlComponents.path = "/v1/storefronts/\(regionCode)"
        
        // Create and configure the `URLRequest`.
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
    static func createRecentlyPlayedRequest(developerToken: String, userToken: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AppleMusicRequestFactory.appleMusicAPIBaseURLString
        urlComponents.path = AppleMusicRequestFactory.recentlyPlayedPathURLString
        let queryItems = [URLQueryItem(name: "limit", value: "24")]
        urlComponents.queryItems = queryItems
        
        // Create and configure the `URLRequest`.
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        return urlRequest
    }
    
    
    static func createAlbumRequest(albumId: String, developerToken: String, userToken: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AppleMusicRequestFactory.appleMusicAPIBaseURLString
        urlComponents.path = AppleMusicRequestFactory.albumPathURLString
        let queryItems = [URLQueryItem(name: "include", value: "tracks")]
        urlComponents.queryItems = queryItems
        
        // Create and configure the `URLRequest`.
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        return urlRequest
    }
    
    static func createRecentlyAddedRequest(developerToken: String, userToken: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AppleMusicRequestFactory.appleMusicAPIBaseURLString
        urlComponents.path = AppleMusicRequestFactory.recentlyAddedPathURLString
        
        // Create and configure the `URLRequest`.
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        return urlRequest
    }
    
    static func createGetUserStorefrontRequest(developerToken: String, userToken: String) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = AppleMusicRequestFactory.appleMusicAPIBaseURLString
        urlComponents.path = AppleMusicRequestFactory.userStorefrontPathURLString
        
        // Create and configure the `URLRequest`.
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = "GET"
        
        urlRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        return urlRequest
    }
}
