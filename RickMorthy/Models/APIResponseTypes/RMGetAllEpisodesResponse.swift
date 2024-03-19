//
//  RMGetAllEpisodesResponse.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.03.2024.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: StringURL?
        let prev: StringURL?
    }
    let info: Info
    let results: [RMEpisode]
}
