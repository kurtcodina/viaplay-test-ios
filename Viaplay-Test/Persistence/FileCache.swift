//
//  FileCache.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import Foundation
import CryptoKit

final class FileCache {
    private let directoryURL: URL

    init() {
        let fm = FileManager.default
        directoryURL = try! fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("FileCache", isDirectory: true)
        try? fm.createDirectory(at: directoryURL,
                                withIntermediateDirectories: true)
    }

    private func fileURL(for endpoint: URL) -> URL {
        let hash = SHA256.hash(data: Data(endpoint.absoluteString.utf8))
            .compactMap { String(format: "%02x", $0) }
            .joined()
        return directoryURL.appendingPathComponent("\(hash).json")
    }

    func save(data: Data, for endpoint: URL) throws {
        let url = fileURL(for: endpoint)
        try data.write(to: url, options: .atomic)
    }

    func load(for endpoint: URL) throws -> Data {
        let url = fileURL(for: endpoint)
        return try Data(contentsOf: url)
    }

    func exists(for endpoint: URL) -> Bool {
        let url = fileURL(for: endpoint)
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    func clear() throws {
        let fm = FileManager.default
        let contents = try fm.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [])
        for file in contents {
            try fm.removeItem(at: file)
        }
    }
}
