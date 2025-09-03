//
//  APIClient.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import Foundation

final class ViaplayAPIClient: APIClient {
    let baseURL: URL

    init(baseURL: URL = URL(string: "https://content.viaplay.com/ios-se")!) {
        self.baseURL = baseURL
    }

    func fetchPage()  async throws -> ViaplayPage {
        var request = URLRequest(url: baseURL)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse {
            guard (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }
        } else {
            throw URLError(.badServerResponse)
        }

        let root = try JSONDecoder().decode(ViaplayPage.self, from: data)
        return root
    }
}
