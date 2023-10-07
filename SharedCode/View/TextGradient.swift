//
//  TextGradient.swift
//  GoScripture Watch App
//
//  Created by Dylan Price Shade on 9/4/23.
//

import SwiftUI

struct TextGradient: View {
    @State var text: String
    var body: some View {
        Text(text)
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [Color("Foreground Brown"), Color("Foreground White")]),
                startPoint: .top,
                endPoint: .bottomTrailing
            ))

    }
}

#Preview {
    TextGradient(text: "Text")
}
