//
//  MovieLoadingView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI

// Loader to show before any response is fetched from the api call
struct MovieLoadingView: View {
    
    let isLoading: Bool
    let error: NSError?
    let retryAction: (() -> ())?
    
    var body: some View {
        Group {
            if isLoading {
                HStack {
                    Spacer()
                    LoaderView()
                    Spacer()
                }
            } else if error != nil {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Text(error!.localizedDescription).font(.headline)
                        if self.retryAction != nil {
                            Button(action: self.retryAction!) {
                                Text("Retry")
                            }
                            .foregroundColor(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct MovieLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        MovieLoadingView(isLoading: true, error: nil, retryAction: nil)
    }
}
