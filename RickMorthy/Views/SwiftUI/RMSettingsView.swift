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
            HStack {
                if let image = model.image { Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.secondarySystemBackground)
                        .aspectRatio(contentMode: .fit)
                        .padding(6)
                        .frame(width: 36)
                        .background(Color(model.iconContainerColor))
                        .cornerRadius(8)
                    Text(model.title)
                        .padding(.leading, 16)
                    Spacer()
                }
            }
            .padding()
            .onTapGesture {
                model.onTapHandler(model.type)
            }
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
                        RMSettingsCellViewModel(type: $0) {
                            option in
                            print(option.dispayTitle)
                        }
                    })
            )
    )
}
