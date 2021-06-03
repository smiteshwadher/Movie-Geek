//
//  MoviesSearchView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI
import Kingfisher

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = SearchMovieViewModel()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchState.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                MovieLoadingView(isLoading: self.movieSearchState.isLoading, error: self.movieSearchState.error) {
                    self.movieSearchState.search(query: self.movieSearchState.query)
                }
                
                if self.movieSearchState.movies != nil {
                    ForEach(self.movieSearchState.movies!) { movie in
                        NavigationLink(destination: MovieDetailView(movieId: movie.id, movie: movie)) {
                            HStack(alignment: .center) {
                                KFImage(source: .network(movie.posterURL))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                    .padding(.all, 20)
                                
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.red)
                                    Text(movie.releaseDate!)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(.gray)
                                }
                                .padding(.trailing, 20)
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                            .modifier(SearchCard())
                            .padding(.all, 10)
                        }
                    }
                }
                
            }
            .onAppear {
                self.movieSearchState.startObserve()
            }
            .navigationBarTitle("Search")
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}

