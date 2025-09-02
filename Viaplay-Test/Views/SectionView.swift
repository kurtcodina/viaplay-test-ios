//
//  SectionView.swift
//  Viaplay-Test
//
//  Created by codina on 9/2/25.
//

import SwiftUI

struct SectionView: View {
    @State var viewModel: SectionViewModel
    
    init(section: ViaplaySection) {
        _viewModel = State(wrappedValue: SectionViewModel(section: section))
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.hasError {
                PageUnavailableView(viewModel: viewModel)
            } else {
                ScrollView {
                    VStack {
                        TitleAndDescriptionView(viewModel: viewModel)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
                .refreshable {
                    await viewModel.refresh()
                }
            }
        }
        .navigationTitle(viewModel.section.displayTitle)
    }
}

#Preview {
    SectionView(section: ViaplaySection.previewExample)
}
