//
//  RMSearchViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 21.03.2024.
//

import UIKit
///Configurable controller to search
class RMSearchViewController: UIViewController {
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        let type: `Type`
    }
    private let config: Config
    // MARK: - Init
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
