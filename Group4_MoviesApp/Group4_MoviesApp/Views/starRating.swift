//
//  starRating.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI

struct StarRating: View {
    struct ClipShape: Shape {
        let width: Double
        
        func path(in rect: CGRect) -> Path {
            Path(CGRect(x: rect.minX, y: rect.minY, width: CGFloat(width), height: rect.height))
        }
    }
    
    @Binding var rating: Double
    let maxRating: Int
    
    init(rating: Binding<Double>, maxRating: Int) {
        self.maxRating = maxRating
        self._rating = rating
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Text(Image(systemName: "star"))
                    .foregroundColor(.init(red: 190/255, green: 169/255, blue: 37/255))
                    .aspectRatio(contentMode: .fill)
            }
        }.overlay(
            GeometryReader { reader in
                HStack(spacing: 0) {
                    ForEach(0..<maxRating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(
                    ClipShape(width: Double((reader.size.width / CGFloat(maxRating)) * CGFloat(rating)))
                )
            }
        )
    }
}
