//
//  MoviesPosterCollectionView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI

// A Horizontal scrollable collection view to show the list of Now playing movies and popular movies in the home page of Movie Geek
struct MoviePosterCollectionView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination:
                                        // When any section is clicked on the collection view it navigates the user to the detail page to show the overview of the movie along with the rating view
                                        MovieDetailView(movieId: movie.id, movie: movie)) {
                            // Meanwhile the Poster view which shows the movie poster image at each cell
                            MoviesPosterView(movie: movie)
                        }.buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                            .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
        
    }
}

struct MoviePosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCollectionView(title: "Now Playing", movies: Movie.stubbedMovies)
    }
}

