//
//  RMSettingsOption.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 02.04.2024.
//

import Foundation
import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privasy
    case apiReferense
    case viewSeries
    case viewCode
}
// MARK: - Computed
extension RMSettingsOption {
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            nil
        case .contactUs:
            URL(string: "https://iosacademy.io")
        case .terms:
            URL(string: "https://iosacademy.io/terms")
        case .privasy:
            URL(string: "https://iosacademy.io/privacy")
        case .apiReferense:
            URL(string: "https://iosacademy.io")
        case .viewSeries:
            URL(string: "https://iosacademy.io")
        case .viewCode:
            URL(string: "https://iosacademy.io")
        }
    }
    
    var dispayTitle: String {
        switch self {
        case .rateApp:
            "Rate App"
        case .contactUs:
            "Contact Us"
        case .terms:
            "Terms of Servise"
        case .privasy:
            "Privacy Policy"
        case .apiReferense:
            "API Referense"
        case .viewSeries:
            "View Video Series"
        case .viewCode:
            "View App Code"
        }
    }
    var iconContainercolor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemGreen
        case .terms:
            return .systemBlue
        case .privasy:
            return .systemMint
        case .apiReferense:
            return .systemTeal
        case .viewSeries:
            return .systemPurple
        case .viewCode:
            return .systemYellow
        }
    }
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            UIImage(systemName: "star.fill")
        case .contactUs:
            UIImage(systemName: "paperplane")
        case .terms:
            UIImage(systemName: "doc")
        case .privasy:
            UIImage(systemName: "lock")
        case .apiReferense:
            UIImage(systemName: "list.clipboard")
        case .viewSeries:
            UIImage(systemName: "tv.fill")
        case .viewCode:
            UIImage(systemName: "hammer.fill")
        }
    }
    
}
