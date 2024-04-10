//
//  RMSettingsViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit
import SwiftUI

/// Controller to show varios app options and settings
final class RMSettingsViewController: UIViewController {
    override func viewDidLoad() {
        setUpView()
        addSwiftUIContrioller()
    }
    private let settingsController = UIHostingController(
        rootView: RMSettingsView(
            viewModel: RMSettingsViewViewModel(
                cellViewModels: RMSettingsOption.allCases.compactMap({
                    RMSettingsCellViewModel(type: $0)
                }))
        )
    )
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
    private func addSwiftUIContrioller() {
        addChild(settingsController)
        settingsController.didMove(toParent: self)
        
        view.addSubview(settingsController.view)
        settingsController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
