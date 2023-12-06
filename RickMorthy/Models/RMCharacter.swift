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
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: RMOrigin
    let location: RMCharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
