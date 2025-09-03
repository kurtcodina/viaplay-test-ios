//
//  ViaplayPage.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

struct ViaplayPage: Codable {
    let title: String
    let description: String
    
    let links: ViaplayLinks

    enum CodingKeys: String, CodingKey {
        case links = "_links"
        case title = "title"
        case description = "description"
    }
}
