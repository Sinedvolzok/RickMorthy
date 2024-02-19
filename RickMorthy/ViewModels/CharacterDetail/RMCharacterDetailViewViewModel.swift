//
//  RMCharacterDetailViewViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 26.01.2024.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    enum SectionType {
        case photoImage(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case information(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case episodes(viewModels: [RMCharacterEpisodesCollectionViewCellViewModel])
    }
    
    private let character: RMCharacter
    public var sections:[SectionType] = []
    
    // MARK: - Init
    init (character: RMCharacter) {
        self.character = character
        setUpSections()
    }
    /*
     status
     gender
     type
     species
     origin
     location
     created
     totalEpisodes
     */
    
    private func setUpSections() {
        sections = [
            .photoImage(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModels: [.init(value:character.status.text, title: "status"),
                                      .init(value:character.gender.rawValue, title: "gender"),
                                      .init(value:character.type, title: "type"),
                                      .init(value:character.species, title: "species"),
                                      .init(value:character.origin.name, title: "origin"),
                                      .init(value:character.location.name, title: "location"),
                                      .init(value:character.created, title: "created"),
                                      .init(value:"\(character.episode.count)", title: "totalEpisodes")]),
            .episodes(viewModels: character.episode.compactMap({
                return RMCharacterEpisodesCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased(with: .autoupdatingCurrent)
    }
    
    // MARK: - Layots
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 8,
            trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 8,
            trailing: 2)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(140)),
            subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
