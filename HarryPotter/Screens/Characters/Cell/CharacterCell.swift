//
//  CharactersCollectionViewCell.swift
//  HarryPotter
//
//  Created by Elif Parlak on 2.01.2025.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    func characterCell(_ cell: CharacterCell, didTapFavoriteFor character: CharacterModel)
}

class CharacterCell: UICollectionViewCell {
    //MARK: Properties
    weak var delegate: CharacterCellDelegate?
    private var character: CharacterModel?
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemBackground
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var houseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup Cell
    private func setupCell() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        containerView.addSubview(favoriteButton)
        stackView.addArrangedSubview(characterImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(houseLabel)
        
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Stack view constraints
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            
            // Character image view aspect ratio
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor, multiplier: 1.3),
            
            // favorite button
            favoriteButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24),
            ])
    }
    
    @objc private func favoriteButtonTapped() {
        guard let character else { return }
        delegate?.characterCell(self, didTapFavoriteFor: character)
        updateFavoriteState()
    }
    
    func updateFavoriteState() {
        let favorites = UserDefaultsManager.shared.get([CharacterModel].self, forKey: UserDefaultsManager.Keys.favoriteCharacter) ?? []
        let isFavorited = favorites.contains(where: { $0.fullName == character?.fullName })
        let heartImage = isFavorited ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteButton.setImage(heartImage, for: .normal)
        favoriteButton.tintColor = isFavorited ? .systemPink : .label
    }
    
    
    //MARK: Public func
    func configure(with character: CharacterModel) {
        self.character = character
        nameLabel.text = character.fullName
        houseLabel.text = character.hogwartsHouse.rawValue
        characterImageView.loadImage(from: character.image)
        updateFavoriteState()
    }
    
}
