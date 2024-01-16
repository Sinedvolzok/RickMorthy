//
//  RMCharacterViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 01.12.2023.
//

import UIKit

/// Controller to serch and show for caracters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        
        let request = RMRequest(
            endpoint: .character
        )
        print(request.url)
        
        RMService.shared.execute(request, expecting: String.self) { result in
            switch result {
            case .success: break
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }

}
