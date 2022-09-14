//
//  Reviews.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import Foundation


struct ReviewRes: Codable {
    var results: [Reviews]
}

struct Reviews: Codable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
