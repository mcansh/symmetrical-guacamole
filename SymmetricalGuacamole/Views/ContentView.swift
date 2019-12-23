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
    var url: String?
    var size: Int
    
    private func imageURL() -> URL {
        // 1) Replace the "{w}" placeholder with the desired width as an integer value.
        var imageURLString = self.url!.replacingOccurrences(of: "{w}", with: "\(self.size)")
        
        // 2) Replace the "{h}" placeholder with the desired height as an integer value.
        imageURLString = imageURLString.replacingOccurrences(of: "{h}", with: "\(self.size)")
        
        // 3) Replace the "{f}" placeholder with the desired image format.
        imageURLString = imageURLString.replacingOccurrences(of: "{f}", with: "png")
        
        return URL(string: imageURLString)!
    }
    
    var body: some View {
        VStack {
            if url == nil {
                Image("DefaultAlbumArt")
                    .resizable()
                    .cornerRadius(4)
                    .aspectRatio(contentMode: .fit)
            } else {
                URLImage(
                    imageURL(),
                    placeholder: { _ in
                        Image("DefaultAlbumArt")
                            .resizable()
                            .cornerRadius(4)
                            .aspectRatio(contentMode: .fit)
                },
                    content: { proxy in
                        proxy.image
                            .resizable()
                            .cornerRadius(4)
                            .aspectRatio(1, contentMode: .fill)
                })
            }
        }
    }
}

struct ContentView: View {
    private var musicPlayerManager = MPMusicPlayerApplicationController.systemMusicPlayer
    private let NC = NotificationCenter.default
    
    @State private var nowPlayingArtwork: Image? = nil
    @State private var nowPlayingTitle: String = ""
    
    func updateCurrentItemMetadata() {
        if let current = musicPlayerManager.nowPlayingItem {
            print(current.artwork)
            nowPlayingArtwork = current.artwork?.image != nil ? Image(uiImage: (current.artwork?.image(at: CGSize(width: 100, height: 100)))!) : Image("DefaultAlbumArt")
            nowPlayingTitle = current.title ?? "Not Playing"
        } else {
            print("nothing is playing")
            nowPlayingTitle = "Not Playing"
        }
    }
    
    
    
    func handleMusicPlayerManagerDidUpdateState(notification: Notification) {
        DispatchQueue.main.async {
            self.updateCurrentItemMetadata()
        }
    }
    
    var body: some View {
        VStack {
            TabView {
                LibraryView()
                    .accentColor(.pink)
                    .tabItem {
                        Image(systemName: "music.note").font(.title).foregroundColor(.pink)
                        Text("Library")
                }.overlay(
                    HStack {
                        (nowPlayingArtwork)?.resizable().frame(width: 50, height: 50).cornerRadius(4)
                        Text(nowPlayingTitle)
                        Spacer()
                        Image(systemName: "play.fill")
                        Image(systemName: "forward.fill")
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                    , alignment: .bottom
                )
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
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass").font(.title).foregroundColor(.pink)
                        Text("Search")
                        
                }
            }
            .accentColor(.pink)
        }.onAppear {
            self.musicPlayerManager.beginGeneratingPlaybackNotifications()
            self.NC.addObserver(
                forName: .MPMusicPlayerControllerNowPlayingItemDidChange,
                object: nil,
                queue: nil,
                using: self.handleMusicPlayerManagerDidUpdateState
            )
            
            self.updateCurrentItemMetadata()
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
