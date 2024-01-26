//
//  RMCharacterDetailViewViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 26.01.2024.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    init (character: RMCharacter) {
        self.character = character
    }
    public var title: String {
        character.name.uppercased(with: .autoupdatingCurrent)
    }
}
