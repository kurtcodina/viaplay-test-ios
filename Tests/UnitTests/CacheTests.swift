//
//  CacheTests.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//


import XCTest
@testable import Viaplay_Test

final class CacheTests: XCTestCase {
    let url = URL(string: "http://example.com/")!
    let url2 = URL(string: "http://example.net/")!
    
    func test_cache_saveAndLoad_returnsCorrectData() throws {
        let cache = FileCache()
        let data = "{\"hello\":\"world\"}".data(using: .utf8)!
        try cache.save(data: data, for: url)
        
        let loaded = try cache.load(for: url)
        XCTAssertEqual(data, loaded)
    }
    
    func test_cache_exists_returnsTrueWhenDataSaved() throws {
        let cache = FileCache()
        let data = "{}".data(using: .utf8)!
        try cache.save(data: data, for: url)
        XCTAssertTrue(cache.exists(for: url))
    }
    
    func test_cache_exists_returnsFalseWhenDataNotSaved() throws {
        let cache = FileCache()
        let data = "{}".data(using: .utf8)!
        try cache.save(data: data, for: url)
        XCTAssertFalse(cache.exists(for: url2))
    }
    
    func test_cache_invalidData_throwsError() {
        let cache = FileCache()
        let badData = "%%%".data(using: .utf8)!
        try? cache.save(data: badData, for: url)
        XCTAssertThrowsError(try JSONDecoder().decode([ViaplaySection].self, from: cache.load(for: url)))
    }
}
