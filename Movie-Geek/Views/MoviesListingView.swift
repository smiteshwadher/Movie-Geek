//
//  MoviesListingView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject private var nowPlayingState = MoviesListViewModel()
    @ObservedObject private var popularState = MoviesListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCollectionView(title: "Now Playing", movies: nowPlayingState.movies!)
                        
                    } else {
                        MovieLoadingView(isLoading: self.nowPlayingState.isLoading, error: self.nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                    
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                
                Group {
                    if popularState.movies != nil {
                        MoviePosterCollectionView(title: "Popular", movies: popularState.movies!)
                        
                    } else {
                        MovieLoadingView(isLoading: self.popularState.isLoading, error: self.popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
                
                
                
            }
            .navigationBarTitle("Movie Geek")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.popularState.loadMovies(with: .popular)
        }
        
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}

