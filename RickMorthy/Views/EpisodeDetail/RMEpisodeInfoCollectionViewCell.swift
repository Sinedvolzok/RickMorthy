//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 26.03.2024.
//

import UIKit

final class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        [valueLabel,titleLabel].forEach(contentView.addSubview)
        setUpLayer()
        addConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    public func configure(with viewModel: RMEpisodeInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.32),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.57),
        ])
    }
}
