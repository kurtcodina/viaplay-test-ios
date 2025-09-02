//
//  ViaplayLinks.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

struct ViaplayLinks: Codable {
    let viaplaySections: [ViaplaySection]

    enum CodingKeys: String, CodingKey {
        case viaplaySections = "viaplay:sections"
    }
}
