//
//  Book.swift
//  HarryPotter
//
//  Created by Elif Parlak on 30.12.2024.
//

import Foundation

struct Book: Codable {
    let number: Int
    let title: String
    let originalTitle: String
    let releaseDate: String
    let description: String
    let pages: Int
    let cover: String
    let index: Int
    
    var releaseDateFormatted: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.date(from: releaseDate)
    }
}
