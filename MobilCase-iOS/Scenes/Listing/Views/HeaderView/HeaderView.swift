//
//  HeaderView.swift
//  MobilCase-iOS
//
//  Created by Enes İlhan on 18.03.2025.
//

import UIKit

class HeaderView: UICollectionReusableView {

    static let reuseIdentifier = "HeaderView"

    @IBOutlet private weak var titleLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
