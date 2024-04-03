//
//  RMGetAllCharactersResponse.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 18.01.2024.
//

import Foundation

struct RMGetAllCharactersResponse: Decodable {
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: StringURL?
        let prev: StringURL?
    }
    let info: Info
    let results: [RMCharacter]
}
