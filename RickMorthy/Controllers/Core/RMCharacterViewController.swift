//
//  RMCharacterViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit

/// Controller to serch and show for caracters
final class RMCharacterViewController: UIViewController, RMCharacterListViewDelegate {

    private let characterListView = RMCharacterListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: - RMChrarcterListViewDelegate
    
    func rmCharacterListView(_ characterLiestView: RMCharacterListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
