//
//  MoviewView.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI

struct MoviewView: View {
    
    @State private var searchterm = ""
    @State private var selectionindex = 0
    @State private var tabs = ["Now Playing", "upcoming", "Trending"]
    @ObservedObject var moviesManger = MovieDownloadManger()
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
        UITabBar.appearance().backgroundColor = .init(red: 26/255, green: 31/255, blue: 49/255, alpha: 0.5)
        UITabBar.appearance().isTranslucent = true
        UITableViewCell.appearance().selectionStyle = .none
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
    }
    
    var body: some View {
        
        ZStack{
            Color.init(red: 26/255, green: 31/255, blue: 49/255).edgesIgnoringSafeArea(.all)
        VStack{
           
            VStack(alignment: .leading){
                Text(tabs[selectionindex]).font(.largeTitle).bold().foregroundColor(.white).padding(.top)
                HStack{
                    Image(systemName: "magnifyingglass.circle").imageScale(.medium).foregroundColor(.white)
                    TextField("Search A Movie...", text: $searchterm).background(Color.init(red: 46/255, green: 56/255, blue: 81/255)).foregroundColor(.white)}.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
            }.padding(.horizontal).padding(.top, 50)
            
            VStack{
                Picker("_", selection: $selectionindex){
                    ForEach(0..<tabs.count){
                        index in
                        Text(tabs[index]).font(.title).bold().tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle()).onChange(of: selectionindex){(_) in
                    switch selectionindex{
                    case 0:
                        moviesManger.getNowPL()
                    case 1:
                        moviesManger.getUpcoming()
                    case 2:
                        moviesManger.getPopular()
                    default:
                        moviesManger.getNowPL()
                    }
                }
            }.padding()
            
                List {
                    ForEach(moviesManger.movies.filter {
                                searchterm.isEmpty ? true :
                                    $0.title?.lowercased().localizedStandardContains(searchterm.lowercased()) ?? true }) {movie in NavigationLink(destination: MovieDetails(movie: movie)) {
                        MovieSCell(movie: movie)
                        
                    }.listRowBackground(Color.init(red: 26/255, green: 31/255, blue: 49/255))
                }
                
                }.onAppear{
                    moviesManger.getNowPL()
                }
            Spacer()
        }
        }.frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
    }}

struct MoviewView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewView()
    }
}
