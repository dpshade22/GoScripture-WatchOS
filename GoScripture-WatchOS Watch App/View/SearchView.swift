//
//  SearchView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var resultsViewModel: ResultsViewModel

    @State var searchText = ""
    @State var isLoading: Bool = false
    @State private var showResults = false

    let searchBy: String
    var apiClient = GoScriptureAPI()

    var body: some View {
                VStack {
                    TextField("Search God's Word", text: $searchText)
                        .padding()
                        .onChange(of: searchText) {
                            handleSearchTextChange(searchText: searchText)
                        }
                        .navigationDestination(isPresented: $showResults, destination: {
                            ResultsView(resultsViewModel: resultsViewModel)
                        })
                    if searchText != "" && isLoading {
                        Text("Finding verses...")
                            .italic()
                    }
                }
        }
    
    func handleSearchTextChange(searchText: String) {
        isLoading = true
        Task {
            do {
                let fetchedScriptures = try await apiClient.fetchData(searchText: searchText, searchBy: searchBy)
                DispatchQueue.main.async {
                    resultsViewModel.scriptures = fetchedScriptures
                
                    WKInterfaceDevice.current().play(.success)
                    isLoading = false
                    showResults = true
                }
            } catch {
                print("Error: \(error)")
                isLoading = false
            }
        }
    }
}
#Preview {
    SearchView(resultsViewModel: ResultsViewModel(), searchBy: "Verse")
}
