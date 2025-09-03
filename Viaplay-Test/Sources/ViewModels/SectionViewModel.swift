//
//  SectionViewModel.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

@Observable
final class SectionViewModel: PageViewModelProtocol {
    let section: ViaplaySection
    
    private(set) var title: String = ""
    private(set) var description: String = ""
    
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private(set) var isStale = false

    private var api: APIClient
    private let cache: FileCache
    
    var hasError: Bool {
        errorMessage != nil
    }
    
    init(section: ViaplaySection) {
        self.section = section

        self.api = ViaplayAPIClient(baseURL: URL(string: section.href.removingURITemplates())!)
        self.cache = FileCache()
        
        applyUITestOverrides()
        
        Task {
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

extension SectionViewModel {
    private func applyUITestOverrides() {
        let args = ProcessInfo.processInfo.arguments
        
        if args.contains(UITestLaunchArguments.sectionLoader.rawValue) {
            clearCacheForUITests()
            api = MockViaplayAPIClient.timeoutMock()
        }

        if args.contains(UITestLaunchArguments.sectionNoContent.rawValue) {
            clearCacheForUITests()
            api = MockViaplayAPIClient.networkErrorMock()
        }
        
        if args.contains(UITestLaunchArguments.sectionSuccess.rawValue) {
            clearCacheForUITests()
            api = MockViaplayAPIClient.successMock(with: ViaplayPage.sectionMock)
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
