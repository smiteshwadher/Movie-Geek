//
//  MovieRatingView.swift
//  Movie-Geek
//
//  Created by Smitesh Wadher on 03/06/21.
//

import SwiftUI
struct MovieRatingView: View {
     var height: CGFloat = 10
    var value: Double = 0.0
    
    fileprivate func createPath(with size: CGSize) -> some View {
        return Rectangle()
            .frame(width: size.width, height: self.height, alignment: .leading).cornerRadius(self.height / 2)
            .foregroundColor(Color.gray.opacity(0.5))
    }
    
    fileprivate func createProgress(with size: CGSize) -> some View {
        return Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.accentColor, .red]) , startPoint: .leading, endPoint: .trailing))
            .animation(.easeIn(duration: 1))
            .frame(width: size.width * CGFloat(self.value) / 10, height: self.height, alignment: .leading)
            .cornerRadius(self.height / 2)
    }
    
    var body: some View {
        HStack {
            GeometryReader{ gr in
                ZStack(alignment: .leading) {
                    self.createPath(with: gr.size)
                    self.createProgress(with: gr.size)
                }
            }.frame(height: 15)
            
            Text("\(String(format: "%.1f", self.value))/10")
                .bold()
                .foregroundColor(Color.red)
        }
    }
}
struct LineRatingView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRatingView()
    }
}
