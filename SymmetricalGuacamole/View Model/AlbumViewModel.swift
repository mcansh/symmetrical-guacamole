//
//  AlbumViewModel.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/21/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AlbumViewModel: ObservableObject {
    @Published var data = [AlbumAPIResponseDatum]()
    @Published var hasLoaded: Bool = false
    let didChange = PassthroughSubject<AlbumViewModel, Never>()
    
    init(albumId: String) {
        MusicKit().getAlbumById(albumId: albumId) {
            self.data = $0.data
            self.hasLoaded = true
        }
    }
}
