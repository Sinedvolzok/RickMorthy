//
//  RMSettingsCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 02.04.2024.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    public let id = UUID()
    private let type: RMSettingsOption
    // MARK: Init
    init(type: RMSettingsOption) {
        self.type = type
    }
    // MARK: Public
    public var image: UIImage? {
        type.iconImage
    }
    public var title: String {
        type.dispayTitle
    }
    public var iconContainerColor: UIColor {
        type.iconContainercolor
    }
}
