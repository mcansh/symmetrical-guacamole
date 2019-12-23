//
//  SearchView.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/22/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var search: String = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Your Library", text: $search, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        }).foregroundColor(Color.pink)
                        
                        Button(action: {
                            self.search = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(search == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.search = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color.pink)
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton).animation(.default)
                .navigationBarTitle(Text("Search"))
                Spacer()
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
