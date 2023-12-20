//
//  RMRequest.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 06.12.2023.
//

import Foundation

/// Object that represent a single API call
final class RMRequest {
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    let endpoint: RMEndpoint
    
    let pathComponents: Set<String>
    let queryParameters: [URLQueryItem]
    
    /// Constructin URL for API Request in String format
    public var urlString: StringURL {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else {fatalError("No value in URL")}
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public let httpMethod = "GET"
    
    public init(endpoint: RMEndpoint,
         pathComponents: Set<String> = [],
         queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
