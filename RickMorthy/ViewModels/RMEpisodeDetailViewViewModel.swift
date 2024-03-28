//
//  RMEpisodeDetailViewViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 12.03.2024.
//

import Foundation

protocol RMEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

final class RMEpisodeDetailViewViewModel {
    // MARK: - Private
    private let endpointUrl: URL?
    private var dataTyple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellViewModel])
        case characters(viewModel: [RMCharacterCollectionViewCellViewModel])
    }
    // MARK: - Public
    public weak var delegate: RMEpisodeDetailViewViewModelDelegate?
    public private(set) var cellViewModels: [SectionType] = []
    // MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    // MARK: - Private
    private func createCellViewModels() {
        guard let dataTyple else { return }
        let episode = dataTyple.episode
        let characters = dataTyple.characters
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: episode.created)
            ]),
            .characters(viewModel: characters.compactMap({
                return RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image))
            }))
        ]
    }
    /// Fetch beaking episode model
    public func fetchEpisodeData() {
        guard 
            let endpointUrl,
            let request = RMRequest(url: endpointUrl)
        else { return }
        RMService.shared.execute(
            request, 
            expecting: RMEpisode.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.fetchRelatedCharacter(episode: model)
            case .failure(let failure):
                print(String(describing: failure))
                break
            }
        }
    }
    
    private func fetchRelatedCharacter(episode: RMEpisode) {
        let characterUrls: [URL] = episode.characters.compactMap({
            URL(string: $0)
        })
        let requests: [RMRequest] = characterUrls.compactMap({
            RMRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [RMCharacter] = []
        for request in requests {
            group.enter()
            RMService.shared.execute(request, expecting: RMCharacter.self) { result in
                defer {
                    group.leave()
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                    break
                }
            }
        }
        
        group.notify(queue: .main) {
            self.dataTyple = (episode,characters)
        }
    }
}


