//
//  ProductDetailViewController.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 18.03.2025.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var ratingView: UIView!
    @IBOutlet private weak var ratingLabel: UILabel!
    
    private let viewModel: ProductDetailViewModel

    init(productID: Int) {
        self.viewModel = ProductDetailViewModel(productID: productID)
        super.init(nibName: "ProductDetailViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchProductDetail()
        setupUI()
    }

    private func setupUI() {
        ratingView.layer.cornerRadius = 13
    }

    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self, let product = self.viewModel.product else { return }
            self.categoryLabel.text = product.category ?? ""
            self.titleLabel.text = product.title ?? ""
            self.priceLabel.text = product.price != nil ? String(format: "$%.2f", product.price!) : ""
            self.descriptionLabel.text = product.description ?? ""
            self.ratingLabel.text = product.rating?.rate != nil ? String(format: "%.1f", product.rating!.rate!) : ""
            
            if let imageUrl = product.image, let url = URL(string: imageUrl) {
                self.imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            }
        }

        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showErrorAlert(message: errorMessage)
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
