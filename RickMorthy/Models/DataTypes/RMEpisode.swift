//
//  RMEpisode.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import Foundation

struct RMEpisode: Codable, RMEpisodeDataRender {
    let id: Int
    let name: String
    let air_date: StringDate
    let episode: String
    let characters: [StringURL]
    let url: StringURL
    let created: StringDate
}
