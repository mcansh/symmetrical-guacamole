//
//  ContentView.swift
//  SymmetricalGuacamole
//
//  Created by Logan McAnsh on 12/18/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import MediaPlayer
import StoreKit
import WaterfallGrid

struct AlbumView: View {
    let item: Datum
    var body: some View {
        VStack {
            WebImage(url: URL(string: (item as Datum).attributes.artwork?.url ?? "https://is1-ssl.mzstatic.com/image/thumb/Features127/v4/75/f9/6f/75f96fa5-99ca-0854-3aae-8f76f5cb7fb5/source/200x200bb.jpeg")).resizable().frame(width: 200, height: 200).cornerRadius(CGFloat(10), antialiased: true)
            .aspectRatio(CGSize(width: 30, height: 30), contentMode: .fit)
            Text((item as Datum).attributes.name)
                    .font(.largeTitle)
                    .foregroundColor(Color.purple)
        }
    }
}

struct ContentView: View {
    @ObservedObject var recent = NetworkManager()
    
    var body: some View {
        TabView {
            WaterfallGrid(recent.data?.data ?? []) { item in
                VStack {
                    WebImage(url: URL(string: (item as Datum).attributes.artwork?.url ?? "https://is1-ssl.mzstatic.com/image/thumb/Features127/v4/75/f9/6f/75f96fa5-99ca-0854-3aae-8f76f5cb7fb5/source/200x200bb.jpeg"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text((item as Datum).attributes.name).lineLimit(1)
                        .foregroundColor(Color.purple)
                }
                }.padding(20)
            .tabItem {
                Image(systemName: "music.house.fill")
                Text("Library")
            }
            Text("Settings View")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }
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
