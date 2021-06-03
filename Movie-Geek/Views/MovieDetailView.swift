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
                    
                    ModalView(isOpen: self.$modalShown, maxHeight: geometry.size.height * 0.7) {
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(self.movie.title)
                                    .font(.headline).bold()
                                Spacer()
                                Text(self.movie.yearText)
                            }.padding(.bottom)
                            Text(self.movie.overview)
                            .multilineTextAlignment(.leading)
                            
                        }
                        .padding()
                        
                            HStack {
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

