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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
