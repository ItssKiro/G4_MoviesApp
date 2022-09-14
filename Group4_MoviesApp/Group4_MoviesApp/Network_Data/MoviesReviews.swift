//
//  MoviesReviews.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI

final class MovieReviews: ObservableObject{
    @Published var reviews = [Reviews]()
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    private var movie: Movies
    
    init(movie: Movies) {
        self.movie = movie
    }
    
    func getMoviesReviews(){
        getReviews(for: movie)
    }
    
    private func getReviews(for movie: Movies){
        let urlSt = "https://api.themoviedb.org/3/movie/\(movie.id ?? 550)/reviews?api_key=0055eebfef49750b1b839a391428b202&language=en-US"
        networkManger<ReviewRes>.fetch(from: urlSt){(result) in
            switch result{
            case .success(let Response):
                self.reviews = Response.results
            case .failure(let err):
                print(err)
            }
        }
    }
}

