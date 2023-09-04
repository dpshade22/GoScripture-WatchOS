//
//  ResultsView.swift
//  GoScripture Watch App
//
//  Created by Dylan Price Shade on 9/3/23.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var resultsViewModel: ResultsViewModel
    
    @Binding var selectedVerse: Int
    @Binding var selectedTab: Int
    
    var body: some View {
        NavigationView {
            TabView {
                List {
                    ForEach(0..<resultsViewModel.scriptures.count, id: \.self) { index in
                        let scripture = resultsViewModel.scriptures[index]
                        
                        Button(action: {
                            selectedVerse = index
                            selectedTab = 1
                        }) {
                            TextGradient(text: scripture.location)
                                .bold()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ResultsView(resultsViewModel: ResultsViewModel(), selectedVerse: .constant(0), selectedTab: .constant(0))
}
