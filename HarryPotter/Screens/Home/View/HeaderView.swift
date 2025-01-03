//
//  HeaderView.swift
//  HarryPotter
//
//  Created by Elif Parlak on 2.01.2025.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    
    // MARK: Private Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setupViews() {
        backgroundColor = .clear
        addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: Configure
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
}
