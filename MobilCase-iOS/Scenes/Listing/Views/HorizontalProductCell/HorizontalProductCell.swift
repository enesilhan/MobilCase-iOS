//
//  HorizontalProductCell.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 17.03.2025.
//

import UIKit
import Kingfisher

class HorizontalProductCell: UICollectionViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupUI()
        }

        private func setupUI() {
            containerView.layer.borderWidth = 1
            containerView.layer.borderColor = UIColor.systemGray.cgColor
            containerView.layer.cornerRadius = 8
            
        }

    func configure(with product: Product) {
        titleLabel.text = product.title ?? ""
        priceLabel.text = product.price != nil ? String(format: "$%.2f", product.price!) : ""

        if let imageUrl = product.image, let url = URL(string: imageUrl) {
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
}
