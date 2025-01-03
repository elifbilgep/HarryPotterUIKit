//
//  HomeViewModel.swift
//  HarryPotter
//
//  Created by Elif Parlak on 29.12.2024.
//

import Foundation
import Combine

//MARK: Protocol
protocol HomeViewModelProtocol {
    var numberOfHouses: Int { get }
    var numberOfBooks: Int { get }
    func fetchHouses()
    func fetchBooks()
    func house(at index: Int) -> House
    func book(at index: Int) -> Book
}

enum DataType {
    case housesData, booksData, charactersData
}

final class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    //MARK: Properties
    private let networkService: NetworkServiceProtocol
    @Published var houses: [House] = []
    @Published var books: [Book] = []
    @Published var error: String?
   
    //MARK: Callback Closures
    var errorPublisher = PassthroughSubject<String, Never>()
    var numberOfHouses: Int { houses.count }
    var numberOfBooks: Int { books.count }
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: Public methods
    func house(at index: Int) -> House {
        houses[index]
    }
    
    func book(at index: Int) -> Book {
        books[index]
    }
    
    func fetchHouses() {
        fetchData(endpoint: .houses) { [weak self] (fetchedData: [House]) in
            self?.houses = fetchedData
        }
    }
    
    func fetchBooks() {
        fetchData(endpoint: .books) { [weak self] (fetchedData: [Book]) in
            self?.books = fetchedData
        }
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
                await MainActor.run {
                                 self.error = error.localizedDescription  // Use the @Published error
                             }
                print("‼️ Error occurred: \(error)")
            }
        }
    }
}
