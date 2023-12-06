//
//  RMService.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 06.12.2023.
//

import Foundation

/// Primary API service object to get Rick & Morty data
final class RMService {
    /// Sared singleton instance
    static let shared = RMService()
    /// Privatise coordinator
    init() {}
    /// Send Rick & Morty API Call
    /// - Parameters:
    ///   - request: Reqest Instanse
    ///   - complition: Callback with data or error
    public func execute(_ request: RMRequest, complition: @escaping () -> () ) {}
}
