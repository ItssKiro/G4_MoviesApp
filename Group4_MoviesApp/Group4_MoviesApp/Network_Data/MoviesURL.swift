//
//  MoviesURL.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import Foundation

enum moviesURL: String{
  case nowPlaying = "now_playing"
  case upcoming = "upcoming"
  case popular = "popular"
    public var urlString: String{
        "https://api.themoviedb.org/3/movie/\(self.rawValue)?api_key=\(API.key)&language=en-US&page=1"
    }
}
