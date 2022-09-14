//
//  Actors.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import Foundation

struct ActorsRes: Codable {
    var cast: [Actors]
}

struct Actors: Codable, Identifiable {
    var id: Int?
    var name: String?
    var character: String?
    var profile_path: String?
    var profilePhoto: String{
        if let pth = profile_path{
            return "https://image.tmdb.org/t/p/original\(pth)"
        }else{return "https://picsum.photos/200/300"}
    }}
