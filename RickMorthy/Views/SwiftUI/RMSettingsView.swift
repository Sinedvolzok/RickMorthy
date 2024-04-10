//
//  RMSettingsView.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 10.04.2024.
//

import SwiftUI

struct RMSettingsView: View {
    let viewModel: RMSettingsViewViewModel
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    var body: some View {
        List(viewModel.cellViewModels) { model in
            HStack(spacing: 24) {
                if let image = model.image { Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .padding(2)
                        .background(Color(model.iconContainerColor))
                        .cornerRadius(4)
                    Text(model.title)
                }
            }
            .padding()
        }
    }
}

#Preview {
    RMSettingsView(viewModel: 
            .init(
                cellViewModels: 
                    RMSettingsOption
                    .allCases
                    .compactMap({
                        RMSettingsCellViewModel(type: $0)
                    })
            )
    )
}
