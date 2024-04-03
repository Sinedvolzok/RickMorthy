//
//  RMSettingsCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 02.04.2024.
//

import UIKit

struct RMSettingsCellViewModel {
    public let type: RMSettingsOption
    public var image: UIImage? {
        type.iconImage
    }
    public var title: String {
        type.dispayTitle
    }
}
