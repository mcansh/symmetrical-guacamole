//
//  LibraryView.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/22/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI

struct AlbumLoop: View {
    var data: [[MediaItem]]

    var body: some View {
        ForEach(0..<data.count) { index in
            HStack(spacing: 16) {
                ForEach(self.data[index], id: \.id) { item in
                    NavigationLink(destination: AlbumPageView(item: item)) {
                        AlbumListItem(
                            image: item.attributes.artwork?.url,
                            name: item.attributes.name,
                            artistName: item.attributes.artistName
                        )
                    }.buttonStyle(PlainButtonStyle())
                }
            }.padding(.horizontal, 20)
        }
    }
}

struct AlbumListItem: View {
    var image: String?
    var name: String
    var artistName: String

    var body: some View {
        VStack(alignment: .leading) {
            AlbumArt(url: image, size: 360)
            Text(name).lineLimit(1).font(.footnote)
            Text(artistName).foregroundColor(.gray).font(.footnote)
        }
    }
}

struct PlaylistsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("shrug").navigationBarTitle("Playlists")
                Spacer()
            }

        }
    }
}

struct LibraryView: View {
    var items = [
        "Playlists",
        "Artists",
        "Albums",
        "Songs",
        "Downloaded Music"
    ]

    @ObservedObject var model = AlbumListViewModel()

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                ForEach(0..<items.count) { index in
                    NavigationLink(destination: PlaylistsView()) {
                        VStack(alignment: .leading) {
                            if index == 0 {
                                Divider().padding(.bottom, 4)
                            }
                            Text(self.items[index])
                            Divider().padding(.bottom, 4)
                        }
                    }.accentColor(.pink).padding(.horizontal, 20)
                }
                if model.hasLoaded {
                    VStack(alignment: .leading){
                        Section(header: Text("Recently Added").font(.title).fontWeight(.bold).padding(.horizontal, 20)) {
                            AlbumLoop(data: model.chunked)
                        }
                    }
                }
            }
            .navigationBarTitle("Library")
            .navigationBarItems(
                trailing: Button(action: {
                    print("something")
                }) {
                    Text("Edit").foregroundColor(.pink)
                }
            )
        }.accentColor(.pink)
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11 Pro Max"], id: \.self) { deviceName in
            LibraryView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

