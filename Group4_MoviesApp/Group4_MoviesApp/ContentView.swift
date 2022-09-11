//
//  ContentView.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showS = false
    var body: some View {
        NavigationView{
            Group{
                HomeP()
            }.navigationBarTitle("Explore", displayMode: .automatic)
            .navigationBarItems(trailing: HStack{
                SettButton
            })
            .sheet(isPresented: $showS, content: {
                Settings(isPresented: $showS)
            })
        }
    }
    private var SettButton: some View {
        Button(action: {showS.toggle()}, label: {
            HStack{
                Image(systemName: "gear").imageScale(.large).foregroundColor(.gray)
                    .frame(width: 30, height: 30)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
