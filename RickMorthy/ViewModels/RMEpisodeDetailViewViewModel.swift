//
//  RMEpisodeDetailViewViewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 12.03.2024.
//

import Foundation

final class RMEpisodeDetailViewViewModel {
    private let endpointUrl: URL?
    // MARK: - Init
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    private func fetchEpisodeData() {
        guard 
            let endpointUrl,
            let request = RMRequest(url: endpointUrl)
        else { return }
        RMService.shared.execute(
            request, 
            expecting: RMEpisode.self
        ) { result in
            switch result {
            case .success(let seccess):
                print(String(describing: seccess))
            case .failure(let failure):
                print(String(describing: failure))
                break
            }
        }
    }
}
