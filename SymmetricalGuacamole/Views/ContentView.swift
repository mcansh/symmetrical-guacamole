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

struct AlbumListItem: View {
    private var image: String
    private var name: String
    private var artistName: String
    
    init(image: String, name: String, artistName: String) {
        self.image = image
        self.name = name
        self.artistName = artistName
    }
    
    private func imageURL(size: Int) -> URL {
        // 1) Replace the "{w}" placeholder with the desired width as an integer value.
        var imageURLString = image.replacingOccurrences(of: "{w}", with: "\(size)")
        
        // 2) Replace the "{h}" placeholder with the desired height as an integer value.
        imageURLString = imageURLString.replacingOccurrences(of: "{h}", with: "\(size)")
        
        // 3) Replace the "{f}" placeholder with the desired image format.
        imageURLString = imageURLString.replacingOccurrences(of: "{f}", with: "png")
        
        return URL(string: imageURLString)!
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            URLImage(imageURL(size: 360), content: {
                $0.image
                    .resizable()
                    .frame(width: 180, height: 180)
                    .cornerRadius(4)
                    .aspectRatio(contentMode: .fit)
            })
            Text(name)
            Text(artistName).foregroundColor(.gray)
        }.padding(.leading, 5)
    }
}

struct AlbumPageView: View {
    private var item: MediaItem
    
    func playAlbum() {
        let authStatus = SKCloudServiceController.authorizationStatus()
        
        switch authStatus {
        case .authorized:
            print("")
        default:
            SKCloudServiceController.requestAuthorization { status in
                
                print(status)
            }
        }
    }
    
    
    init(item: MediaItem) {
        self.item = item
    }
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        Text("WHY ARE YOU HERE?").onTapGesture {
            self.playAlbum()
        }.onTapGesture {
            self.showAlert = true
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text("Important message"), message: Text("work in progress"), dismissButton: .default(Text("Got it!")))
            
        })
    }
}

struct AlbumLoop: View {
    private var data: [[MediaItem]]
    
    init(data: [[MediaItem]]) {
        self.data = data
    }
    
    var body: some View {
        ForEach(0..<data.count) { index in
            HStack(spacing: 16) {
                ForEach(self.data[index], id: \.id) { item in
                    NavigationLink(destination: AlbumPageView(item: item)) {
                        AlbumListItem(
                            image: item.attributes.artwork?.url ?? "https://miniature-gaucamole-ak1h8di2q.now.sh/static/default-album-artwork.jpeg",
                            name: item.attributes.name,
                            artistName: item.attributes.artistName == "" ? "Unknown Artist" : item.attributes.artistName
                        )
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var model = AlbumListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                NavigationList()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Recently Added").bold().font(.system(size: 20))
                    }
                }
                
                if !model.hasLoaded {
                    HStack {
                        Text("Loading...")
                    }
                } else {
                    AlbumLoop(data: model.chunked)
                }
            }
            .navigationBarTitle("Library")
            .navigationBarItems(
                trailing: Text("Edit").foregroundColor(.pink)
            )
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
