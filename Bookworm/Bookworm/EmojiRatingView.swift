//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by user276992 on 8/12/25.
//

import SwiftUI

struct EmojiRatingView: View {
    
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text(">:(")
        case 2:
            Text(":(")
        case 3:
            Text(":|")
        case 4:
            Text(":)")
        default:
            Text(":0")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}
