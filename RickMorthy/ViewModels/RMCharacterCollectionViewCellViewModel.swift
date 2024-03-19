//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 21.01.2024.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel: Hashable {
    
    public let characterName: String
    private let characterStatus: RMCharacter.Status
    private let characterImageUrl: URL?
    
    //MARK: - Init
    init(
        characterName: String,
        characterStatus: RMCharacter.Status,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return "Status: \(characterStatus.text)"
    }
    
    public func fetchImage(complition: @escaping (Result<Data, Error>) -> ()) {
        // TODO: - Abstract to Image Manager
        guard let url = characterImageUrl else {
            complition( .failure(URLError(.badURL)) )
            return
        }
        RMImageLoader.shared.downLoadImage(url, complition: complition)
    }
    
    // MARK: - Hasheble
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
