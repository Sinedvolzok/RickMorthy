//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.02.2024.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> ()) {
        guard let imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        RMImageLoader.shared.downLoadImage(imageUrl, complition: completion)
    }
}
