//
//  ModelsTests.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//


import XCTest
@testable import Viaplay_Test

final class ModelsTests: XCTestCase {
    func testTemplateStripping() throws {
        let raw = "https://foo/bar{?q}"
        let cleaned = raw.removingURITemplates()
        XCTAssertEqual(cleaned, "https://foo/bar")
    }
    
    func testDecodeViaplaySectionsKey() throws {
        let json = """
        {
            "type": "page",
            "pageType": "root",
            "title": "Viaplay - Streama TV, Serier, Film och Sport online",
            "description": "Hyr filmer på nätet och se live sport som fotboll och Premier League. Viaplay har alla TV serier och kanaler online.",
            "_links":
            {
                "viaplay:sections": [
                    {"id": "1", "title": "Series", "description": "Shows", "href": "https://content.viaplay.com/serier"}
                ]
            }
        }
        """.data(using: .utf8)!
        
        let root = try JSONDecoder().decode(ViaplayPage.self, from: json)
        XCTAssertEqual(root.links.viaplaySections.count, 1)
        XCTAssertEqual(root.links.viaplaySections.first?.title, "Series")
    }
    
    func testOptionalFieldsDecodeAsNil() throws {
        let json = """
        {
            "type": "page",
            "pageType": "root",
            "title": "Viaplay - Streama TV, Serier, Film och Sport online",
            "description": "Hyr filmer på nätet och se live sport som fotboll och Premier League. Viaplay har alla TV serier och kanaler online.",
            "_links":            {
              "viaplay:sections": [
                {"id": "1", "href": "https://content.viaplay.com/serier"}
              ]
            }
        }
        """.data(using: .utf8)!
        
        let root = try JSONDecoder().decode(ViaplayPage.self, from: json)
        XCTAssertNil(root.links.viaplaySections.first?.title)
        XCTAssertNotNil(root.links.viaplaySections.first?.href)
    }
}
