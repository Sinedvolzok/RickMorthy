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
    private let endpoint: RMEndpoint
    
    /// Patth components if any
    private let pathComponents: [String]
    /// Query arguments if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructin URL for API Request in String format
    public var urlString: StringURL {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({string += "\($0)"})
        }
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
    /// - Parameters:
    ///     - endpoint: Target endpoints
    ///     - pathComponents: Collection of path components
    ///     - queryParameters: Collection of query paramenets
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
         queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        guard string.contains(Constants.baseUrl) else { return nil }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            guard !components.isEmpty else { return nil }
            let endpointString = components[0]
            guard let rmEndpoint = RMEndpoint(rawValue: endpointString) else { return nil }
            self.init(endpoint: rmEndpoint)
            return
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            guard !components.isEmpty else { return nil }
            let endpointString = components[0]
            let queryItemsString = components[1]
            let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                guard $0.contains("=") else { return nil }
                let paths = $0.components(separatedBy: "=")
                return URLQueryItem(name: paths[0], value: paths[1])
            })
            guard let rmEndpoint = RMEndpoint(rawValue: endpointString) else { return nil }
            self.init(endpoint: rmEndpoint, queryParameters: queryItems)
            return
        }
        return nil
    }
}
