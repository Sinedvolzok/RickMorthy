//
//  RMCharacterViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit

/// Controller to serch and show for caracters
final class RMCharacterViewController: UIViewController {
    
    private let characterListView = CharacterListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        view.addSubview(characterListView)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
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
    
}
