//
//  HomeP.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI

struct HomeP: View {
    
    enum Tabs: Int{
        case Movie
        case Discover
    }
    
    @State private var SelectedTab = Tabs.Movie
    
    var body: some View {
        TabView(selection: $SelectedTab){
            MoviewView().tabItem{
                tabBarItem(title: "Movies", icon: "film")
            }.tag(Tabs.Movie)
            
            DiscoverView().tabItem{
                tabBarItem(title: "Discover", icon: "square.stack")
            }.tag(Tabs.Discover)
        }
    }
    
    private func tabBarItem(title: String, icon: String) -> some View{
        VStack{
            Image(systemName: icon).imageScale(.large)
            Text(title)
        }
    }
}

struct HomeP_Previews: PreviewProvider {
    static var previews: some View {
        HomeP()
    }
}
