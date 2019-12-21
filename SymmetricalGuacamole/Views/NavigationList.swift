//
//  NavigationList.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/21/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI

struct NavigationList: View {
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Divider()
                Text("Playlists")
                Divider()
            }
            Group {
                Text("Artists")
                Divider()
            }
            Group {
                Text("Albums")
                Divider()
            }
            Group {
                Text("Songs")
                Divider()
            }
            Group {
                Text("Downloaded Music")
                Divider()
            }
        }.foregroundColor(.pink).padding(.horizontal, 20).font(.system(size: 20))
    }
}

struct NavigationList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationList()
    }
}
