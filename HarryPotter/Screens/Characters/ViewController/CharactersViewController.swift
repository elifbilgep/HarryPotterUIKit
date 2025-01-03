//
//  CharactersViewController.swift
//  HarryPotter
//
//  Created by Elif Parlak on 2.01.2025.
//

import UIKit
import Combine

class CharactersViewController: UIViewController {
    //MARK: Section
    enum Section {
        case main
    }
    
    //MARK: Typealias
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, CharacterModel>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CharacterModel>
    
    //MARK: Properties
    private let charactersView = CharactersView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: CharactersViewModelProtocol
    private var dataSource: DataSource!
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: Init
    init(viewModel: CharactersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = charactersView
    }
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupSearchController()
        configureDataSources()
        setupBindings()
        viewModel.fetchCharacters()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let visibleCells = charactersView.collectionView.visibleCells as? [CharacterCell] {
            for cell in visibleCells {
                cell.updateFavoriteState()
            }
        }
    }
    
    //MARK: Setup View Controller
    private func setupViewController() {
        title = "Characters"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        charactersView.collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        charactersView.collectionView.delegate = self
    }
    
    //MARK: Setup Bindings
    private func setupBindings() {
        (viewModel as? CharactersViewModel)?
            .$characters
            .sink { [weak self] characters in
                self?.updateSnapshot(with: characters)
            }
            .store(in: &cancellables)
        
        viewModel.onError = { [weak self] error in
            self?.presentAlert(title: "Error occured!", message: error, buttonTitle: "Ok")
        }
    }
    
    //MARK: Setup Navigation
    private func setupNavigation() {
        let favoritesButton = UIBarButtonItem(
            image: UIImage(
                systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(favoritesButtonTapped)
        )
        favoritesButton.tintColor = .label
        navigationItem.rightBarButtonItem = favoritesButton
    }
    
    @objc private func favoritesButtonTapped() {
        let favoritesVC = FavoritesViewController()
        UIView.transition(with: navigationController!.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.navigationController?.pushViewController(favoritesVC, animated: false)
        }, completion: nil)
    }
    
    //MARK: Configure Data Sources
    private func configureDataSources() {
        dataSource = DataSource(
            collectionView: charactersView.collectionView,
            cellProvider: { (collectionView, indexPath, character) -> UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CharacterCell.identifier,
                    for: indexPath) as? CharacterCell else {
                    return nil
                }
                cell.configure(with: character)
                cell.delegate = self
                return cell
            })
    }
    
    //MARK: Update snapshot
    private func updateSnapshot(with characters: [CharacterModel], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(characters)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    //MARK: Filter Characters
    private func filterCharacters(for searchText: String) {
        let filteredCharacters = viewModel.characters.filter { character in
            return character.fullName.lowercased().contains(searchText.lowercased()) ||
            character.hogwartsHouse.rawValue.lowercased().contains(searchText.lowercased())
        }
        updateSnapshot(with: filteredCharacters)
    }
    
}

//MARK: UICollectionViewDataSource
extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard dataSource.itemIdentifier(for: indexPath) != nil else {
            return
        }
    }
}

//MARK: UISearchResultsUpdating
extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty else {
            updateSnapshot(with: viewModel.characters)
            return
        }
        filterCharacters(for: searchText)
    }
}

//MARK: Search
extension CharactersViewController {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Characters"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

//MARK: Character Cell Delegate
extension CharactersViewController: CharacterCellDelegate {
    func characterCell(_ cell: CharacterCell, didTapFavoriteFor character: CharacterModel) {
        let defaults = UserDefaultsManager.shared
        var favorites: [CharacterModel] = defaults.get([CharacterModel].self, forKey: UserDefaultsManager.Keys.favoriteCharacter) ?? []
        if let index = favorites.firstIndex(where: { $0.fullName == character.fullName }) {
            favorites.remove(at: index)
        } else {
            favorites.append(character)
        }
        defaults.save(favorites, forKey: .favoriteCharacter)
    }
}


