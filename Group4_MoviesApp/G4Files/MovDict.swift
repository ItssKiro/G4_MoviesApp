//
//  MovDict.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import Foundation

struct mRespList: Codable {
    let mList: [Welcome]
}
struct Welcome: Codable {
    let movieName, directorName, category: String
    let image, video: String
    let welcomeDescription: String
    let releasedYear: Int
    let addedDate: String
    let time: Int
    let age: String
    let actors: [Actor]

    enum CodingKeys: String, CodingKey {
        case movieName, directorName, category, image, video
        case welcomeDescription = "description"
        case releasedYear, addedDate, time, age, actors
    }
}

// MARK: - Actor
struct Actor: Codable {
    let actorName: String
    let actorID: Int
    let actorImagePath: String

    enum CodingKeys: String, CodingKey {
        case actorName
        case actorID = "actorId"
        case actorImagePath
    }
}
