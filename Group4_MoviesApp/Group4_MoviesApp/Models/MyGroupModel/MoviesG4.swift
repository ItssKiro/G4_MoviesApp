//
//  MoviesG4.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import Foundation

struct MoviesG4: Codable {
    let movieName, directorName, category: String
    let image, video: String
    let welcomeDescription: String
    let releasedYear: Int
    let addedDate: String
    let time: Int
    let age: String
    let actors: [Actor]
}

// MARK: - Actor
struct Actor: Codable {
    let actorName: String
    let actorID: Int
    let actorImagePath: String
}
