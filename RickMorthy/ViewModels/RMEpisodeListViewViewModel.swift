//
//  RMEpisodeListViewViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 12.03.2024.
//

import Foundation
import UIKit

protocol RMEpisodeListViewViewModelDelegate: AnyObject {
    func didLoadInitialEpisodes()
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath])
    func didSelectEpisode(_ episode: RMEpisode)
}
///View model to handle episode list view logic
final class RMEpisodeListViewViewModel: NSObject {
    
    public weak var delegate: RMEpisodeListViewViewModelDelegate?
    
    private var isLoadinMoreEpisodes = false
    
    private var episodes: [RMEpisode] = [] {
        didSet {
            for episode in episodes {
                let viewModel = RMCharacterEpisodesCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: episode.url)
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [RMCharacterEpisodesCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllEpisodesResponse.Info? = nil
    ///Set initial set of chareactrs (20)
    public func fetchEpisodes() {
        RMService.shared.execute(.listEpisodesRequests,
                                 expecting: RMGetAllEpisodesResponse.self) { result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self.episodes = results
                self.apiInfo = info
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialEpisodes()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    /// Paginate if additional episodes are needed
    public func fetchAdditionalEpisodes(url: URL) {
        guard !isLoadinMoreEpisodes else { return }
        isLoadinMoreEpisodes = true
        print("Fetching More Episodes:")
        guard let request = RMRequest(url: url) else {
            isLoadinMoreEpisodes = false
            print("Failed to create request")
            return
        }
        RMService.shared.execute(request,
                                 expecting: RMGetAllEpisodesResponse.self)
        { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let responseModel):
                print("Pre-update: \(self.cellViewModels.count)")
                let moreResults = responseModel.results
                let info = responseModel.info
                self.apiInfo = info
                let originalCount = self.episodes.count
                let newCount = moreResults.count
                let total = originalCount + newCount
                let startingIndex = total - newCount
                let indexPathToAdd: [IndexPath] = Array(startingIndex..<(startingIndex + newCount))
                    .compactMap ({ return IndexPath(row: $0, section: 0) })
                self.episodes.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreEpisodes(with: indexPathToAdd)
                    self.isLoadinMoreEpisodes = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self.isLoadinMoreEpisodes = false
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}

// MARK: - CollectionView

extension RMEpisodeListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RMCharacterEpisodesCollectionViewCell.cellIdentifier,
            for: indexPath) as? RMCharacterEpisodesCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-18)
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
                shouldShowLoadMoreIndicator,
                let footer = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: RMFooterLoaderCollectionReusableView.identifier,
                    for: indexPath) as? RMFooterLoaderCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        delegate?.didSelectEpisode(episode)
    }
}
// MARK: - ScrollView
extension RMEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
            !isLoadinMoreEpisodes,
            !cellViewModels.isEmpty,
            let nextUrlString = apiInfo?.next,
            let url = URL(string: nextUrlString) else { return }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] time in
            let offset = scrollView.contentOffset.y
            let totalContentHeigth = scrollView.contentSize.height
            let totalScrollViewFixedHeigth = scrollView.frame.size.height
            if offset >= (totalContentHeigth - totalScrollViewFixedHeigth - 120) {
                self?.fetchAdditionalEpisodes(url: url)
            }
            time.invalidate()
        }
    }
}
