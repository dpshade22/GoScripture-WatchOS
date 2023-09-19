//
//  ResultsTabView.swift
//  GoScripture Watch App
//
//  Created by Dylan Price Shade on 9/4/23.
//

import SwiftUI

struct ResultsTabView: View {
    @ObservedObject var resultsViewModel: ResultsViewModel
    
    @Binding var selectedVerse: Int
    @State var count = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedVerse) {
                ForEach(0..<resultsViewModel.scriptures.count, id: \.self) { index in
                    let result = resultsViewModel.scriptures[index]
                    ScriptureView(verse: result.verse, location: result.location)
                        .tag(index)
                        .tabItem {
                            Label("Scripture \(index+1)", systemImage: "book")
                        }
                }
            }
        }
    #if os(watchOS)
        .tabViewStyle(.verticalPage)
    #endif
    }
}

#Preview {
    ResultsView(resultsViewModel: ResultsViewModel(), selectedVerse: .constant(0), selectedTab: .constant(0))
}
