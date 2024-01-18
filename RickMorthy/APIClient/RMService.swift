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
    private init() {}
    
    enum RMServiceError:Error {
        case failedToCreateRequest
        case failedToGetData
    }
    /// Send Rick & Morty API Call
    /// - Parameters:
    ///   - request: Reqest Instanse
    ///   - type: Type of object we expect to get back
    ///   - complition: Callback with data or error
    public func execute<T:Codable>(
        _ request: RMRequest,
        expecting type: T.Type,
        complition: @escaping (Result<T, Error>) -> () ) {
            guard let urlRequest = self.request(from: request) else {
                complition(.failure(RMServiceError.failedToCreateRequest))
                return
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                guard let data = data, error == nil else {
                    complition(.failure(error ?? RMServiceError.failedToGetData))
                    return
                }
                ///Decode Response
                do {
                    let result = try JSONDecoder().decode(type.self, from: data)
                    complition(.success(result))
                    
                } catch {
                    complition(.failure(error))
                }
            }
            task.resume()
        }
    
    // MARK: - Private
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
}

extension RMRequest {
    static let listCharactersRequests = RMRequest(endpoint: .character)
}
