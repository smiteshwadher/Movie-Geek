//
//  MoviesPosterView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI

// A single poster view with movie poster image so that it just displays the image with the name.
struct MoviesPosterView: View {
    
    let movie: Movie
    
    // Observable object for imageLoader created so as to append the poster url to loadimage in the view
    @ObservedObject var imageLoader = ImageLoader()
    
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(width: 204, height: 306)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

struct MoviesPosterView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesPosterView(movie: Movie.stubbedMovie)
    }
}
