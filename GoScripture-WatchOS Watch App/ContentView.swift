//
//  ContentView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var resultsViewModel = ResultsViewModel()

    @State private var searchBy: String = "verse"
    @State private var showResults = false

    var body: some View {
        NavigationStack {
            VStack {
                SearchView(resultsViewModel: resultsViewModel, searchBy: searchBy)
                Spacer()
                
                if resultsViewModel.scriptures != [] {
                    Button {
                      showResults = true
                    } label: {
//                      Image("Logo")
//                        .resizable()
//                        .frame(width: 50, height: 50)
//                        .clipShape(Circle())
                        Text("Back to Results")
                            .italic()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .navigationDestination(isPresented: $showResults, destination: {
                        ResultsView(resultsViewModel: resultsViewModel)
                    })
                }
            }
            
        }
        .background(Material.thick)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.brown, Color.gray]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

#Preview {
    ContentView()
}
