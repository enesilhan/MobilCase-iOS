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
        self.title = "Products"
        setupCollectionView()
        setupBindings()
        viewModel.fetchProducts()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(UINib(nibName: "HorizontalProductCell",
                                      bundle: nil), forCellWithReuseIdentifier: "HorizontalProductCell")

        collectionView.register(UINib(nibName: "HeaderView",
                                          bundle: nil),
                                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                   withReuseIdentifier: HeaderView.reuseIdentifier)

        dataSource = UICollectionViewDiffableDataSource<Int, ProductSectionItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .horizontal(let product):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalProductCell",
                                                              for: indexPath) as! HorizontalProductCell
                cell.configure(with: product)
                return cell
            case .vertical(let product):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalProductCell",
                                                              for: indexPath) as! HorizontalProductCell
                cell.configure(with: product)
                return cell
            }
        }

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath) as! HeaderView

            let title = indexPath.section == 0 ? "Featured Products" : "All Products"
            headerView.configure(with: title)
            return headerView
        }
    }

    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.updateSnapshot()
        }

        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: errorMessage)
            }
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(170),
                                              heightDimension: .absolute(270))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(170),
                                               heightDimension: .absolute(270))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]

        return section
    }

    private func createVerticalLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                             heightDimension: .absolute(270))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(270))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                      subitem: item,
                                                      count: 2)
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource?.itemIdentifier(for: indexPath) else { return }
        let selectedProduct = item.product
        let detailVC = ProductDetailViewController(productID: selectedProduct.id ?? 0)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
