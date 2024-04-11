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
    private var settingsController: UIHostingController<RMSettingsView>?
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = "Settings"
    }
    
    private func addSwiftUIContrioller() {
        let settingsController = UIHostingController(
            rootView: RMSettingsView(
                viewModel: RMSettingsViewViewModel(
                    cellViewModels: RMSettingsOption.allCases.compactMap({
                        RMSettingsCellViewModel(type: $0) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    }))
            )
        )
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
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else { return }
        switch option {
        case .rateApp:
            // do something
            let handling = UIButton()
        case .contactUs:
            // do something
            let handling = UIButton()
        case .terms:
            // do something
            let handling = UIButton()
        case .privasy:
            // do something
            let handling = UIButton()
        case .apiReferense:
            // do something
            let handling = UIButton()
        case .viewSeries:
            // do something
            let handling = UIButton()
        case .viewCode:
            // do something
            let handling = UIButton()
        }
    }
}
