//
//  HouseCollectionViewCell.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import UIKit

final class HouseCollectionViewCell: UICollectionViewCell {    
    //MARK: UIComponents
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let founderTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupCell() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        contentView.backgroundColor = .tertiarySystemFill
        contentView.addSubview(stackView)
        
        [emojiLabel, titleLabel, founderTitleLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            emojiLabel.heightAnchor.constraint(equalToConstant: 60),
            emojiLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // MARK: - Configure
    func configure(with house: House) {
        titleLabel.text = house.house
        emojiLabel.text = house.emoji
        founderTitleLabel.text = house.founder
    }
}
