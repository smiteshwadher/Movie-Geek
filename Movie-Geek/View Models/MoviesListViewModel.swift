//
//  MoviesListViewModel.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI

class MoviesListViewModel: ObservableObject {
    @Published var movies: [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?

    // below is to access all the functions specified in DefaultMovieService
    private let movieService: MovieService
    
    init(movieService: MovieService = MovieStore.shared) {
        self.movieService = movieService
    }
    
    func loadMovies(with endpoint: MovieListEndpoint) {
        self.movies = nil
        self.isLoading = true
        // To call the fetchMovies functions from DefaultMovieSearch by passing the Endpoint i.e Now playing / trending
        self.movieService.fetchMovies(from: endpoint) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let response):
                self.movies = response.results
                
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
    
}
