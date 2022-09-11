//
//  Movies.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import Foundation


struct MovieResponse: Codable {
    var results: [Movies]
}



struct Movies: Codable, Identifiable {
    var id: Int?
    var title: String?
    var backdropPath: String?
    var PosterPath: String?
    var overview: String?
    var voteAverage: Double?
    var voteCount: Int?
    var runTime: Int?
    var releaseDate: String?
    var video: Bool?
    var adult: Bool?
    var original_language: String?
    var Poster_P: String{
        if let pth = PosterPath{
            return "https://image.tmdb.org/t/p/original/\(pth)"
        }else{return""}
    }
    var avgSc: Double{
        if let sc = voteAverage{
            return sc / 10.0
        }
        else {return 0.0}
    }
    var titlewithLang: String {
        guard let title = title, let lang = original_language else {return ""}
        return "\(title)(\(lang))"
    }
}