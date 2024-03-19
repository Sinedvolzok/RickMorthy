//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.02.2024.
//

import UIKit

final class RMCharacterEpisodesCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.text = "05LP5643"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dooo Loo Poo"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let airDateLabel: UILabel = {
        let label = UILabel()
        label.text = "23 December 2019"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray.cgColor
        [seasonLabel,
         nameLabel,
         airDateLabel,
        ].forEach ({ contentView.addSubview($0) })
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDateLabel.text = nil
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            airDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            airDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
        ])
    }
    
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            // Main Queue
            print( data.name )
            print( data.episode )
            print( data.air_date )
            self?.seasonLabel.text = data.episode
            self?.nameLabel.text = "Episodes "+data.name
            self?.airDateLabel.text = "Aired on "+data.air_date
        }
        viewModel.fetchEpisode()
    }
}
