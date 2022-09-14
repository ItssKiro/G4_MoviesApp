//
//  MovieDetails.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI

struct MovieDetails: View {
    @StateObject private var loader: ImagesLoader
    @ObservedObject private var movieManager = MovieDownloadManger()
    var movie: Movies
    
    init(movie: Movies) {
    self.movie = movie
        _loader = StateObject(wrappedValue: ImagesLoader(url: URL(string: movie.poster_Path)!, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View{
        ZStack(alignment: .top){
            bgview
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                    header
                    moviePosterView
                    Divider()
                    movieOv
                    Divider()
                    reviewLink
                    Divider()
                    castInfo
                    Spacer()
                }.padding(.top, 84).padding(.horizontal, 32)
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    private var bgview: some View{
        imageView.onAppear{
            loader.load()
        }.blur(radius: 100)
    }
    private var imageView: some View{
        Group{
            if loader.image != nil {
                Image(uiImage:  loader.image!).resizable()
            } else {
                Rectangle().foregroundColor(Color.gray.opacity(0.4))
            }
        }
    }
    
    private var header: some View{
        HStack{
            Text(movie.title ?? "n/a")
            Text("                           ")
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Text("\(movie.avgSc)")
        }
    }
    
    private var moviePosterView: some View {
     HStack(alignment: .center) {
     Spacer()
     imageView.frame(width: 200, height: 320).cornerRadius(20)
     Spacer()
     }
    }
    
    private var movieOv: some View{
        LazyVStack(spacing: 10) {
        RepresentedUILabelView(attributedText: NSMutableAttributedString(string: movie.overview ?? ""))
                .frame(width: 350, height: 200)}
        
        //Text(movie.overview ?? "n/a").font(.body).foregroundColor(.white).fixedSize(horizontal: false, vertical: true).padding(.top, 16)
        
    }
    
    
     private var reviewLink: some View {
     VStack {
     Divider()
     NavigationLink(destination: Text("Some review")) {
     HStack {
     Text("Reviews")
     .font (.body).fontWeight(.medium)
     .foregroundColor(.white)
     Spacer()
     
     }
     
     }
     Divider()
     }
    }
     
    private var castInfo: some View{
        VStack(alignment: .leading){
            Text("Movie Cast").foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 20){
                    ForEach(movieManager.cast){cast in
                        VStack{
                            AsyncImages(url: URL(string: cast.profilePhoto)!){
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                            } image: {
                                (img) -> Image in
                                Image(uiImage: img).resizable()
                            }
                            .frame(width: 100, height: 160).animation(.easeIn(duration: 0.5)).transition(.opacity).scaledToFill().cornerRadius(15).shadow(radius: 15)
                            Text("\(cast.name ?? "n/a") as \(cast.character ?? "n/a")").font(.caption).foregroundColor(.white).frame(width: 100).fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }.onAppear{
            movieManager.getCast(for: movie)
        }
    }
    
}
