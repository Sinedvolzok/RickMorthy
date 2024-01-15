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
    ///   - type: Type of object we expect to get back
    ///   - complition: Callback with data or error
    public func execute<T:Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        complition: @escaping (Result<T, Error>) -> () ) {}
    
    // MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { fatalError("Can't Get URL from Request") }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}
