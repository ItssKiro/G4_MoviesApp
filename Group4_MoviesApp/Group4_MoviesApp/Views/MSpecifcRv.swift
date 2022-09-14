//
//  MSpecifcRv.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI

struct MSpecifcRv: View {
    
    var movie: Movies
    @ObservedObject var movieRV: MovieReviews
    init(movie: Movies) {
        self.movie = movie
        self.movieRV = MovieReviews(movie: movie)
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .gray
        
    }
    
    var body: some View{
        ZStack(alignment: .top){
            Color.black.opacity(0.7)
           
            List{
               
                ForEach(movieRV.reviews){ review in
                    VStack{
                        Text(review.author ?? "").font(.title).bold()
                        Text(review.content ?? "").font(.body).foregroundColor(.white)
                           
                    }.foregroundColor(.yellow).listRowBackground(Color.clear).cornerRadius(35)
                }
            }.onAppear{
                movieRV.getMoviesReviews()
            }
            .padding(.top, 30).padding(.horizontal, 32)
        }.edgesIgnoringSafeArea(.all)
    }

}
