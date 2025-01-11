//
//  CharactersView.swift
//  HarryPotter
//
//  Created by Elif Parlak on 2.01.2025.
//

import UIKit

class CharactersView: UIView {
    
    //MARK: Properties
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Private Methods
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let padding: CGFloat = 16
        let itemWidth = (UIScreen.main.bounds.width - (padding * 3)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: padding, bottom: padding, right: padding)
        return layout
    }
}
