//
//  ResultsView.swift
//  GoScripture Watch App
//
//  Created by Dylan Price Shade on 9/3/23.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var resultsViewModel: ResultsViewModel

    var body: some View {
            List(resultsViewModel.scriptures) { result in
                NavigationLink(destination: ScriptureView(verse: result.verse, location: result.location)) {
                        Text(result.location)
                        .bold()
                        .italic()
                }
            }
    }
}

#Preview {
    ResultsView(resultsViewModel: ResultsViewModel())
}
