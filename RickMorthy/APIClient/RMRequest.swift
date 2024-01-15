//
//  RMRequest.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 06.12.2023.
//

import Foundation

/// Object that represent a single API call
final class RMRequest {
    ///API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    /// Desired endpoints
    let endpoint: RMEndpoint
    
    /// Patth components if any
    let pathComponents: [String]
    /// Query arguments if any
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
    ///Computed & constracted API url
    public var url: URL? {
        return URL(string: urlString)
    }
    ///Desired htttp method
    public let httpMethod = "GET"
    
    // MARK:  - Public
    
    ///Construct request
    ///- Parameters:
    /// - endpoint: Collection path components
    /// - query: Collection query paramenets
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
