//
//  FavoritesViewController.swift
//  HarryPotter
//
//  Created by Elif Parlak on 3.01.2025.
//

import UIKit

class FavoritesViewController: UIViewController {
   private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       layout.scrollDirection = .vertical
       layout.minimumLineSpacing = 8
       layout.minimumInteritemSpacing = 8
       layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       cv.backgroundColor = .clear
       cv.translatesAutoresizingMaskIntoConstraints = false
       return cv
   }()
   
   private var favorites: [CharacterModel] = []
   
   override func viewDidLoad() {
       super.viewDidLoad()
       setupUI()
       loadFavorites()
   }
   
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       loadFavorites()
       collectionView.reloadData()
   }
   
   private func setupUI() {
       title = "Favorites"
       view.backgroundColor = .black
       view.addSubview(collectionView)
       collectionView.delegate = self
       collectionView.dataSource = self
       collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
       
       NSLayoutConstraint.activate([
           collectionView.topAnchor.constraint(equalTo: view.topAnchor),
           collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
       ])
   }
   
   private func loadFavorites() {
       favorites = UserDefaultsManager.shared.get([CharacterModel].self, forKey: .favoriteCharacter) ?? []
   }
}

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return favorites.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
           return UICollectionViewCell()
       }
       cell.configure(with: favorites[indexPath.item])
       cell.delegate = self
       return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let width = (collectionView.bounds.width - 24) / 2
       return CGSize(width: width, height: width * 1.5)
   }
}

extension FavoritesViewController: CharacterCellDelegate {
   func characterCell(_ cell: CharacterCell, didTapFavoriteFor character: CharacterModel) {
       if let index = favorites.firstIndex(where: { $0.fullName == character.fullName }) {
           favorites.remove(at: index)
           UserDefaultsManager.shared.save(favorites, forKey: UserDefaultsManager.Keys.favoriteCharacter)
           
           collectionView.performBatchUpdates {
               collectionView.deleteItems(at: [IndexPath(item: index, section: 0)])
           }
       }
   }
}
