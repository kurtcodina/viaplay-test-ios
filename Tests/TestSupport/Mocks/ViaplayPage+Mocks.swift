//
//  ViaplayPage+Mocks.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import Foundation

extension ViaplayPage {
    static let rootMock: ViaplayPage = {
        let json = """
        {
        "type": "page",
          "pageType": "root",
          "title": "Viaplay - Streama TV, Serier, Film och Sport online",
          "description": "Hyr filmer på nätet och se live sport som fotboll och Premier League. Viaplay har alla TV serier och kanaler online.",
            "_links": {
                 "viaplay:sections": [
                    {
                      "id": "35bb8a90-d40e-11e2-8b8b-0800200c9a66",
                      "title": "Serier",
                      "href": "https://content.viaplay.com/ios-se/serier{?productsPerPage}",
                      "type": "vod",
                      "sectionSort": 1,
                      "name": "series",
                      "templated": true
                    },
                    {
                      "id": "2037b330-d411-11e2-8b8b-0800200c9a66",
                      "title": "Filmer",
                      "href": "https://content.viaplay.com/ios-se/film{?productsPerPage}",
                      "type": "vod",
                      "sectionSort": 2,
                      "name": "movie",
                      "templated": true
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        do {
            return try JSONDecoder().decode(ViaplayPage.self, from: json)
        } catch {
            assertionFailure("❌ Failed to decode ViaplayPage.rootMock: \(error)")
            return ViaplayPage(
                title: "Decode Failed",
                description: error.localizedDescription,
                links: ViaplayLinks(viaplaySections: [])
            )
        }
    }()
    
    
    static let sectionMock: ViaplayPage = {
        let json = """
        {
        "type": "page",
        "pageType": "section",
        "sectionId": "35bb8a90-d40e-11e2-8b8b-0800200c9a66",
        "title": "TV-serier online - Streama serier på nätet eller ladda ned",
        "description": "Viaplay erbjuder TV-serier på nätet för hela familjen. Streama serier online i hög kvalitet eller ladda ned till tablet eller mobil!",
        "styles": [],
        "tracking": {
        "viewDataType": "section"
        },
            "_links": {
                 "viaplay:sections": [
                    {
                      "id": "35bb8a90-d40e-11e2-8b8b-0800200c9a66",
                      "title": "Serier",
                      "href": "https://content.viaplay.com/ios-se/serier{?productsPerPage}",
                      "type": "vod",
                      "sectionSort": 1,
                      "name": "series",
                      "templated": true
                    },
                    {
                      "id": "2037b330-d411-11e2-8b8b-0800200c9a66",
                      "title": "Filmer",
                      "href": "https://content.viaplay.com/ios-se/film{?productsPerPage}",
                      "type": "vod",
                      "sectionSort": 2,
                      "name": "movie",
                      "templated": true
                    }
                ]
            }
        }
        """.data(using: .utf8)!
        
        do {
            return try JSONDecoder().decode(ViaplayPage.self, from: json)
        } catch {
            assertionFailure("❌ Failed to decode ViaplayPage.rootMock: \(error)")
            return ViaplayPage(
                title: "Decode Failed",
                description: error.localizedDescription,
                links: ViaplayLinks(viaplaySections: [])
            )
        }
    }()
}
