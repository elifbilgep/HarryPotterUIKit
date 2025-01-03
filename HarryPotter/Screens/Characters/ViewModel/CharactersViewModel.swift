//
//  CharactersViewModel.swift
//  HarryPotter
//
//  Created by Elif Parlak on 2.01.2025.
//

import Foundation
import Combine

protocol CharactersViewModelProtocol {
    var characters: [CharacterModel] { get set }
    var onCharactersUpdated: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    func fetchCharacters()
    func character(at index: Int) -> CharacterModel
    
}

final class CharactersViewModel: CharactersViewModelProtocol, ObservableObject {
    //MARK: Properties
    private let networkService: NetworkServiceProtocol
    @Published var characters: [CharacterModel] = []
    var errorPublisher = PassthroughSubject<String, Never>()
    #warning("bunu published yap")
    
    //MARK: Callbacks
    var onCharactersUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: Public funcs
    func fetchCharacters() {
        fetchData(endpoint: .characters) { [weak self] (fetchedData: [CharacterModel]) in
            guard let self else { return }
            self.characters = fetchedData
        }
    }
    
    func character(at index: Int) -> CharacterModel {
        characters[index]
    }
    
    //MARK: Private methods
    private func fetchData<T: Decodable>(endpoint: APIEndpoint, completion: @escaping ([T]) -> Void) {
        Task {
            do {
                let fetchedData: [T] = try await networkService.fetch(endpoint: endpoint)
                await MainActor.run {
                    completion(fetchedData)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorPublisher.send(error.localizedDescription)
                }
                print("‼️ Error occurred: \(error)")
            }
        }
    }
}
