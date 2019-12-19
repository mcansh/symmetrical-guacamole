//
//  ContentView.swift
//  SymmetricalGuacamole
//
//  Created by Logan McAnsh on 12/18/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI
import Combine
import StoreKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            Text("Hello")
        }.navigationBarTitle(Text("Recently Added"))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
