//
//  AlbumPageView.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/22/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI

struct AlbumPageView: View {
    var item: MediaItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                AlbumArt(url: item.attributes.artwork?.url, size: 360).frame(width: 120, height: 120).onTapGesture {
                    print(self.item)
                }
                VStack(alignment: .leading) {
                    Text(item.attributes.name)
                    Text(item.attributes.artistName)
                }
            }
        }
    }
}
