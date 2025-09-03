//
//  TitleAndDescriptionView.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

struct TitleAndDescriptionView: View {
    var viewModel: PageViewModelProtocol
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.title)
                .font(.title)
            Text(viewModel.description)
                .font(.caption)
        }
    }
}
