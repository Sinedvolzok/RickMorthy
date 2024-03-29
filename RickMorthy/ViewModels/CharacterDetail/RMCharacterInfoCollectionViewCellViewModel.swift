//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.02.2024.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    private let type: `Type`
    private let value: String
    
    public var title: String {
        type.displayTitle
    }
    public var displayValue: String {
        guard !value.isEmpty else { return "None" }
        if type == .created {
            let shortDate = ShortDateFormatter.formatDate(from: value)
            return shortDate
        }
        return value
    }
    
    public var iconImage: UIImage? {
        type.iconImage
    }
    
    public var tintColor: UIColor {
        type.tintColor
    }
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status: return .systemRed
            case .gender: return .systemBlue
            case .type: return .systemCyan
            case .species: return .systemMint
            case .origin: return .systemPink
            case .location: return .systemTeal
            case .created: return .systemBrown
            case .episodeCount: return .systemFill
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status: return UIImage(systemName: "bell")
            case .gender: return UIImage(systemName: "bell")
            case .type: return UIImage(systemName: "bell")
            case .species: return UIImage(systemName: "bell")
            case .origin: return UIImage(systemName: "bell")
            case .location: return UIImage(systemName: "bell")
            case .created: return UIImage(systemName: "bell")
            case .episodeCount: return UIImage(systemName: "bell")
            }
        }
        var displayTitle: String {
            switch self {
            case .status,.gender,.type,.species,.origin,.location,.created:
                return rawValue.uppercased()
            case .episodeCount: return "EPISODE COUNT"
            }
        }
    }
    init(value: String, type: `Type`) {
            self.value = value
            self.type = type
    }
}
