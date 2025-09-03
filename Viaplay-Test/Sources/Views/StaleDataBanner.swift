//
//  StaleDataBanner.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//


import SwiftUI

struct StaleDataBanner: View {
    var message: String = "Showing last saved data\nPull down to refresh"
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding(8)
        .background(Color.gray.opacity(0.8))
        .cornerRadius(8)
    }
}
