//
//  MovieDetails.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI
extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
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
                    reviewLink
                    castInfo
                    Spacer()
                }.padding(.top, 20).padding(.horizontal, 35)
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
            Text(movie.title ?? "n/a").font(.system(size: 15)).fontWeight(.heavy).foregroundColor(.white).frame(width: 240, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .leading)
            Text("                                  ")
            Image(systemName: "star.fill").foregroundColor(.yellow)
            
            Text("\(movie.avgScTxt)").font(.system(size: 15)).fontWeight(.heavy).foregroundColor(.yellow)
        }
    }
    
    private var moviePosterView: some View {
     HStack(alignment: .center) {
     Spacer()
     imageView.frame(width: 200, height: 290).cornerRadius(20)
     Spacer()
     }
    }
    
    private var movieOv: some View{
        LazyVStack(spacing: 10) {
        RepresentedUILabelView(attributedText: NSMutableAttributedString(string: movie.overview ?? ""))
                .frame(width: 350, height: 200)
        }
        
    }
    
    
     private var reviewLink: some View {
        HStack{
        NavigationLink(destination: MSpecifcRv(movie: movie)) {
            HStack {
                Text("Reviews").font(.system(size: 18)).fontWeight(.medium)
                    .foregroundColor(.white)
                
            }
     }
     Divider()
    }
     }
     
    private var castInfo: some View{
        VStack(alignment: .leading){
            Text("Movie Cast").font(.system(size: 18)).fontWeight(.medium)
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 20){
                    ForEach(movieManager.cast){cast in
                        VStack{
                            AsyncImages(url: URL(string: cast.profilePhoto)!){
                                Rectangle().foregroundColor(Color.gray.opacity(0.4)).cornerRadius(15)
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
