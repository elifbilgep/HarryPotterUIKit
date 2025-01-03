//
//  CharacterElement.swift
//  HarryPotter
//
//  Created by Elif Parlak on 2.01.2025.
//

import Foundation

import Foundation

// MARK: - CharacterElement
struct CharacterModel: Codable, Hashable {
    let fullName, nickname: String
    let hogwartsHouse: HogwartsHouse
    let interpretedBy: String
    let children: [String]
    let image: String
    let birthdate: String
    let index: Int
}

enum HogwartsHouse: String, Codable {
    case gryffindor = "Gryffindor"
    case hufflepuff = "Hufflepuff"
    case ravenclaw = "Ravenclaw"
    case slytherin = "Slytherin"
}
