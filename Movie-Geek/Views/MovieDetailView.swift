//
//  MovieDetailView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    
    let movieId: Int
    var movie: Movie
    
    // Observes the response fetched from ShowMovieDetailViewModel and fetches the data for the movie which has been clicked showing it in the modal view along with a poster image.
    @ObservedObject private var movieDetailState = ShowMovieDetailViewModel()
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        @State private var modalShown = false
    
    var body: some View {
        GeometryReader { geometry in
                    NavigationView() {
                        KFImage(source: .network(movie.posterURL))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
                            }
                    .navigationBarItems(leading: Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: { Image("back").foregroundColor(Color.white) } ))
                    
            // A modal view created so as to see the poster image bigger than what was displayed in the listing page.
                    ModalView(isOpen: self.$modalShown, maxHeight: geometry.size.height * 0.7) {
                        
                        VStack(alignment: .leading) {
                            HStack {
                                // To show title
                                Text(self.movie.title)
                                    .font(.headline).bold()
                                Spacer()
                                
                                // To show year of the movie released
                                Text(self.movie.yearText)
                            }.padding(.bottom)
                            
                            // Description of the movie
                            Text(self.movie.overview)
                            .multilineTextAlignment(.leading)
                            
                        }
                        .padding()
                        
                            HStack {
                                // Custom Rating view so as to show the vote average in a beautiful line.
                                
                                MovieRatingView(value: movie.voteAverage)
                            }
                            .padding()
                    }
                }.edgesIgnoringSafeArea(.all)
            }
    }

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieId: Movie.stubbedMovie.id, movie: Movie.stubbedMovie.self)
        }
    }
}

