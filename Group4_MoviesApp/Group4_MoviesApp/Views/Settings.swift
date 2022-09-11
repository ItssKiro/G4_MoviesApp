//
//  Settings.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/11/22.
//

import SwiftUI



struct Settings: View {
    @Binding var isPresented: Bool
    @State private var Selection = 1
 	
    var body: some View {
        NavigationView{
            Form{
                Picker(selection: $Selection, label: Text("Choose Your Favorite Genre")){
                    Text("Action").tag(1)
                    Text("Comedy").tag(2)
                    Text("Horror").tag(3)
                    Text("SciFi").tag(4)

                }
                Button(action:{
                    isPresented.toggle()
                }){
                    Text("Submit")
                }
            }
        }.navigationTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(isPresented: Binding<Bool>.constant(false))
    }
}
