//
//  RMCharacterPhotoCollectionViewCell.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 13.02.2024.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static var cellIdentifer: String {
        return String(describing: self)
    }
    
    private let charImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(charImageView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            charImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            charImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            charImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            charImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        charImageView.image = nil
    }
    
    public func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.charImageView.image = UIImage(data: data)
                }
            case .failure(let error):
                break
            }
        }
        
    }
}
