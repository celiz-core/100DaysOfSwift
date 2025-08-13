//
//  RatingView.swift
//  Bookworm
//
//  Created by user276992 on 8/12/25.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    
    var label = ""
    var maximumRating = 5
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label : {
                    imageForNumber(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    func imageForNumber(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
