//
//  RMSettingsViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit

/// Controller to show varios app options and settings
final class RMSettingsViewController: UIViewController {
    private let viewModel = RMSettingsViewViewModel(
        cellViewModels: RMSettingsOption.allCases.compactMap({
            RMSettingsCellViewModel(type: $0)
        }))
    override func viewDidLoad() {
        setUpView()
    }
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        title = "Settings"
    }

}
