//
//  ListingViewController.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import UIKit

class ListingViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel = ListingViewModel()
    private var dataSource: UICollectionViewDiffableDataSource<Int, ProductSectionItem>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        viewModel.fetchProducts()
    }

    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(UINib(nibName: "HorizontalProductCell",
                                      bundle: nil), forCellWithReuseIdentifier: "HorizontalProductCell")
        collectionView.register(UINib(nibName: "VerticalProductCell",
                                      bundle: nil), forCellWithReuseIdentifier: "VerticalProductCell")

        dataSource = UICollectionViewDiffableDataSource<Int, ProductSectionItem>(collectionView: collectionView) { collectionView, indexPath, item in

            switch item {
            case .horizontal(let product):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalProductCell",
                                                              for: indexPath) as! HorizontalProductCell
                cell.configure(with: product)
                return cell

            case .vertical(let product):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalProductCell",
                                                              for: indexPath) as! VerticalProductCell
                cell.configure(with: product)
                return cell
            }
        }
    }

    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.updateSnapshot()
        }
    }

    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ProductSectionItem>()
        snapshot.appendSections([0, 1])

        let horizontalItems = viewModel.getHorizontalProducts()
        let verticalItems = viewModel.getVerticalProducts()

        snapshot.appendItems(horizontalItems, toSection: 0)
        snapshot.appendItems(verticalItems, toSection: 1)

        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in

            if sectionIndex == 0 {
                return self.createHorizontalLayout()
            } else {
                return self.createVerticalLayout()
            }
        }
    }

    private func createHorizontalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }

    private func createVerticalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
}
