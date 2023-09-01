//
//  ScriptureView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct ScriptureView: View {
    let verse: String
    let location: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(location)
                    .font(.headline)
                Text(verse)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .italic()
            }
            .padding()
        }
    }
}

#Preview {
    ScriptureView(verse: "He loved the world", location: "John")
}
