//
//  LoadingView.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("Loading...")
                .foregroundStyle(.secondary)
        }
    }
}
