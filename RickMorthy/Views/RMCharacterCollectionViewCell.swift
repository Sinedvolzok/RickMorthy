//
//  RMCharacterCollectionViewCell.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 21.01.2024.
//

import UIKit

///Single cell for a character
class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterCollectionViewCell"
    
    private let charImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        [charImageView, nameLabel, statusLabel].forEach {( contentView.addSubview($0) )}
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            statusLabel.heightAnchor.constraint(equalToConstant: 40),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            charImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            charImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),
            charImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            charImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        /*
                    image
                    name
                    status
                    */
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        charImageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellViewModel) {
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.charImageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
