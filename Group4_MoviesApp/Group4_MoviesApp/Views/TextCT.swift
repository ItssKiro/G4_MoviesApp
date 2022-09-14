//
//  TextCT.swift
//  Group4_MoviesApp
//
//  Created by user206032 on 9/14/22.
//

import SwiftUI

struct RepresentedUILabelView: UIViewRepresentable {
    typealias UIViewType = UILabel
    
    var attributedText: NSAttributedString
    
    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        
        label.numberOfLines = 0
     
        label.lineBreakMode = .byTruncatingTail

        label.textAlignment = .justified
        
        label.allowsDefaultTighteningForTruncation = true
        
        // Compression resistance is important to enable auto resizing of this view,
        // that base on the SwiftUI layout.
        // Especially when the SwiftUI frame modifier applied to this view.
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        // Maybe this is not necessary.
        label.clipsToBounds = true
        
        return label
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        print(#fileID, #function)
        
        uiView.attributedText = attributedText
    }
    
}
