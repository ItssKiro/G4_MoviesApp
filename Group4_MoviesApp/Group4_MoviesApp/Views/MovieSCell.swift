//
//  MovieSCell.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI

struct MovieSCell: View {
    var movie: Movies
    
    var body: some View{
        HStack (alignment: .top, spacing: 20) {
        movieSImage
            VStack (alignment: .leading, spacing: 0){
                movieTitleLang
                HStack{Text("")}
                HStack{StarRating(rating: .constant(movie.avgSc), maxRating: 5).font(.system(size: 14))}
                LazyVStack(spacing: 10) {
                RepresentedUILabelView(attributedText: NSMutableAttributedString(string: movie.overview ?? ""))
                    .frame(width: 245, height: 100)}
        }
    }

  }
    private var movieSImage: some View{
       
        AsyncImages(url: URL(string: movie.poster_Path)!)
    {
        Rectangle().foregroundColor(Color.gray.opacity(0.4))
        
    }
    image: {(img) -> Image in Image(uiImage: img).resizable()}
    .frame(width: 100, height: 160)
    .animation(.easeIn(duration: 0.5)).transition(.opacity)
    .scaledToFit().cornerRadius(15).shadow(radius: 15)
        
        }
    private var movieTitleLang: some View{
        Text(movie.titlewithLang).font(.system(size: 15)).bold().fontWeight(.heavy).foregroundColor(.white)
    }

    
}
    
    
    
    
