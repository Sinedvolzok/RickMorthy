//
//  RMSettingsViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit
import SwiftUI
import SafariServices
import StoreKit

/// Controller to show varios app options and settings
@available(iOS 16.0, *)
final class RMSettingsViewController: UIViewController {
    override func viewDidLoad() {
        setUpView()
        addSwiftUIContrioller()
    }
    @Environment(\.requestReview) private var requestReview
    /// An identifier for the three-step process the person completes before this app chooses to request a review.
    @AppStorage("processCompletedCount") var processCompletedCount = 0
    /// The most recent app version that prompts for a review.
    @AppStorage("lastVersionPromptedForReview") var lastVersionPromptedForReview = ""
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
        if let url = option.targetUrl {
            // Open Website
            let viewController = SFSafariViewController(url: url)
            present(viewController, animated: true)
        } else if option == .rateApp {
            // Show Rate
            if processCompletedCount >= 4, UIApplication.appVersion != lastVersionPromptedForReview {
                presentReview()
                
                // The app already displayed the rating and review request view. Store this current version.
                guard let currentAppVersion = UIApplication.appVersion else {
                    return
                }
                lastVersionPromptedForReview = currentAppVersion
            }
        }
    }
    
    private func presentReview() {
        
        Task {
            // Delay for two seconds to avoid interrupting the person using the app.
            try await Task.sleep(for: .seconds(2))
            await requestReview()
        }
    }
}
