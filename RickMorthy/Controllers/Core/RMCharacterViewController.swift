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
            endpoint: .character,
            queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive")
            ]
        )
        print(request.url ?? "FAIL!")
        
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
        }
    }

}
