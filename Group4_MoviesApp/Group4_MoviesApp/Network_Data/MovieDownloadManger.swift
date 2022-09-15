//
//  MovieDownloadManger.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI

final class MovieDownloadManger: ObservableObject
{
    @Published var movies = [Movies]()
    @Published var cast = [Actors]()
    
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    func getNowPL(){
        getMovies(movieURL: .nowPlaying)
    }
    
    func getUpcoming(){
        getMovies(movieURL: .upcoming)
    }
    
    func getPopular(){
        getMovies(movieURL: .popular)
    }
    
    func getCast(for movie: Movies){
        let urlSt = "https://api.themoviedb.org/3/movie/\(movie.id ?? 550)/credits?api_key=0055eebfef49750b1b839a391428b202"
        networkManger<ActorsRes>.fetch(from: urlSt){(result) in
            switch result{
            case .success(let Response):
                self.cast = Response.cast
            case .failure(let err):
                print(err)
            }
        } //
    }
    
    func getCeleb(for celb: [Int]){
        for i in 0..<celb.count{
            let castUrl = "https://api.themoviedb.org/3/person/\(i)/?api_key=0055eebfef49750b1b839a391428b202&language=en-US"
            networkManger<ActorsRes>.fetch(from: castUrl){(result) in
                switch result{
                case .success(let Response):
                    self.cast = Response.cast
                case .failure(let err):
                    print(err)
                }
            } //
        }
        }
        
    
    
    private func getMovies(movieURL: moviesURL){
        networkManger<MovieResponse>.fetch(from: movieURL.urlString){(result) in
            switch result{
            case .success(let movieResponse):
                self.movies = movieResponse.results
            case .failure(let err):
                print(err)
            }
        }
    }
}
