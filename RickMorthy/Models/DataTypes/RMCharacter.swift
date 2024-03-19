//
//  RMCharacter.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import Foundation

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: RMOrigin
    let location: RMCharacterLocation
    let image: StringURL
    let episode: [StringURL]
    let url: StringURL
    let created: StringDate
    
    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
        
        var text: String {
            switch self {
            case .alive,.dead:
                return rawValue
            case .unknown:
                return "Unnown"
            }
        }
    }
    
    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }
}
