//
//  SearchView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var resultsViewModel: ResultsViewModel
    @Binding var tabSelection: Int
    
    @State var searchText = ""
    @State var isLoading: Bool = false

    var apiClient = GoScriptureAPI()

    var body: some View {
                VStack {
                    TextField("Search God's Word", text: $searchText)
                        .padding()
                        .onChange(of: searchText) {
                            handleSearchTextChange(searchText: searchText)
                        }
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
                let fetchedScriptures = try await apiClient.fetchData(searchText: searchText)
                DispatchQueue.main.async {
                    resultsViewModel.scriptures = fetchedScriptures
                
                    WKInterfaceDevice.current().play(.success)
                    isLoading = false
                    tabSelection = 1
                }
            } catch {
                print("Error: \(error)")
                isLoading = false
            }
        }
    }
}

#Preview {
    SearchView(resultsViewModel: ResultsViewModel(), tabSelection: .constant(1))
}
