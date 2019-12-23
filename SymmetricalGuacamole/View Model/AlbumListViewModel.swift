//
//  AlbumListViewModel.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/21/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AlbumListViewModel: ObservableObject {
    @Published var data = [MediaItem]()
    @Published var next = String()
    @Published var chunked = [[MediaItem]]()
    @Published var hasLoaded: Bool = false
    let didChange = PassthroughSubject<AlbumListViewModel, Never>()
    
    init() {
        fetchMusic()
    }
    
    private func fetchMusic() {
        MusicKit().recentlyAdded {
            self.data = $0.data
            self.next = $0.next
            self.chunked = $0.data.chunked(into: 2)
            self.hasLoaded = true
        }
    }
}


extension Array {
    func chunked(into size:Int) -> [[Element]] {
        
        var chunkedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                chunkedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                chunkedArray.append(Array(self[index - 1..<index]))
            }
        }
        
        return chunkedArray
    }
}
