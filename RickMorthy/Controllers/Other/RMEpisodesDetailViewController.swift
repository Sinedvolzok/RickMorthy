//
//  RMEpisodesDateilViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 07.03.2024.
//

import UIKit
///VC to show detals about single episode
final class RMEpisodesDetailViewController: UIViewController {
    private let viewModel: RMEpisodeDetailViewViewModel
    // MARK: - Init
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "EPISODE"
    }
}
