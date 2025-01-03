//
//  HomeViewController.swift
//  HarryPotter
//
//  Created by Elif Parlak on 28.12.2024.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    //MARK: Section
    private enum Section: Int, CaseIterable {
        case header
        case houses
        case books
        
        var title: String {
            switch self {
            case .header:
                ""
            case .houses:
                "Hogwarts Houses"
            case .books:
                "Books"
            }
        }
    }
    
    //MARK: Properties
    private let homeView = HomeView()
    private var viewModel: HomeViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    //MARK: Init
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        fetchData()
        setupBindings()
    }
    
    override func loadView() {
        view = homeView
    }
    
    private func fetchData() {
        viewModel.fetchHouses()
        viewModel.fetchBooks()
    }
    
    //MARK: Setup
    private func setupController() {
        homeView.collectionView.delegate = self
        homeView.collectionView.dataSource = self
    }
    
    //MARK: Setup Bindings
    private func setupBindings() {
        // update collection view when houses data changes
        
        
        (viewModel as? HomeViewModel)?
            .$houses
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.homeView.collectionView.reloadSections(IndexSet(integer: Section.houses.rawValue))
            }
            .store(in: &cancellables)
        
        
        (viewModel as? HomeViewModel)?
            .$books
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.homeView.collectionView.reloadSections(IndexSet(integer: Section.books.rawValue))
            }
            .store(in: &cancellables)
        
        // Subscribe to error updates
        (viewModel as? HomeViewModel)?
            .$error
                .compactMap { $0 }  // Filter out nil values
                .receive(on: DispatchQueue.main)
                .sink { [weak self] error in
                    self?.presentAlert(title: "Something is wrong.", message: error, buttonTitle: "Ok")
                }
                .store(in: &cancellables)
    }
    
}

//MARK: UICollectionViewDelegate & DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0}
        switch section {
        case .header:
            return 1
        case .houses:
            return viewModel.numberOfHouses
        case .books:
            return viewModel.numberOfBooks
        }
    }
    
    //MARK: Cell for item at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        }
        
        switch section {
        case .header:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderImageCollectionViewCell.identifier,
                                                          for: indexPath) as! HeaderImageCollectionViewCell
            cell.configure(imageName: traitCollection.userInterfaceStyle == .dark ? "hogwarts_header_dark" : "hogwarts_header_light")
            return cell
        case .houses:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HouseCollectionViewCell.identifier,
                                                          for: indexPath) as! HouseCollectionViewCell
            
            cell.configure(with: viewModel.house(at: indexPath.row))
            return cell
            
        case .books:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier,
                                                          for: indexPath) as! BookCollectionViewCell
            cell.configure(with: viewModel.book(at: indexPath.row))
            return cell
        }
    }
    
    //MARK: Supplementary Elements
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let section = Section(rawValue: indexPath.section) else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HeaderView.identifier,
            for: indexPath) as! HeaderView
        
        headerView.configure(with: section.title)
        return headerView
    }
    
}
