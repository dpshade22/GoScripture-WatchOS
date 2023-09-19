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
                    gradient: Gradient(colors: [Color(red: 255/255, green: 241/255, blue: 216/255), Color(red: 255/255, green: 251/255, blue: 243/255)]),
                startPoint: .top,
                endPoint: .bottomTrailing
            ))

    }
}

#Preview {
    TextGradient(text: "Text")
}
