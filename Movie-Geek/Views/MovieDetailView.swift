//
//  MovieDetailView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI
import URLImage

struct MovieDetailView: View {
    
    let movieId: Int
    var movie: Movie
    @ObservedObject private var movieDetailState = ShowMovieDetailViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
        @State private var modalShown = false
    
    var body: some View {
        GeometryReader { geometry in
                    NavigationView() {
                        URLImage(self.movie.posterURL) {
                            image in image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .edgesIgnoringSafeArea(.all)
                        }
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
                                if !movie.ratingText.isEmpty {
                                    Text(movie.ratingText).foregroundColor(.red)
                                }
                                Text(movie.scoreText)
                            }
                            .padding()
                            
                            HStack  {
                                if movie.cast != nil && movie.cast!.count > 0 {
                                    VStack {
                                        Text("Starring").font(.headline)
                                        ForEach(self.movie.cast!.prefix(9)) { cast in
                                            Text(cast.name)
                                        }
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Spacer()
                                    
                                }
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

