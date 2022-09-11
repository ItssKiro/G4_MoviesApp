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
        "baseURL\(self.rawValue)?api_key=\(API.key)&language=en-US&page=1"
    }
}
