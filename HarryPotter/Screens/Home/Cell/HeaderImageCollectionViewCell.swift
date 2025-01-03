//
//  HeaderView.swift
//  HarryPotter
//
//  Created by Elif Parlak on 30.12.2024.
//

import UIKit

final class HeaderImageCollectionViewCell: UICollectionViewCell {    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            // Image View Constraints
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1)  
        ])
    }
    
    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
