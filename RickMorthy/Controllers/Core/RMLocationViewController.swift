//
//  RMLocationViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit

/// Controller to serch and show for locations
final class RMLocationViewController: UIViewController {
    private let pimaryView = RMLocationView()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pimaryView)
        view.backgroundColor = .systemBackground
        title = "Location"
        addSearchButton()
        addConstraints()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(didTapSearch))
    }
    
    @objc
    private func didTapSearch() {
        print("Tap Search")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            pimaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pimaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pimaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pimaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }

}
