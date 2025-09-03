//
//  RootView.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

struct RootView: View {
    @State private var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    LoadingView()
                } else if viewModel.hasError {
                    PageUnavailableView(viewModel: viewModel)
                } else {
                    List {
                        Section {
                            TitleAndDescriptionView(viewModel: viewModel)
                        }
                        
                        Section("Sections") {
                            ForEach(viewModel.sections) { section in
                                NavigationLink(section.displayTitle) {
                                    SectionView(section: section)
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.refresh()
                    }
                }
            }
            .navigationTitle("Home")
            .overlay(alignment: .bottom) {
                if viewModel.isStale {
                    StaleDataBanner()
                }
            }
        }
    }
}

#Preview {
    RootView()
}
