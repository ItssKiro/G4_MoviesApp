//
//  MovieNet.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import Foundation
import SwiftUI
import Alamofire

final class MovieNet: ObservableObject{
    @Published var mn: String?
    @Published var movieList = [Welcome]()
    
    func getMname(id: Int) -> String {
     AF.request("https://banqmisrproject.herokuapp.com/movies/2")
     .validate()
        .responseDecodable(of: Welcome.self) { (response) in
            guard let movie = response.value else { return }
            print(movie.movieName)
            self.mn = movie.movieName
        }
        return mn ?? "Check Again"
     }
    
    func getMList() -> Array<Any>{
        AF.request("https://banqmisrproject.herokuapp.com/movies/movieList")
         .validate()
         .responseDecodable(of: mRespList.self) {
        (response) in
         guard let mvs = response.value else {return }
            for movie in mvs.mList{
                self.movieList.append(movie)
          }
        }
        return movieList
     }
    
    
}
