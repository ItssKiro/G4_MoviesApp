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
        VStack{
            VStack(alignment: .leading){
                Text(tabs[selectionindex]).font(.largeTitle).bold().foregroundColor(.red).padding(.top)
                HStack{
                    Image(systemName: "magnifyingglass.circle").imageScale(.medium)
                    TextField("Search A Movie...", text: $searchterm).textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }.padding(.horizontal)
            
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
                                    $0.title?.lowercased().localizedStandardContains(searchterm.lowercased()) ?? true }) {movie in NavigationLink(destination: Text(movie.titlewithLang)) {
                        MovieSCell(movie: movie)
                        
                    }.listRowBackground(Color.clear)
                }
                
                }.onAppear{
                    moviesManger.getNowPL()
                }
            Spacer()
        }
    }
}

struct MoviewView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewView()
    }
}
