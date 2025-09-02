//
//  ViaplaySection.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import Foundation

struct ViaplaySection: Identifiable, Hashable, Codable {
    let id: String
    let title: String?
    let href: String
    
    var displayTitle: String {
        title ?? "Untitled"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case href
    }
}

extension ViaplaySection {
    static let previewExample = ViaplaySection(id: UUID().uuidString, title: "Title", href: "https://content.viaplay.com/ios-se/serier")
}
