//
//  SearchCard.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI
struct SearchCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.gray.opacity(0.0), radius: 20, x: 0, y: 0)
    }
    
}
