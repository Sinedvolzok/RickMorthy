//
//  RMCharacterEpisodesCollectionViewCellViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.02.2024.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodesCollectionViewCellViewModel {
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> ())?
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else { return }
            dataBlock?(model)
        }
    }
    // MARK: - Init
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    // MARK: - Public
    public func registerForData(_ block: @escaping (RMEpisodeDataRender) -> ()) {
        self.dataBlock = block
    }
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
dataBlock?(model) }
            return
        }
        guard
            let url = episodeDataUrl,
            let request = RMRequest(url: url)
        else { return }
        isFetching = true
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure.localizedDescription))
            }
        }
    }
}
// MARK: - Protocols
extension RMCharacterEpisodesCollectionViewCellViewModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        guard let absStringUrl = self.episodeDataUrl?.absoluteString else {return}
        hasher.combine(absStringUrl)
    }
    static func == (lhs: RMCharacterEpisodesCollectionViewCellViewModel, rhs: RMCharacterEpisodesCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
