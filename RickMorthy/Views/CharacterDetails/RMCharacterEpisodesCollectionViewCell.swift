//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.02.2024.
//

import UIKit

final class RMCharacterEpisodesCollectionViewCell: UICollectionViewCell {
    static var cellIdentifer: String {
        return String(describing: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemCyan
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel) {
        viewModel.registerForData { data in
            print( data.name )
            print( data.episode )
            print( data.air_date )
        }
        viewModel.fetchEpisode()
    }
}
