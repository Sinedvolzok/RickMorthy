//
//  RMAPICacheManager.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 10.03.2024.
//

import Foundation
///Manages in memory session API caches
final class RMAPICacheManager {
    // API URL: Data
    private var cacheDictionary: [RMEndpoint:NSCache<NSString, NSData>] = [:]
    private var cache = NSCache<NSString, NSData>()
    
    init() {
        setUpCache()
    }
    // MARK: - Public
    public func cacheResponse(for endpoint: RMEndpoint, url: URL?) -> Data? {
        guard
            let target = cacheDictionary[endpoint],
            let url
        else { return nil }
        let key = url.absoluteString as NSString
        let data = target.object(forKey: key) as? Data
        return data
    }
    public func setCache(for endpoint: RMEndpoint, url: URL?, data: Data) -> Void {
        guard
            let target = cacheDictionary[endpoint],
            let url
        else { return }
        let key = url.absoluteString as NSString
        target.setObject(data as NSData, forKey: key)
    }
    // MARK: - Private
    private func setUpCache() {
        RMEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}
