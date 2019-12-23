//
//  ContentView.swift
//  SymmetricalGuacamole
//
//  Created by Logan McAnsh on 12/18/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI
import MediaPlayer
import StoreKit
import URLImage


struct AlbumArt: View {
    private var url: String
    private var size: Int
    
    private func imageURL() -> URL {
        // 1) Replace the "{w}" placeholder with the desired width as an integer value.
        var imageURLString = self.url.replacingOccurrences(of: "{w}", with: "\(self.size)")
        
        // 2) Replace the "{h}" placeholder with the desired height as an integer value.
        imageURLString = imageURLString.replacingOccurrences(of: "{h}", with: "\(self.size)")
        
        // 3) Replace the "{f}" placeholder with the desired image format.
        imageURLString = imageURLString.replacingOccurrences(of: "{f}", with: "png")
        
        return URL(string: imageURLString)!
    }
    
    init(url: String?, size: Int) {
        self.url = url ?? "https://miniature-gaucamole-ak1h8di2q.now.sh/static/default-album-artwork.jpeg"
        self.size = size
    }
    
    var body: some View {
        URLImage(
            imageURL(),
            placeholder: { _ in
                Image(uiImage: #imageLiteral(resourceName: "DefaultAlbumArt"))
                    .resizable()
                    .cornerRadius(4)
                    .aspectRatio(contentMode: .fit)
        },
            content: {
                $0.image
                    .resizable()
                    .cornerRadius(4)
                    .aspectRatio(1, contentMode: .fill)
        })
    }
}

struct AlbumPageView: View {
    let musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
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
//            if model.hasLoaded {
//                ForEach(data.data[0].relationships.tracks.data, id: \.id) { track in
//                    Text(track.attributes.name)
//                }
//            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            LibraryView()
                .accentColor(.pink)
                .tabItem {
                    Image(systemName: "music.note").font(.title).foregroundColor(.pink)
                    Text("Library")
            }.tag(0)
            ForYouView()
                .tabItem {
                    Image(systemName: "heart.fill").font(.title).foregroundColor(.pink)
                    Text("For You")
            }
            ForYouView()
                .tabItem {
                    Image(systemName: "music.note").font(.title).foregroundColor(.pink)
                    Text("Browse")
            }
            ForYouView()
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right").font(.title).foregroundColor(.pink)
                    Text("Radio")
                    
            }
            ForYouView()
                .tabItem {
                    Image(systemName: "magnifyingglass").font(.title).foregroundColor(.pink)
                    Text("Search")
                    
            }
        }.accentColor(.pink)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
