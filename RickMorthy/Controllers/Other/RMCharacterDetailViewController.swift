//
//  RMCharacterDetailViewController.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 26.01.2024.
//

import UIKit
/// Controller to show info about sinngle character
class RMCharacterDetailViewController: UIViewController {
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    private let detailView: RMCharacterDetailView
    
    // MARK: - Init
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        addConstraints()
        addShareButton()
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    
    private func addShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare))
    }
    
    @objc
    private func didTapShare() {}
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - CollectionView

extension RMCharacterDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photoImage:
            return 1
        case .information(viewModels: let viewModel):
            return viewModel.count
        case .episodes(viewModels: let viewModel):
            return viewModel.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photoImage(viewModel: let viewModel):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterPhotoCollectionViewCell
            guard let cell else { fatalError() }
            cell.configure(with: viewModel)
            return cell
        case .information(viewModels: let viewModels):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifer,
                for: indexPath) as? RMCharacterInfoCollectionViewCell
            guard let cell else { fatalError() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .episodes(viewModels: let viewModels):
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RMCharacterEpisodesCollectionViewCell.cellIdentifier,
                for: indexPath) as? RMCharacterEpisodesCollectionViewCell
            guard let cell else { fatalError() }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
            
        case .photoImage,.information:
            break
        case .episodes:
            let episodes = self.viewModel.episodes
            let selection = episodes[indexPath.row]
            let vc = RMEpisodesDetailViewController(url: URL(string: selection))
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
