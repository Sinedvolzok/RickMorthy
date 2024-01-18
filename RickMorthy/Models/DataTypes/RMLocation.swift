//
//  RMLocation.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [StringURL]
    let url: StringURL
    let created: StringDate
}
