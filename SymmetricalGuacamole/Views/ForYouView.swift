//
//  ForYouView.swift
//  Guacamole
//
//  Created by Logan McAnsh on 12/22/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import SwiftUI

struct ForYouView: View {
    var date = Date()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(date, formatter: Self.dateFormat)")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.footnote)
                Text("For You")
                    .bold()
                    .font(.title)
                    .fontWeight(.black)
            }
        }
    }
}

struct ForYouView_Previews: PreviewProvider {
    static var previews: some View {
        ForYouView()
    }
}
