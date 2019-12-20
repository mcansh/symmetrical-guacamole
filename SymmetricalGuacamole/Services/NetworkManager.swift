//
//  APIService.swift
//  SymmetricalGuacamole
//
//  Created by Logan McAnsh on 12/19/19.
//  Copyright © 2019 Logan McAnsh. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class NetworkManager: ObservableObject {
    var didChange = PassthroughSubject<NetworkManager, Never>()
    @Published var data: RecentlyAddedResponse? = nil
    init() {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.music.apple.com"
        components.path = "/v1/me/library/recently-added"
        let offset = URLQueryItem(name: "offset", value: "0")
        let limit = URLQueryItem(name: "limit", value: "25")
        components.queryItems = [offset, limit]

        /*if let offset = offset {
            let queryItemQuery = URLQueryItem(name: "offset", value: "\(offset)")
            components.queryItems?.append(queryItemQuery)
        }

        if let limit = limit {
            let queryItemQuery = URLQueryItem(name: "limit", value: "\(limit)")
            components.queryItems?.append(queryItemQuery)
        }*/

        guard let apiUrl = URL(string: components.string!) else {
            return
        }

        var request = URLRequest(url: apiUrl)
        request.setValue("Bearer eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjIzOFZEUDhIR0sifQ.eyJpYXQiOjE1NzY3MjY0NTEsImV4cCI6MTU5MjI3ODQ1MSwiaXNzIjoiWk40OE5TOEhBUCJ9.D4h4kq2Cxc3ah56PJ8HQq14ATnNzHuRSUGkE2ZsB9C4BTP-wOVQ7JW3dnMfM2-mcyRXV2s7n7_ovX7dghkC7Yg", forHTTPHeaderField: "Authorization")
        request.setValue("AgV1OzjsssHAa7Qy/hd6jHYy8Sqa2W3FzFPMMk/1HFnSW/NkI3wf5mNWIda5CDzf9b4ebWJboMOhUkZrMmHkFylDicBMKYvU6Bn86z0oynx52CIemw9/3GyHpNpd03FNmuVxYRJdJjSq2TI/o7fXdox4zQzFYbrQ+XCTOyEqKXByvKkYGcnZ967fHtaGhQvuFq1W5A87NsmYT2zpetGvFKoG4UfVHfcUdtQPpfCakzZt3+GXmw==", forHTTPHeaderField: "Music-User-Token")


        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
//            if let error = error {
//                print(error)
//                return
//            }

//            guard let data = data else {
//                print("no data")
//                return
//            }

            let root = try! JSONDecoder().decode(RecentlyAddedResponse.self, from: data!)
            DispatchQueue.main.async {
                self.data = root
            }
        }
        task.resume()
    }
}
