//
//  DiscoverView.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI

struct DiscoverView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    @ObservedObject private var movieMGr = MovieDownloadManger()
    let spacing: CGFloat = 20
    let celbArr = Array(0...10)
    var body: some View {
        Color.clear.overlay(
        ZStack{
            Color.init(red: 26/255, green: 31/255, blue: 49/255).edgesIgnoringSafeArea(.all)
        GeometryReader{geo in
            return ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: spacing){
           
                    ForEach(movieMGr.movies){movie in
                        movieCard(movie: movie)
                            .frame(width:geo.size.width, height: geo.size.height)
                    }
                    
                }
            }
            .content.offset(x: self.offset, y: -55)
            .frame(width: geo.size.width, alignment: .leading)
            .gesture(
                DragGesture().onChanged({(value) in
                    self.offset = value.translation.width - geo.size.width * CGFloat(index)
                }).onEnded({value in
                    if -value.predictedEndTranslation.width > geo.size.width / 3, index < movieMGr.movies.count - 1{index += 1}
                    if value.predictedEndTranslation.width > geo.size.width / 3, index > 0{index -= 1}
                    withAnimation{
                        offset = -(geo.size.width + spacing) * CGFloat(index)
                    }
           
                })
            )
            .onAppear{
                movieMGr.getPopular()
            }
      
            
        }
    })
        
    }
    
    private func movieCard(movie: Movies) -> some View{
                   
        ZStack(alignment: .bottom){
          PosterBp(movie: movie)
            DiscDetails(movie: movie)
            Spacer()
        }.shadow(radius: 12.0).cornerRadius(12.0)
  
    }
    
    private func PosterBp(movie:Movies) -> some View{
        VStack{
        VStack{
        AsyncImages(url: URL(string: movie.poster_Path)!){
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
        } image: {
            (img) -> Image in
            Image(uiImage: img).resizable()
        }
        .animation(.easeIn(duration: 0.5)).transition(.slide).scaleEffect()
        .frame(width: UIScreen.main.bounds.width * 0.90, height: UIScreen.main.bounds.height * 0.80).cornerRadius(25).shadow(radius: 25)
        }
            
    }.padding().padding(.top, 1)
    }
    
    //-Mark: Details Card
    private func DiscDetails(movie: Movies) -> some View{
        VStack(alignment: .leading){
            Spacer()
            VStack(alignment: .leading){
                Text(movie.title ?? "n/a")
                    .font(.title).fontWeight(.semibold).foregroundColor(.black).padding(.horizontal).padding(.top)
                RepresentedUILabelView(attributedText: NSMutableAttributedString(string: movie.overview ?? ""))
                    .frame(width: 340, height: 55).padding(.horizontal).padding(.top)
                
                NavigationLink(destination: MovieDetails(movie: movie)){
                    Text("Details").bold().padding().foregroundColor(.white).background(Color.init(red: 26/255, green: 31/255, blue: 49/255).opacity(0.85)).cornerRadius(12)
                }.padding()
            }.background(Color.gray.opacity(0.89)).cornerRadius(11).lineLimit(2).padding()
        }.padding()
    }
    
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        
        DiscoverView()
    }
}
