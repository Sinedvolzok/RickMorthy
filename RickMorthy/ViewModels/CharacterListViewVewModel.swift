//
//  CaracterListViewVewModel.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 20.01.2024.
//

import UIKit

final class CharacterListViewViewModel: NSObject {
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(model.info.count))
                print(String(model.info.pages))
                print(String(model.results.first?.image ?? "NO IMAGE"))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier,
                                                            for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(
            characterName: "Didi",
            characterStatus: .alive,
            characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
        cell.configure(with: viewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-32)/2
        return CGSize(width: width, height: width*1.389)
    }
}
