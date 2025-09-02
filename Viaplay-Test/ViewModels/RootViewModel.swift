//
//  ContentViewModel.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

@Observable
final class RootViewModel: PageViewModelProtocol {
    private(set) var sections: [ViaplaySection] = []
    
    private(set) var title: String = ""
    private(set) var description: String = ""
        
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private(set) var isStale = false
    
    private var api: APIClient
    private let cache: FileCache
    
    var hasError: Bool {
        errorMessage != nil && sections.isEmpty
    }
    
    init() {
        self.api = ViaplayAPIClient()
        self.cache = FileCache()
        
        applyUITestOverrides()
        
        Task {
            isLoading = true
            await load()
        }
    }
    
    func refresh() async {
        await fetch()
    }
    
    func load() async {
        isLoading = true
        await fetch()
        isLoading = false
    }

    private func fetch() async {
        errorMessage = nil

        do {
            let fetched = try await api.fetchPage()
            title = fetched.title
            description = fetched.description
            sections = fetched.links.viaplaySections
            if let data = try? JSONEncoder().encode(fetched) {
                try? cache.save(data: data, for: api.baseURL)
            }
            isStale = false
        } catch {
            if cache.exists(for: api.baseURL) {
                do {
                    let data = try cache.load(for: api.baseURL)
                    let page = try JSONDecoder().decode(ViaplayPage.self, from: data)
                    title = page.title
                    description = page.description
                    sections = page.links.viaplaySections
                    isStale = true
                } catch {
                    errorMessage = "Offline load failed: \(error.localizedDescription)"
                }
            } else {
                errorMessage = error.localizedDescription
            }
        }
    }
}

extension RootViewModel {
    private func applyUITestOverrides() {
        let args = ProcessInfo.processInfo.arguments
        
        if args.contains(UITestLaunchArguments.rootLoader.rawValue) {
            clearCacheForUITests()
            api = MockViaplayAPIClient.timeoutMock()
        }

        if args.contains(UITestLaunchArguments.rootNoContent.rawValue) {
            clearCacheForUITests()
            api = MockViaplayAPIClient.networkErrorMock()
        }
        
        if args.contains(UITestLaunchArguments.rootSuccess.rawValue) {
            clearCacheForUITests()
            api = MockViaplayAPIClient.successMock(with: ViaplayPage.rootMock)
        }
    }
    
    private func clearCacheForUITests() {
        do {
            try cache.clear()
        } catch {
            print("Failed to clear:", error)
        }
    }
}
