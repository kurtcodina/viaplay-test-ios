//
//  PageUnavailableView.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

struct PageUnavailableView: View {
    let viewModel: PageViewModelProtocol
    
    var body: some View {
        ContentUnavailableView {
            Label("Content Unavailable", systemImage: viewModel.isStale ? "exclamationmark.triangle" : "wifi.slash")
        } description: {
            Text(viewModel.errorMessage ?? "Unable to load content. Check your internet connection and try again.")
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.load()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
