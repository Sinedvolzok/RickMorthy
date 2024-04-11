//
//  RMSettingsCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 02.04.2024.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable {
    public let id = UUID()
    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    // MARK: Init
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
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
