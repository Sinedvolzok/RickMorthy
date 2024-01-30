//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 21.01.2024.
//

import Foundation

final class RMCharacterCollectionViewCellViewModel {
    
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
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                complition( .failure(error ?? URLError(.badServerResponse)) )
                return
            }
            complition( .success(data) )
        }
        task.resume()
    }
}
