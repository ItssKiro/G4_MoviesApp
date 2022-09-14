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
    var poster_path: String?
    var overview: String?
    var vote_average: Double
    var voteCount: Int?
    var runTime: Int?
    var releaseDate: String?
    var video: Bool?
    var adult: Bool?
    var original_language: String?
    var poster_Path: String{
        if let pth = poster_path{
            return "https://image.tmdb.org/t/p/original\(pth)"
        }else{return""}
    }
    var avgScTxt: String{
        
        return String(format: "%.1f", vote_average/2.0)
    }
    var avgSc: Double{
        
        return vote_average/2.0
    }
    
    
    var titlewithLang: String {
        guard let title = title, let lang = original_language else {return ""}
        return "\(title) (\(lang))"
    }
}
    
extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
