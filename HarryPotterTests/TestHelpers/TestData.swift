//
//  TestData.swift
//  HarryPotterTests
//
//  Created by Elif Parlak on 3.01.2025.
//

import Foundation
@testable import HarryPotter

enum TestData {
    // MARK: - Houses
    static let houses: [House] = [
        House(
            house: "Gryffindor",
            emoji: "🦁",
            founder: "Godric Gryffindor",
            colors: ["red", "gold"],
            animal: "Lion",
            index: 0
        ),
        House(
            house: "Slytherin",
            emoji: "🐍",
            founder: "Salazar Slytherin",
            colors: ["green", "silver"],
            animal: "Serpent",
            index: 1
        )
    ]
    
    static let singleHouse = houses[0]
    
    // MARK: - Network Responses
    static let validJSONResponse = """
        [
            {"house": "Gryffindor", "emoji": "🦁", "founder": "Godric Gryffindor", "colors": ["red", "gold"], "animal": "Lion", "index": 0},
            {"house": "Hufflepuff", "emoji": "🦡", "founder": "Helga Hufflepuff", "colors": ["yellow", "black"], "animal": "Badger", "index": 1},
            {"house": "Ravenclaw", "emoji": "🦅", "founder": "Rowena Ravenclaw", "colors": ["blue", "bronze"], "animal": "Eagle", "index": 2}
        ]
        """
    
    static let invalidJSONResponse = """
    {
        "house": "Invalid
    }
    """
    
    // MARK: - Errors
    static let networkError = NSError(domain: "com.test.network", code: -1, userInfo: [
        NSLocalizedDescriptionKey: "Network connection failed"
    ])
    
    static let decodingError = NSError(domain: "com.test.decoding", code: -2, userInfo: [
        NSLocalizedDescriptionKey: "Failed to decode response"
    ])
    
    // MARK: - URLs
    static let mockBaseURL = URL(string: "https://potterapi-fedeperin.vercel.app")!
    static let mockHouseEndpoint = mockBaseURL.appendingPathComponent("/houses")
}
